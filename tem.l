%{
	#include "tem.tab.h"


	int lineNo = 1;
	int colNo = 1;
	int charno=0;
	extern char* EsteCorecta;

%}

%%
\"(.*?)\"     { printf("ceva");colNo+=strlen(yytext);

	char *res = new char[strlen(yytext) + 1];
  strcpy(res, yytext);
  yylval.svar = res;

	int i, frequency = 0,z=strlen(yytext),coln=0;
   for(i = 0;i< z; ++i)
   { coln++;
       if('\n' == yytext[i])
        {
   ++frequency;
coln=1;
}
   }
colNo=coln;
lineNo+=frequency;
//yyla.location.first_line = lineNo; yyla.location.first_column = colNo;
return TOK_STRING;
}
"!=" {colNo++;printf("TOK_NEEGAL\n"); return TOK_NEEGAL;}
"="	{colNo++;printf("return TOK_EGAL\n"); return TOK_EGAL; }
"<"	{colNo++;printf("return maimic\n"); return TOK_MAIMIC;}
">"	{colNo++;printf("return TOK_maimare\n"); return TOK_MAIMARE;}
"<="	{colNo+=2;printf("micegal\n"); return TOK_MICEGAL;}
">="	 {colNo+=2;printf("return maregal\n"); return TOK_MAREEGAL;}
"=="	 {colNo++;printf("return egalegl\n"); return TOK_EGALEGAL;}
"+"		{ colNo++;printf("return tok_plus\n"); return TOK_PLUS; }
"-"		{ colNo++;printf("return TOK_minus\n"); return TOK_MINUS; }
"*"		{ colNo++;printf("return TOK_multiply\n"); return TOK_MULTIPLY; }
"/"		{ colNo++;printf("return TOK_divide\n"); return TOK_DIVIDE; }
"("		{ colNo++;printf("return TOK_left\n"); return TOK_LEFT; }
")"		{ colNo++;printf("return TOK_right\n"); return TOK_RIGHT; }
";"		{ colNo++;printf("return ;"); return ';'; }

"int"           {printf("int"); colNo+=3 ;return TOK_INTI;}
"float"         {printf("int"); colNo+=5 ;return TOK_FLOATI;}
"boolean"          {printf("bool"); colNo+=4 ;return TOK_BOOL;}
"repeat"        { colNo+=6 ;return TOK_REPEAT;}
"true"				{printf("true");colNo+=4 ;return TOK_TRUE;}
"false"  	{printf("false");colNo+=5 ;return TOK_FALSE;}
"until"		{colNo+=5 ;return TOK_UNTIL;}
"if"		{colNo+=2; return TOK_IF;}
"else"	        {colNo+=4 ;return TOK_ELSE;}
"then"		{colNo+=4 ;return TOK_THEN;}
"end"		{printf("end");colNo+=3 ;return TOK_END;}
"begin"         {printf("beg");colNo+=5 ;return TOK_BEGIN;}
"program"       {colNo+=7 ; printf("program");return TOK_PROGRAM;}
"print"         {colNo=colNo+5 ;return TOK_PRINT;}//([+-]?)
[0-9]+\.[0-9]+ {colNo+=strlen(yytext); yylval.fval = atof(yytext); return TOK_FLOAT; }
0|[1-9][0-9]*	{ colNo+=strlen(yytext);  yylval.ival = atoi(yytext); return TOK_INT; }
[_A-Za-z0-9]+	{printf(" return nume "); colNo+=strlen(yytext); char *res=strdup(yytext); yylval.svar=res; return TOK_NUME; }
\n		{ lineNo++;colNo=1; }

%%
