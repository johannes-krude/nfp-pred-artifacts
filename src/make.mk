
SRC_DIR=./src
BUILD_DIR=./build

CC=gcc -g
CXX=g++ -g
LD=gcc
CFLAGS= -MD -fPIC --std=gnu11 -O2 -Wall -Ibuild -Isrc -D_GNU_SOURCE -DJSMN_STRICT -DJSMN_PARENT_LINKS
CXXFLAGS= -MD -std=gnu++17 -O0 -Ibuild -Isrc -Wall -Wextra -Wsuggest-override -Wno-unused-parameter
LDFLAGS= -L ./build -fuse-ld=gold -DGIT_VERSION='$(GIT_VERSION)' -DGIT_STATUS='$(GIT_STATUS)' -DCOMPILE_DATE=\"$(COMPILE_DATE)\"
LDLIBS= 

GIT_VERSION := "$(shell git show -s --oneline --no-abbrev-commit | sed "s/\([\\']\)/\\\\\\1/g")"
GIT_STATUS := "$(shell git status -s)"
COMPILE_DATE := "$(shell date --rfc-3339=seconds)"


-include $(SRC_DIR)/deps.mk


.PHONY: build build-clean
.SECONDEXPANSION:

build: $(BUILD_TARGETS)

build-clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR)/%: $(BUILD_DIR)/main_%.o $$($$*_OBJS) $(SRC_DIR)/version.inc.c
	$(LD) $(LDFLAGS) $($*_LDFLAGS) -o $@ $^ $(LDLIBS) $($*_LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $($*_CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.c
	$(CC) $(CFLAGS) $($*_CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $($*_CXXFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $($*_CXXFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.lex.cpp $(BUILD_DIR)/%.lex.hpp: $(SRC_DIR)/%.l
	@mkdir -p $(@D)
	flex -o $(BUILD_DIR)/$*.lex.cpp --header-file=$(BUILD_DIR)/$*.lex.hpp $<

$(BUILD_DIR)/%.tab.cpp $(BUILD_DIR)/%.tab.hpp: $(SRC_DIR)/%.ypp
	@mkdir -p $(@D)
	bison -tdv -o $(BUILD_DIR)/$*.tab.cpp $<

-include $(BUILD_DIR)/*.d
-include $(BUILD_DIR)/*/*.d
