%option noinput nounput noyywrap 8bit nodefault
%option prefix="model"
%option reentrant bison-bridge

%{
#include "estimator/model.tab.hpp"

#include <cstring>
%}

%%
\(model      {return model;}
\(define-fun {return define_fun;}
\(Array      {return array;}
\(ite        {return ite;}
\(=          {return eq;}
#unspecified {return unspecified;}
Bool         {return bool_;}

\(_[\t\n ]+as-array {
	return as_array;
}
\(\(as[\t\n ]+const[\t\n ]+\(Array[\t\n ]+\(_[\t\n ]+BitVec[\t\n ]+32\)[\t\n ]+\(_[\t\n ]+BitVec[\t\n ]+32\)\)\)[\t\n ]+#x00000000\) {
	return as_const32x0;
}
\(_[\t\n ]+BitVec[\t\n ]+(6[0-4]|[1-5]?[0-9])\) {
	return bitvec;
}
#x[0-9a-f]{1,16} {
	sscanf(yytext, "#x%lx", &yylval->uint64);
	return BV;
}
#b[01]{1,64} {
	yylval->uint64 = 0;
	for (size_t i = 0; i < 64 && yytext[2+i]; i++) {
		yylval->uint64 <<= 1;
		if (yytext[2+i] == '1')
			yylval->uint64 += 1;
	}
	return BV;
}
0|[1-9][0-9]+ {
	sscanf(yytext, "%lu", &yylval->uint64);
	return Number;
}
true|false {
	yylval->uint64 = false;
	if (!strcmp(yytext, "true"))
		yylval->uint64 = true;
	return Boolean;
}
[a-z][a-zA-Z0-9_!]* {
	yylval->str = strdup(yytext);
	return Name;
}
[\t\n ] {
}
. {
	return yytext[0];
};
%%

