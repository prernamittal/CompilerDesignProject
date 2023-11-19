%{
#include "bison.tab.h"
%}

%%
[-+*/=<>!&|^%()[\]{}.,;:?~] { return yytext[0]; };
"module"    return MODULE;
"endmodule" return ENDMODULE; 
"input"     return INPUT; 
"output"    return OUTPUT; 
"inout"     return INOUT; 
"reg"       return REG; 
"always"    return ALWAYS; 
"initial"   return INITIAL; 
"wire"      return WIRE; 
"begin"     return BEGINN; 
"end"       return END; 
"if"        return IF; 
"else"      return ELSE; 
"or"        return OR;
"posedge"   return POSEDGE;
"negedge"   return NEGEDGE;
[0-9]+ return NUM;
[a-zA-Z][a-zA-Z0-9_]* return ID;
[^ \n\t] return yytext[0];
%%

int yywrap() {
    return 1;
}


