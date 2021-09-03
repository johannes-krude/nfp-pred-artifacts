# syntax=docker/dockerfile:1
FROM ubuntu:20.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git build-essential libjudy-dev libpcap-dev ruby libtrollop-ruby binutils-dev libiberty-dev libelf-dev pbzip2 texinfo openssh-client bison flex libssl-dev z3 wget clang llvm python sudo linux-headers-generic gnuplot texlive-full
RUN chmod a+rw /etc/passwd /etc/group
ENTRYPOINT ["/bin/sh", "-c" , "echo user:x:$(id -u):$(id -g):,,,:/nfp-pred-artifacts:/bin/bash >> /etc/passwd && echo user:x:$(id -g): >> /etc/group && HOME=/nfp-pred-artifacts exec /bin/bash"]

