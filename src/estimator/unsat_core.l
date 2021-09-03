%option noinput nounput noyywrap 8bit nodefault
%option prefix="unsat_core"
%option reentrant bison-bridge

%{
#include "estimator/unsat_core.tab.hpp"

#include <cstring>
%}

%%
[a-zA-Z0-9_]+ {
	yylval->str = strdup(yytext);
	return Id;
}
[\t\n ] {
}
. {
	return yytext[0];
};
%%

