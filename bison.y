%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
%}

%define parse.error verbose
%token OR MODULE ENDMODULE INPUT OUTPUT INOUT ALWAYS INITIAL WIRE POSEDGE NEGEDGE ASSIGN IF ELSE BEGINN END REG 
%token ID NUM

%left '|'  
%left '&' 
%left '^' 
%left '=' '<' '>' 
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS 

%%
Program : ModuleDefinition {printf("Valid Code\n"); exit(0);} ;

ModuleDefinition : MODULE ID '(' PortList ')' ';' ModuleItems ENDMODULE;

PortList : /* empty */
         | PortDeclaration ',' PortList
         | PortDeclaration ;

PortDeclaration : InputDeclaration
               | OutputDeclaration
               | InoutDeclaration;

InputDeclaration : INPUT ID
                | INPUT '[' NUM ':' NUM ']' ID;

OutputDeclaration : OUTPUT ID
                 | OUTPUT '[' NUM ':' NUM ']' ID
                 | OUTPUT REG ID
                 | OUTPUT REG '[' NUM ':' NUM ']' ID;

InoutDeclaration : INOUT ID
                | INOUT '[' NUM ':' NUM ']' ID;

ModuleItems : ModuleItem ModuleItems
            | /* empty */;

ModuleItem : AlwaysBlock
           | InitialBlock
           | WireDeclaration;

AlwaysBlock : ALWAYS '@' '(' Sensitivity ')' BEGINN StatementList END;

StatementList : | Statement StatementList;

Sensitivity : '*'
            | SensitivityExpression SensitivityList;

SensitivityList : OR SensitivityExpression SensitivityList
               | /* empty */;

SensitivityExpression : PosedgeSignal
                    | NegedgeSignal
                    | ID;

PosedgeSignal : POSEDGE ID;

NegedgeSignal : NEGEDGE ID;

InitialBlock : INITIAL BEGINN StatementList END;

WireDeclaration : WIRE NetIdentifierList ';' ;

NetIdentifierList : ID ',' NetIdentifierList
                | ID;

Statement : AssignmentStatement
          | IfStatement;

AssignmentStatement : ID '=' Expression ';' ;

Expression : BitExpression
          | ArithExpression
          | RelExpression
          | '(' Expression ')'
          | Factor;

Factor : ID | NUM

BitExpression : Factor BitOp Factor | '~' Factor %prec UMINUS;

BitOp : '&' | '|' | '^';

ArithExpression : Factor ArithOp Factor;

ArithOp : '+' | '-' | '*' | '/';

RelExpression : Factor RelOp Factor;

RelOp : '>' | '<' ;

IfStatement : IF '(' Expression ')' BEGINN StatementList END elseStatement;

elseStatement : ELSE BEGINN StatementList END
             | /* empty */;

%%

int yyerror(char *msg) {
    fprintf(stderr, "Parser Error: %s\n", msg);
    exit(0);
}

void main(int argc, char *argv[]) {
    /* 
        How to compile and execute:
        $ bison -d bison.y
        $ flex flex.l
        $ gcc lex.yy.c -o fisac bison.tab.c
        $ ./fisac input.txt
    */

    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        yyparse();
        fclose(yyin);
    } else {
        fprintf(stderr, "Invalid format\n");
        exit(EXIT_FAILURE);
    }
}
