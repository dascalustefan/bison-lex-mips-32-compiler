%{
int nrreg=0;
#pragma once
#define YYDEBUG 1	
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>
#include <math.h>
#include <list>
#include <iomanip>
#include <locale>
#include <sstream>
int temp;
int calculusnumber=0;
int ifmat[102];
int contmat[102];
int elsemat[102];
int whilemat[100];
int ifs = 0;
int elses = 0;
int whiles = 0;
int lastif = -1;
int lastwhile = -1;
int stringnumber=0;
int boolno=0;
using namespace std;
list <string> printss;
list <string> datas;
int strings=0;
FILE * yyies = NULL;

void reverse(char *str, int len)
{
	int i = 0, j = len - 1, temp;
	while (i<j)
	{
		temp = str[i];
		str[i] = str[j];
		str[j] = temp;
		i++; j--;
	}
}
int intToStr(int x, char str[], int d)
{
	int i = 0;
	while (x)
	{
		str[i++] = (x % 10) + '0';
		x = x / 10;
	}

	// If number of digits required is more, then
	// add 0s at the beginning
	while (i < d)
		str[i++] = '0';

	reverse(str, i);
	str[i] = '\0';
	return i;
}

void ftoa(float n, char *res, int afterpoint)
{
	// Extract integer part
	int ipart = (int)n;

	// Extract floating part
	float fpart = n - (float)ipart;

	// convert integer part to string
	int i = intToStr(ipart, res, 0);

	// check for display option after point
	if (afterpoint != 0)
	{
		res[i] = '.';  // add dot

					   // Get the value of fraction part upto given no.
					   // of points after dot. The third parameter is needed
					   // to handle cases like 233.007
		fpart = fpart * pow(10, afterpoint);

		intToStr((int)fpart, res + i + 1, afterpoint);
	}
}
int yylex();
int yyerror(const char *msg);
int EsteCorecta = 1;
char * msg;
class TVAR
{
public:
	char* nume = NULL;
	int tip = -1;
	int valoarei = 0;
	bool valoareb = 0;
	float valoaref = 0;
	char* valoarec = NULL;
	TVAR* next = NULL;
	bool initializat = false;

public:
	static TVAR* head;
	static TVAR* tail;
public:
	static int gettype(const char *n);
	TVAR(const char* n, const int type, int v);
	TVAR(const char* n, const int type);
	TVAR(const char* n, float v);
	TVAR(const char* n, const char * v);
	TVAR();
	TVAR(const char* n);
	static int exists(const char* n);
	static void add(TVAR *a);
	static char * getValue(const char* n);
	static void setValue(const char* n, const char *f);
	static void debuginfo(const char *n);
	/*void addi(char* n, int v = -1);
	void addf(char* n, int v = -1);
	void adds(char* n, int v = -1);
	void addb(char* n, int v = -1);
	int getValuei(char* n);
	float getValuef(char* n);

	bool getValueb(char* n);
	void setValuei(char* n, int v);
	void setValuec(char* n, char* v);
	void setValuef(char* n, float v);
	void setValueb(char* n, bool v);
	void setValue(const char*n,const char *f);*/
};
TVAR::TVAR(const char* n)
{
	this->nume = new char[strlen(n) + 1];
	strcpy(this->nume, n);
	tip = 2;
	initializat = false;
	this->next = NULL;
}
int TVAR::gettype(const char *n)
{

	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		char *buf;
		if (strcmp(tmp->nume, n) == 0)
		{
			return tmp->tip;
		}
		tmp = tmp->next;
	}
	return -1;
}
void TVAR::debuginfo(const char *n)
{
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		char *buf;
		if (strcmp(tmp->nume, n) == 0)
		{
			printf("\n%s:\n%d\n", tmp->nume, tmp->tip);

			if (tmp->initializat == false)
			{
				printf("neinitializat\n");
			}
			if (tmp->initializat == true)
			{
				printf("initializat\n");
			}
			if (tmp->initializat == true)
			{
				char *buff = NULL;
				switch (tmp->tip)
				{
				case 0:
					buff = new char[100];
					sprintf(buff, "%d", tmp->valoarei);

					break;
				case 1:
					buff = new char[100];
					sprintf(buff, "%d", tmp->valoareb);

					break;
				case 2:
					buff = new char[100];
					sprintf(buff, "%.3f", tmp->valoaref);

					break;
				case 3:
					buff = new char[100];
					strcpy(buff, tmp->valoarec);
					break;
				}
				printf("%s", buff);
			}
			break;

		}
		tmp = tmp->next;
	}
}
TVAR* TVAR::head = NULL;
TVAR* TVAR::tail = NULL;
void initialize(const char *n)
{

	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		
		if (strcmp(tmp->nume, n) == 0)
		{
			tmp->initializat = 1;
			return;
		}
		tmp = tmp->next;
	}
}
TVAR::TVAR(const char* n, int type, int v)
{
	this->nume = new char[strlen(n) + 1];
	strcpy(this->nume, n);
	if (type == 0)
	{
		this->valoarei = v;
		tip = 0;
	}
	else
		if (type == 1)
		{
			this->valoareb = v;
			tip = 1;
		}
	this->next = NULL;
	this->initializat = true;
}
TVAR::TVAR(const char* n, int type)
{
	this->nume = new char[strlen(n) + 1];
	strcpy(this->nume, n);
	if (type == 0)
	{
		initializat = false;
		tip = 0;
	}
	else
		if (type == 1)
		{
			initializat = false;
			tip = 1;
		}
	this->next = NULL;

}
TVAR::TVAR(const char* n, float v)
{
	this->nume = new char[strlen(n) + 1];
	strcpy(this->nume, n);
	tip = 2;
	valoaref = v;
	this->next = NULL;
	this->initializat = true;
}
/*TVAR::TVAR(const char* n)
{
this->nume = new char[strlen(n) + 1];
strcpy(this->nume, n);
tip = 2;
initializat = false;
this->next = NULL;
}*/
TVAR::TVAR(const char* n, const char * v)
{
	this->nume = new char[strlen(n) + 1];
	this->nume = strdup(n);//strcpy(this->nume, n);
	this->valoarec = strdup(v);
	tip = 3;
	this->next = NULL;
	this->initializat = true;
}


TVAR::TVAR()
{
	TVAR::head = NULL;
	TVAR::tail = NULL;
}

int TVAR::exists(const char* n)
{
	TVAR* tmp = TVAR::head;
	while (tmp != NULL && strcmp(tmp->nume, n) != 0)
	{
		tmp = tmp->next;

	}
	if (tmp != NULL)
	{
		return 1;
	}
	return 0;
}

void TVAR::add(TVAR *a)
{
	TVAR* elem = a;
	if (head == NULL)
	{
		TVAR::head = TVAR::tail = elem;
	}
	else
	{
		TVAR::tail->next = elem;
		TVAR::tail = elem;
	}
}

char * TVAR::getValue(const char* n)
{
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		char *buf;
		if (strcmp(tmp->nume, n) == 0)
		{
			if (tmp->initializat != true)
			{
				buf = new char[100];
				sprintf(buf, "%s", "hasnotbeeninitialized");
				return(buf);
			}

			switch (tmp->tip)
			{
			case 0:
				buf = new char[100];
				sprintf(buf, "%d", tmp->valoarei);
				return buf;
				break;
			case 1:
				buf = new char[100];
				sprintf(buf, "%d", tmp->valoareb);
				return buf;
				break;
			case 2:
				buf = new char[100];
				sprintf(buf, "%.3f", tmp->valoaref);
				return buf;
				break;
			case 3:
				return tmp->valoarec;
				break;
			}



		}
		tmp = tmp->next;
	}
	char a[] = "-1";
	return a;
}

void TVAR::setValue(const char* n, const char *f)
{
	
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		if (strcmp(tmp->nume, n) == 0)
		{
			switch (tmp->tip)
			{
			case 0:
				
				tmp->valoarei = atof(f);
				tmp->initializat=1;
				return;
				break;
			case 1:
			printf("%d",tmp->valoareb);
				tmp->valoareb = atoi(f);
				tmp->initializat=1;
				TVAR::debuginfo(n);
				return;
				break;
			case 2:
			printf("%.3f",tmp->valoaref);
				tmp->valoaref = atof(f);
				tmp->initializat=1;
				TVAR::debuginfo(n);
				return;
				break;
			case 3:
			printf("%s",tmp->valoarec);
				tmp->valoarec = strdup(f);
				tmp->initializat=1;
				TVAR::debuginfo(n);
				return;
				break;
			}

		}
		tmp = tmp->next;
	}
	
}


TVAR* ts = NULL;
void printinfo(const char *n)
{
	/*if (strcmp(TVAR::getValue(n), "hasnotbeeninitialized") == 0)
	{
	printf("not been initialised");
	}*/
	TVAR::debuginfo(n);
}
bool ifinitialised(const char *a)
{
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		if (strcmp(tmp->nume, a) == 0)
		{
			
				return tmp->initializat;
			

		}
		tmp = tmp->next;
	}
return false;
}
bool ifdeclared(const char *a)
{
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		if (strcmp(tmp->nume, a) == 0)
		{
			return 1;

		}
		tmp = tmp->next;
	}
	return 0;
}
void addchar(const char *n, const char * scris)
{

	printf("\nincepe declararea si declararea si initializarea unui char \n");
	TVAR *newvar = new TVAR(n, scris);
	if (ifdeclared(n) == 0)
	{

		newvar->initializat = 1;
		TVAR::add(newvar);
		printinfo(n);
	}
	else
	{
		
		yyerror("a mai fost declarat o data");
	}
	printf("\nse termina declararea si initializarea unui char\n");
}
void addvarintorboolwithnoid(const char *n, int i)
{
	//i este tipul
	printf("\nincepe declararea si initializarea unui int sau bool %d\n",i);
	TVAR *newvar = new TVAR(n, i);
	
	if (ifdeclared(n) == 0)
	{

		newvar->initializat = 0;
		TVAR::add(newvar);
		printinfo(n);
	} 
	else
	{
		
		
		yyerror("a mai fost declarat o data");
	}
	printf("\nse termina declararea unui int sau bool\n");
}

void addvarint(const char *n, int i, int number)
{
	//i este tipul
	printf("\nincepe declararea si initializarea unui int\n");
	TVAR *newvar = new TVAR(n, i, number);
	if (ifdeclared(n) == 0)
	{
		
		newvar->initializat = 1;
		TVAR::add(newvar);
		printinfo(n);
		printf("\ns-a terminat declararea si intitializarea unui int\n");
	}
	else
	{

		
		yyerror("a mai fost declarat o data");
	}
}
void addfloatvar(const char *n, float number)
{
	//i este tipul
	printf ("fuck you steven");
	TVAR *newvar = new TVAR(n, number);
	if (ifdeclared(n) == 0)
	{

		newvar->initializat = 1;
		TVAR::add(newvar);
		printinfo(n);
	}
	else
	{
		
		yyerror("a mai fost declarat o data");
	}
}
void addfloat(const char *n)
{
	//i este tipul
	//printf("\n\ndksfkakdfjsdkafjsdkfajks--------------------\n");
	TVAR *newvar = new TVAR(n);
	if (ifdeclared(n) == 0)
	{

		newvar->initializat = 0;
		TVAR::add(newvar);
		printinfo(n);
	}
	else
	{
		printf("error\n");
		yyerror("eroaremare");
	}
}

char* getval(const char* nume ,char *tip)
{
	
	char* returnel=new char[100];
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		char * buff;
		char *buff2;
		buff = new char[100];
	
		if (strcmp(tmp->nume, nume) == 0)
		{
			switch (tmp->tip)//milpgame.com meta.math mlpgame
			{
			case 0:
				sprintf(buff, "%d", tmp->valoaref);
				buff2 = strdup("int");
				strcpy(tip,buff2);
				return buff;
				break;
			case 1:
				sprintf(buff, "%d", tmp->valoaref);
				buff2 = strdup("bool");
			
				strcpy(tip,buff2);
				return buff;
				break;
			case 2:
				sprintf(buff, "%.3f", tmp->valoaref);
				
				buff2 = strdup("float");
				strcpy(tip,buff2);
				return buff;
				break;
			case 3:
				char *val=tmp->valoarec;
				buff2 = strdup("char");
				strcpy(tip,buff2);
				return val;
				break;
			}

		}
		tmp = tmp->next;
	}
}
float getval(const char* nume )
{
	
	char* returnel=new char[100];
	TVAR* tmp = TVAR::head;
	while (tmp != NULL)
	{
		char * buff;
		char *buff2;
		buff = new char[100];
	
		if (strcmp(tmp->nume, nume) == 0)
		{
			switch (tmp->tip)//milpgame.com meta.math mlpgame
			{
			case 0:
				
				
				return float(tmp->valoarei);
				break;
			case 1:
				
				return float(tmp->valoareb);
				break;
			case 2:
			
				return float(tmp->valoaref);
				break;
		

		}
		tmp = tmp->next;
	}
return -1;
}
}
%}
%union { char* svar;struct calc{const char* a;float b;} calculat; int ival; float fval; }

%token TOK_PLUS TOK_MINUS TOK_MULTIPLY TOK_DIVIDE TOK_LEFT TOK_RIGHT
%token TOK_PRINT TOK_ERROR TOK_REPEAT TOK_UNTIL TOK_EGAL TOK_NEEGAL TOK_MAIMIC 
%token TOK_IF TOK_ELSE TOK_THEN TOK_END TOK_BEGIN TOK_PROGRAM
%token TOK_MAIMARE TOK_MICEGAL TOK_MAREEGAL TOK_EGALEGAL TOK_DECLARE TOK_FALSE
%token TOK_TRUE TOK_INTI TOK_FLOATI

%token <svar> TOK_NUME
%token <ival> TOK_INT
%token <ival> TOK_BOOL
%token <svar> TOK_STRING
%token <float> TOK_FLOAT
%type <ival> Program
%type <fval> calculus
%type <ival> semn
%type <ival> booleanop
%type <ival> evaluation
%start Program




%nonassoc IFX
%nonassoc TOK_ELSE

%nonassoc ceva
%nonassoc ceva1

%left TOK_PLUS TOK_MINUS
%left TOK_MULTIPLY TOK_DIVIDE
%left TOK_MAIMIC TOK TOK_MAIMARE TOK_MAREEGAL TOK_MICEGAL
%left TOK_EGALEGAL
%left TOK_NEEGAL
%left USEMN
%left USEMN2
%nonassoc nimic2
%nonassoc nimic
%debug
%%



 Program:
    TOK_PROGRAM TOK_NUME TOK_BEGIN stuff TOK_END{$$=1;printf("ce mai vrei");} ;


//{EsteCorecta=0; char * msg=strdup("eroare naspa");  yyerror(msg);}
//char *c;float a=getval($1,c)+$3;$<fval>$=a;

stuff :
			 declaration stuff %prec ceva
			|
			 operation stuff %prec ceva
			|
			%prec nimic
			
;





declaration :
 			TOK_INTI TOK_NUME ';'

			{

string tempo=$2;
tempo=tempo+": .word 0\n";
//printf("ss          %s               sssss   ",tempo.c_str());
datas.push_back(tempo);
addvarintorboolwithnoid($2, 0);



}
	        |
			TOK_INTI TOK_NUME TOK_EGAL calculus  ';'
{

string tempo=$2;
tempo=tempo+": .word ";
char * buff=new char[100];
int a=$4;
sprintf(buff, "%d", a); 
tempo+=buff;
tempo+="\n";
printf("ss          %s               sssss%s   ",tempo.c_str(),buff);

datas.push_back(tempo);
addvarint($2,0,$4);

}
		
			|
			TOK_FLOATI TOK_NUME ';'
{
string tempo=$2;
tempo=tempo+": .float 0\n";
datas.push_back(tempo);
addfloat($2);
}
			|
			TOK_FLOATI TOK_NUME TOK_EGAL calculus ';'
{
string tempo=$2;
tempo=tempo+": .float ";
char * buff=new char[100];
sprintf(buff, "%.3f", $4); 
 
tempo+=buff;
tempo+="\n";
datas.push_back(tempo);
addfloatvar($2,$4);


}	
			|
			TOK_BOOL TOK_NUME TOK_EGAL TOK_TRUE ';'
{
string tempo=$2;
tempo=tempo+": .word ";
tempo+="1";
tempo+="\n";
datas.push_back(tempo);

addvarint($2,1,1);}
			|
			TOK_BOOL TOK_NUME TOK_EGAL TOK_FALSE ';'
{
string tempo=$2;
tempo=tempo+": .word ";
tempo+="0";
tempo+="\n";
datas.push_back(tempo);
addvarint($2,1,0);
}
			|
			TOK_BOOL TOK_NUME ';' 
{
string tempo=$2;
tempo=tempo+": .word	0";
tempo+="\n";
datas.push_back(tempo);
 addvarintorboolwithnoid($2,1);
}

;



operation:
		TOK_NUME TOK_EGAL TOK_TRUE ';' 
{
			if(!TVAR::exists($1))
			yyerror("nu exista");
			 if(TVAR::gettype($1)!=1)
				yyerror("nu e tipul corect");
			
			initialize($1);
		
			fprintf(yyies,"li $t1, 1 \n");
			fprintf(yyies,"sw	$t1, %s\n",$1);
			break;
}
		|
		TOK_NUME TOK_EGAL TOK_FALSE ';' 
{
			if(!TVAR::exists($1))
			yyerror("nu exista");
			if(TVAR::gettype($1)!=1)
				yyerror("nu e tipul corect");
			initialize ($1);
			fprintf(yyies,"li $t1, 0 \n");
			fprintf(yyies,"sw	$t1, %s\n",$1);
			break;
}
		|
	 	TOK_NUME TOK_EGAL calculus ';'  {char * buff; buff = new char[100]; sprintf(buff, "%.3f", $3); 		printf("\n%s\n",buff);//in progress
		if(!TVAR::exists($1))
			yyerror("nu exista");
		
			
		 if(ifdeclared($1))
		 TVAR::setValue($1,buff);
		 else
		 yyerror("nedeclarat");

		fprintf(yyies,"l.s $f1,0($sp) \n");//pop
		fprintf(yyies,"add $sp,$sp,4 \n");
		int a=TVAR::gettype($1);
		switch(a)
{
		case 0:
			fprintf(yyies,"cvt.w.s $f1, $f1\n");
			fprintf(yyies,"mfc1 $t1, $f1 \n");
			fprintf(yyies,"sw	$t1, %s\n",$1);
			break;
		case 1:


		
		fprintf(yyies,"cvt.w.s $f1, $f1\n");
		fprintf(yyies,"mfc1 $t1, $f1 \n");
		fprintf(yyies,"beq $t1,0,bool%d \n",boolno);
		fprintf(yyies,"li $t1, 1 \n");
		fprintf(yyies,"bool%d: \n",boolno);
		
		fprintf(yyies,"sw	$t1, %s\n",$1);//swc1 $f0, 4($t4)
		boolno++;
		break;
		case 2:
		fprintf(yyies,"swc1 $f1, %s\n",$1);//
		break;
}
initialize($1);	
}



 		|
		TOK_PRINT TOK_NUME ';'
{
if(!TVAR::exists($2))
			yyerror("nu exista");
if(!ifinitialised($2))
			yyerror("neinitializata");
			 switch(TVAR::gettype($2))
{
			case 0:
			fprintf(yyies,"lw	$t0, %s\n",$2);
			fprintf(yyies,"move	$a0, $t0\n");
			fprintf(yyies,"li	$v0, 1\n");
			fprintf(yyies,"syscall\n");
			break;
			case 1:
			fprintf(yyies,"lw	$t0, %s\n",$2);
			
			fprintf(yyies,"move	$a0, $t0\n");
			fprintf(yyies,"li	$v0, 1\n");
			fprintf(yyies,"syscall\n");
			break;
			case 2:
			fprintf(yyies,"l.d $f0, %s\n",$2);
			fprintf(yyies,"li $v0, 2\n");
    		fprintf(yyies,"mov.s $f12, $f0\n");
    		fprintf(yyies,"syscall\n");
			break;


}
			if(!ifinitialised($2))
			yyerror("neinitializata");
}
//char *buffer=new char[100];fprintf(yyies,"\nPRINTING\n" );fprintf(yyies,"--%s",TVAR::getValue($2));fprintf(yyies,"li	$v0, 4\n la	$a0, string%d \nsyscall	");string exp=TVAR::getValue($2); string.push_back(exp);}
		|
		TOK_PRINT TOK_STRING ';'
{
string temp=$2;
printss.push_back(temp);
printf("%d",stringnumber);
fprintf(yyies,"li $v0, 4 \n");
fprintf(yyies,"la $a0, string%d  \n",stringnumber);
fprintf(yyies,"syscall  \n");
stringnumber++;




}//fprintf(yyies,"%s",$2);fprintf(yyies,"li	$v0, 4\n la	$a0, string%d \nsyscall	");string exp=$2; string.push_back(exp);}
		|
		TOK_REPEAT { fprintf(yyies,"while%d:\n",whiles); whiles++;} TOK_BEGIN stuff TOK_END TOK_UNTIL TOK_LEFT evaluation2 TOK_RIGHT ';'{printf("repeat");}
		|
		TOK_IF  TOK_LEFT evaluation TOK_RIGHT   TOK_THEN TOK_BEGIN stuff TOK_END   

{ int i;
 for(i=ifs-1;i>=0;i--)
 if (ifmat[i]==1&&contmat[i]==0)
{
		temp=i;
		break;
}
contmat[i]=1; 
elsemat[i]=1;

fprintf(yyies,"else%d:\n",temp);
fprintf(yyies,"continue%d:\n",temp);
// fprintf(yyies,"     noelse                   \n");
 } %prec IFX
		|
		TOK_IF TOK_LEFT evaluation TOK_RIGHT 	TOK_THEN TOK_BEGIN stuff TOK_END  
 { int i;
for(i=ifs-1;i>=0;i--)
 if (ifmat[i]==1&&contmat[i]==0)
{
		temp=i;
		break;
}
contmat[i]=1;
fprintf(yyies,"j continue%d\n",temp);
fprintf(yyies,"else%d:\n",temp);
 }	

TOK_ELSE     TOK_BEGIN stuff TOK_END   { int i;
for(i=ifs-1;i>=0;i--)
 if (ifmat[i]==1&&contmat[i]==1&&elsemat[i]==0)
{
		temp=i;
		break;
}
elsemat[i]=1;
fprintf(yyies,"continue%d:\n",temp); 
} 

;
evaluation: calculus booleanop calculus 
{
 switch ($2)
	{
	case 0:
			fprintf(yyies,"l.s $f1,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n" );//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.lt.s $f1, $f2 #check\n");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1t else%d\n",ifs);
			ifmat[ifs]=1;
			ifs++;
			
		break;
	case 1:
		fprintf(yyies,"l.s $f1,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.eq.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t0, $0, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1f else%d\n",ifs);
			ifmat[ifs]=1;
			ifs++;
			
		break;
	case 2:
		fprintf(yyies,"l.s $f1,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.le.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1t else%d\n",ifs);
	ifmat[ifs]=1;
			ifs++;
		break;
	case 3:
		fprintf(yyies,"l.s $f1,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.lt.s $f1, $f2 #check \n");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc0f else%d\n",ifs);
ifmat[ifs]=1;
			ifs++;		
break;
	case 4:
		fprintf(yyies,"l.s $f1,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.le.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1f else%d\n",ifs);
ifmat[ifs]=1;
			ifs++;		
break;
	case 5:
		fprintf(yyies,"l.s $f1,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.eq.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1t else%d\n",ifs);
ifmat[ifs]=1;
			ifs++;		
break;

	}

  }


		|
		TOK_NUME
{
if(!TVAR::exists($1))
			yyerror("nu exista");
			 
			
 if(!ifinitialised($1))
{
printf("boolean neinitializat");
yyerror("boolean neinitializat");
}
    char *a =TVAR::getValue($1);
	float b=::atof(a);
	fprintf(yyies,"l.d $f3,%s\n",$1);
	if(TVAR::gettype($1)==2)
		{
			fprintf(yyies,"cvt.w.s $f3, $f3\n");
			printf ("-------------------------succedded");
				}
		fprintf(yyies,"mfc1 $t0, $f3\n");
		fprintf(yyies,"li $t1, 1\n");
		fprintf(yyies," seq $t3, $t0, $t1 \n ");        //# compare f4 and f6; set FCC[0] to the result
		
		fprintf(yyies,"beq $t3,$0,else%d\n",ifs);
		ifmat[ifs]=1;
			ifs++;	
		
}
|
TOK_TRUE
 {
//fprintf(yyies,"li $t1,1\n");
ifmat[ifs]=1;
ifs++;	
}
|
TOK_FALSE
 {
fprintf(yyies,"j else%d\n",ifs);
ifmat[ifs]=1;
ifs++;
}
;






evaluation2: calculus booleanop calculus 
{
int i;
 switch ($2)
	{
	case 0:
			fprintf(yyies,"l.s $f1,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n" );//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.lt.s $f1, $f2 #check\n");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			fprintf(yyies,"bc1t while%d\n",whiles);
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1t while%d\n",i);
					break;
				}

			
		break;
	case 1:
		fprintf(yyies,"l.s $f1,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.eq.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t0, $0, $fcc0\n");//  # move 1 into t0 if comparison was true
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1f while%d\n",i);
					break;
				}
			
		break;
	case 2:
		fprintf(yyies,"l.s $f1,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.le.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1t while%d\n",i);
					break;
				}
		break;
	case 3:
		fprintf(yyies,"l.s $f1,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.lt.s $f1, $f2 #check \n");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1f while%d\n",i);
					break;
				}
break;
	case 4:
		fprintf(yyies,"l.s $f1,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.le.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1f while%d\n",i);
					break;
				}
break;
	case 5:
		fprintf(yyies,"l.s $f1,0($sp) #pop\n ");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp)  #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"li     $t1, 1 \n");   //t1=0 
			fprintf(yyies,"li     $t6, 0 \n");       //# move 0 into t0
			fprintf(yyies,"c.eq.s $f1, $f2 #check\n ");        //# compare f4 and f6; set FCC[0] to the result
			//fprintf(yyies,"movt   $t6, $t1, $fcc0\n");//  # move 1 into t0 if comparison was true
			for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"bc1t while%d\n",i);
					break;
				}
break;

	}

  }
		|
		TOK_NUME
{
if(!TVAR::exists($1))
			yyerror("nu exista");
			 
			
 if(!ifinitialised($1))
{
printf("boolean neinitializat");
yyerror("boolean neinitializat");
}

    char *a =TVAR::getValue($1);
	float b=::atof(a);
	if(b!=0)
	yyerror("nu merge e mereu true");
	fprintf(yyies,"l.d $f3,%s\n",$1);
	if(TVAR::gettype($1)==2)
		{
			fprintf(yyies,"cvt.w.s $f3, $f3\n");
			printf ("-------------------------succedded");
				}
		fprintf(yyies,"mfc1 $t0, $f3\n");
		fprintf(yyies,"li $t1, 1\n");
		fprintf(yyies," seq $t3, $t0, $t1 \n ");        //# compare f4 and f6; set FCC[0] to the result
		
		int i;
		for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"beq $t3,$0,while%d\n",i);
					break;
				}	
 

}
|
TOK_TRUE
 {
	yyerror("nu merge e mereu true");
int i;
		for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					fprintf(yyies,"j while%d\n",i);
					break;
				}	
}
|
TOK_FALSE
 {
int i;
for(i=whiles-1;i>=0;i--)
				if(whilemat[i]==0)
				{
					whilemat[i]=1;
					
					break;
				}

}
;



semn:
		TOK_PLUS %prec USEMN {$<ival>$=0;}
		|
		TOK_MINUS %prec USEMN {$<ival>$=1;} 
		;




booleanop: TOK_NEEGAL{$<ival>$=5;}
		|
		TOK_EGALEGAL{$<ival>$=1;}
		|
		 TOK_MAIMIC{$<ival>$=0;}
		|
		 TOK_MAIMARE{$<ival>$=4;}
		|
		TOK_MAREEGAL{$<ival>$=3;}
		|
		TOK_MICEGAL{$<ival>$=2;}
;





calculus: 
        TOK_LEFT calculus TOK_RIGHT 
		{
			$<fval>$=$2;
			printf("%.3f\n",$2);
			

		}
		|
		calculus TOK_PLUS calculus 
 		{
			fprintf(yyies,"l.s $f1,0($sp) #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) #pop \n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"add.s $f3,$f1,$f2 #add\n");//addition
			fprintf(yyies,"addi $sp,$sp,-4 #push\n");//psuh
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			$<fval>$=$1+$3;
			printf("\n%.3f + %.3f\n",$1,$3);
			//printf("lw $f1,0($sp)\n add $sp,$sp,4\n");
			//printf("lw $f1,0($sp)\n add $sp,$sp,4\n");
			 // $<fval>$=$1+$2 ;
				
		}
		
		|
		 semn TOK_NUME %prec USEMN
		{
			if(!TVAR::exists($2))
			yyerror("nu exista");
			 
			if(!ifinitialised($2))
			yyerror("neinitializata");
			 printf("%f",getval($2));
			fprintf(yyies,"l.d $f3,%s\n",$2);
			//printf("%d--------------------------------",TVAR::gettype($1));
			if(TVAR::gettype($2)!=2)
			{
			fprintf(yyies,"cvt.s.w $f3, $f3\n");
			printf ("-------------------------succedded");
				}
		 if($1==0)
{
			 $<fval>$=getval($2) ;
}
		else
{
			$<fval>$=-getval($2) ;
			fprintf(yyies,"neg.s $f3,$f3\n");

}		 
			fprintf(yyies,"addi $sp,$sp,-4\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return nume cu semn");//and push on the stack
			
			
			
		
			fprintf(yyies,"addi $sp,$sp,-4\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return nume cu semn");//and push on the stiva
}
		|
		semn TOK_INT %prec USEMN
		{
	
           fprintf(yyies,"	li $t1,%d #initialize \n ",$2);
			fprintf(yyies,"mtc1 $t1, $f3\n");
			fprintf(yyies,"cvt.s.w $f3,$f3\n");
              		//printf("%d\n",$1);
				//fprintf(yyies,"l.d $f3,%d\n",$1);
			
			
			$<fval>$=$1;
			 if($1==0)
{
			 $<fval>$=$2 ;
}
		else
{
			$<fval>$=-$2 ;
			fprintf(yyies,"neg.s $f3,$f3\n");

}		 
			fprintf(yyies,"addi $sp,$sp,-4 #push\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return int cu semn");//and push on the stack
		 }
		|
		semn TOK_FLOAT %prec USEMN
		{
			fprintf(yyies,"li.s $f3,%.3f",$<fval>2);
			printf("%.3f\n",$<fval>2);
			if($1==0)
{
			 $<fval>$=$<fval>2 ;
}
		else
{
			$<fval>$=-$<fval>2 ;
			fprintf(yyies,"neg.s $f3,$f3\n");

}		 
			fprintf(yyies,"addi $sp,$sp,-4\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return int cu semn");//and push on the stiva
		}
		|	
		calculus TOK_MULTIPLY calculus 
		 {
			fprintf(yyies,"l.s $f1,0($sp) #pop\n");//pop
			fprintf(yyies,"add $sp,$sp,4 \n");
			fprintf(yyies,"l.s $f2,0($sp) \n");//pop
			fprintf(yyies,"add $sp,$sp,4 #pop\n");
			fprintf(yyies,"mul.s $f3,$f1,$f2#mul\n");//addition
			fprintf(yyies,"addi $sp,$sp,-4#push\n");//psuh
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("\n%.3f * %.3f\n",$1,$3);
			  $<fval>$=$1*$3 ;
		 }
		|
		calculus TOK_MINUS calculus 
		{
			fprintf(yyies,"l.s $f1,0($sp) \n");//pop
			fprintf(yyies,"add $sp,$sp,4 #pop\n");
			fprintf(yyies,"l.s $f2,0($sp) \n");//pop
			fprintf(yyies,"add $sp,$sp,4 #pop\n");
			fprintf(yyies,"sub.s $f3,$f2,$f1#minus\n");//addition
			fprintf(yyies,"addi $sp,$sp,-4#push\n");//psuh
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("\n%.3f - %.3f\n",$1,$3);
			 $<fval>$=$1-$3 ;
		}
		|
		calculus TOK_DIVIDE calculus 
		{
			fprintf(yyies,"l.s $f1,0($sp) \n");//pop
			fprintf(yyies,"add $sp,$sp,4 #pop\n");
			fprintf(yyies,"l.s $f2,0($sp) \n");//pop
			fprintf(yyies,"add $sp,$sp,4 #pop\n");
			fprintf(yyies,"div.s $f3,$f2,$f1 #division\n");//addition
			fprintf(yyies,"addi $sp,$sp,-4 #push\n");//psuh
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("\n%.3f / %.3f\n",$1,$3);
			 $<fval>$=$1/$3 ;
		 }
			|
		  TOK_NUME 
		{	//de facut pentru int si float si eroare pentru bool
			fprintf(yyies,"l.d $f3,%s\n",$1);
			printf("%d--------------------------------",TVAR::gettype($1));
			if(TVAR::gettype($1)!=2)
			{
			fprintf(yyies,"cvt.s.w $f3, $f3\n");
			printf ("-------------------------succedded");
				}
		
			fprintf(yyies,"addi $sp,$sp,-4\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return nume cu semn");//and push on the stack
			if(!TVAR::exists($1))
			yyerror("nu exista");
			 
			if(!ifinitialised($1))
			yyerror("neinitializata");
			
			 printf("%f",getval($1));
			$<fval>$=getval($1) ;
				 
		}
		|
		 TOK_INT 
		{
			fprintf(yyies,"	li $t1,%d #initialize \n ",$1);
			fprintf(yyies,"mtc1 $t1, $f3\n");
			fprintf(yyies,"cvt.s.w $f3,$f3\n");
              		//printf("%d\n",$1);
				//fprintf(yyies,"l.d $f3,%d\n",$1);
			
			fprintf(yyies,"addi $sp,$sp,-4 #push\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return int cu semn");//and push on the stack
			$<fval>$=$1;
		 }
		|
		TOK_FLOAT
		{
			fprintf(yyies,"li.s $f3,%.3f  #initalize \n ",$<fval>1);
			//fprintf(yyies,"%.3f\n",$<fval>1);
			fprintf(yyies,"addi $sp,$sp,-4\n");//push
			fprintf(yyies,"swc1 $f3,0($sp)\n");
			printf("return int cu semn");//and push on the stack
			$<fval>$=$<fval>1;
		}
		
;
		
%%
int main()

{
	int i;
	for(i=0;i<99;i++)
	{
		ifmat[i]=0;
		whilemat[i]=0;
		ifmat[i]=0;
		contmat[i]=0;
		elsemat[i]=0;
	}
	yydebug = 1;
	yyies = fopen("0","w");
	fprintf(yyies, "\t.text\n\t.globl main\nmain:\n");

	yyparse();
	fprintf(yyies,"\tli\t$v0, 10\n\tsyscall\n\t.data\n");
//list <string> printss;
//list <string> datas;
	std::list<string>::iterator it;
	for (it =datas.begin(); it != datas.end(); ++it) {
		fprintf(yyies,"\n%s\n", it->c_str());
	}
	int tempus2=0;
	
	for (it =printss.begin(); it != printss.end(); ++it) {
		printf("\nstring%d: .asciiz %s\n" ,tempus2,it->c_str());
		fprintf(yyies,"\nstring%d: .asciiz %s\n",tempus2,it->c_str());
		printf("%d",tempus2);
		tempus2=tempus2+1;
	}
	fclose(yyies);
 	
	if(EsteCorecta == 1)
	{
		printf("CORECTA\n");
	}

       return 0;
}

int yyerror(const char *msg)
{

	EsteCorecta=0;
	printf("Error: %s\n", msg);
	exit(-1);
	
}


