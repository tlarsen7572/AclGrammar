grammar AclScript;
//Parser rules
func       : numFunc
           | datetimeFunc
		   | stringFunc
		   | boolFunc ;
numFunc    : abs
           | age
		   | ascii
		   | at
		   | cos
		   | cumprinc
		   | cumipmt
		   | day
		   | dec
		   | dicecoefficient
		   | digit
		   | dow
		   | effective
		   | exp
		   | filesize
		   | frequency
		   | fvannuity
		   | fvlumpsum
		   | fvschedule
		   | intf
		   | ipmt
		   ;
datetimeFunc: ctod
           | ctodt
		   | ctot
		   | eomonth
		   | gomonth
		   | hour
		   ;
stringFunc : alltrim
           | bintostr
		   | bit
		   | blanks
		   | byte
		   | cdow
		   | chr
		   | clean
		   | cmoy
		   | datef
		   | datetimef
		   | dbtye
		   | dhex
		   | dtou
		   | ebcdic
		   | exclude
		   | ftype
		   | getoptions
		   | hash
		   | hex
		   | htou
		   | include
		   | insert
		   | last
           ;
boolFunc   : between
           | find
		   | isblank
		   | isdefined
		   | isfuzzydup
           ;

//Functions
abs        : ABS fStart numExpr fEnd ;
age        : AGE fStart (datetimeExpr | stringExpr) (sep (datetimeExpr | stringExpr))? fEnd ;
alltrim    : ALLTRIM fStart stringExpr fEnd ;
ascii      : ASCII fStart stringExpr fEnd ;
at         : AT fStart numExpr sep stringExpr sep stringExpr fEnd ;
between    : BETWEEN fStart numExpr sep numExpr sep numExpr fEnd
           | BETWEEN fStart stringExpr sep stringExpr sep stringExpr fEnd
		   | BETWEEN fStart datetimeExpr sep datetimeExpr sep datetimeExpr fEnd
		   ;
bintostr   : BINTOSTR fStart stringExpr sep stringExpr fEnd ;
bit        : BIT fStart numExpr fEnd ;
blanks     : BLANKS fStart numExpr fEnd ;
byte       : BYTE fStart numExpr fEnd ;
cdow       : CDOW fStart datetimeExpr sep numExpr fEnd ;
chr        : CHR fStart numExpr fEnd ;
clean      : CLEAN fStart stringExpr sep stringExpr fEnd ;
cmoy       : CMOY fStart datetimeExpr sep numExpr fEnd ;
cos        : COS fStart numExpr fEnd ;
ctod       : CTOD fStart (stringExpr | numExpr) (sep stringExpr)? fEnd ;
ctodt      : CTODT fStart (stringExpr | numExpr) (sep stringExpr)? fEnd ;
ctot       : CTOT fStart (stringExpr | numExpr) fEnd ;
cumprinc   : CUMPRINC fStart numExpr sep numExpr sep numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
cumipmt    : CUMIPMT fStart numExpr sep numExpr sep numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
datef      : DATEF fStart datetimeExpr (sep stringExpr)? fEnd ;
datetimef  : DATETIMEF fStart datetimeExpr (sep stringExpr)? fEnd ;
day        : DAY fStart datetimeExpr fEnd ;
dbtye      : DBYTE fStart numExpr fEnd ;
dec        : DEC fStart numExpr sep numExpr fEnd ;
dhex       : DHEX fStart stringExpr fEnd ;
dicecoefficient : DICECOEFFICIENT fStart stringExpr sep stringExpr (sep numExpr)? fEnd ;
digit      : DIGIT fStart numExpr sep numExpr fEnd ;
dow        : DOW fStart datetimeExpr fEnd ;
dtou       : DTOU fStart (datetimeExpr (sep stringExpr (sep numExpr)?)?)? fEnd ;
ebcdic     : EBCDIC fStart stringExpr fEnd ;
effective  : EFFECTIVE fStart numExpr sep numExpr fEnd ;
eomonth    : EOMONTH fStart (datetimeExpr (sep numExpr)?)? fEnd ;
exclude    : EXCLUDE fStart stringExpr sep stringExpr fEnd ;
exp        : EXP fStart numExpr sep numExpr fEnd ;
filesize   : FILESIZE fStart stringExpr fEnd ;
find       : FIND fStart stringExpr (sep stringExpr)? fEnd ;
frequency  : FREQUENCY fStart stringExpr fEnd ;
ftype      : FTYPE fStart stringExpr fEnd ;
fvannuity  : FVANNUITY fStart numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
fvlumpsum  : FVLUMPSUM fStart numExpr sep numExpr sep numExpr fEnd ;
fvschedule : FVSCHEDULE fStart numExpr (sep numExpr)+ fEnd ;
getoptions : GETOPTIONS fStart stringExpr fEnd ;
gomonth    : GOMONTH fStart datetimeExpr sep numExpr fEnd ;
hash       : HASH fStart expr (sep (numExpr | stringExpr))? fEnd ;
hex        : HEX fStart (stringExpr | numExpr) fEnd ;
hour       : HOUR fStart datetimeExpr fEnd ;
htou       : HTOU fStart stringExpr fEnd ;
include    : INCLUDE fStart stringExpr sep stringExpr fEnd ;
insert     : INSERT fStart stringExpr sep stringExpr sep numExpr fEnd ;
intf       : INTF fStart numExpr fEnd ;
ipmt       : IPMT fStart numExpr sep numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
isblank    : ISBLANK fStart stringExpr fEnd ;
isdefined  : ISDEFINED fStart stringExpr fEnd ;
isfuzzydup : ISFUZZYDUP fStart stringExpr sep stringExpr sep numExpr (sep numExpr)? fEnd ;
last       : LAST fStart stringExpr sep numExpr fEnd ;

//Expressions
expr       : numExpr
           | datetimeExpr
		   | stringExpr
		   | boolExpr
		   ;
numExpr    : <assoc=right> numExpr '^' numExpr     #exponent
           | numExpr WS? '/' WS? numExpr           #divide
           | numExpr WS? '*' WS? numExpr           #multiply
		   | numExpr WS? '-' WS? numExpr           #subtract
		   | numExpr WS? '+' WS? numExpr           #add
		   | (DATETIME | DATE | datetimeFunc | TIME) WS? '-' WS? datetimeExpr   #subtractDatetimes
		   | '(' WS? datetimeExpr WS? ')' WS? '-' WS? datetimeExpr  #parenthesisSubtractDatetimes
		   | '-' numExpr             #negative
		   | '(' WS? numExpr WS? ')' #numParenthesis
		   | numFunc                 #numFunction
		   | OBJNAME                 #numAclObjectName
		   | NUM                     #number
		   | INT+                    #integer
		   ;
datetimeExpr: datetimeExpr WS? '+' WS? numExpr   #datePlusNumber
           | numExpr WS? '+' WS? datetimeExpr    #numberPlusDate
           | '(' WS? datetimeExpr WS? ')'        #dateParenthesis
           | datetimeFunc                        #dateFunction
		   | OBJNAME                             #dateAclObjectName
           | DATETIME                            #datetime
           | DATE                                #date
		   | TIME                                #time
		   ;
stringExpr : stringExpr '+' stringExpr #concatenate
           | '(' WS? stringExpr WS? ')'#stringParenthesis
           | stringFunc                #stringFunction
		   | OBJNAME                   #stringAclObjectName
           | STRING                    #string
		   ;
boolExpr   : datetimeExpr BOOLOPS datetimeExpr
           | stringExpr BOOLOPS stringExpr
		   | numExpr BOOLOPS numExpr
           |'NOT' WS boolExpr
           | boolExpr WS ('AND' | '&') WS boolExpr
           | boolExpr WS ('OR' | '|') WS boolExpr
		   | '(' WS? boolExpr WS? ')'
           | boolFunc
		   | OBJNAME
           | BOOL
		   ;
sep        : SEP WS? | WS ;
fStart     : '(' WS? ;
fEnd       : WS? ')' ;

//Lexer testers
testVARFLD : OBJNAME ;
testNUM    : NUM ;
testSTRING : STRING ;
testDATE   : DATE ;
testBOOL   : BOOL ;
testVARSUB : VARSUB ;
testTIME   : TIME ;
testDATETIME: DATETIME ;

//Lexer rules
//Functions
ABS        : [aA][bB][sS]? ;
AGE        : [aA][gG][eE]? ;
ALLTRIM    : [aA][lL]([lL]([tT]([rR]([iI][mM]?)?)?)?)? ;
ASCII      : [aA][sS]([cC]([iI][iI]?)?)? ;
AT         : [aA][tT] ;
BETWEEN    : [bB][eE]([tT]([wW]([eE]([eE][nN]?)?)?)?)? ;
BINTOSTR   : [bB][iI][nN]([tT]([oO]([sS]([tT][rR]?)?)?)?)? ;
BIT        : [bB][iI][tT] ;
BLANKS     : [bB][lL]([aA]([nN]([kK][sS]?)?)?)? ;
BYTE       : [bB][yY]([tT][eE]?)? ;
CDOW       : [cC][dD]([oO][wW]?)? ;
CHR        : [cC][hH][rR]? ;
CLEAN      : [cC][lL]([eE]([aA][nN]?)?)? ;
CMOY       : [cC][mM]([oO][yY]?)? ;
COS        : [cC][oO][sS]? ;
CTOD       : [cC][tT][oO][dD] ;
CTODT      : [cC][tT][oO][dD][tT] ;
CTOT       : [cC][tT][oO][tT] ;
CUMPRINC   : [cC][uU][mM][pP]([rR]([iI]([nN][cC]?)?)?)? ;
CUMIPMT    : [cC][uU][mM][iI]([pP]([mM][tT]?)?)? ;
DATEF      : [dD][aA][tT][eE] ;
DATETIMEF  : [dD][aA][tT][eE][tT]([iI]([mM][eE]?)?)? ;
DAY        : [dD][aA][yY] ;
DBYTE      : [dD][bB]([yY]([tT][eE]?)?)? ;
DEC        : [dD][eE][cC]? ;
DHEX       : [dD][hH]([eE][xX]?)? ;
DICECOEFFICIENT : [dD][iI][cC]([eE]([cC]([oO]([eE]([fF]([fF]([iI]([cC]([iI]([eE]([nN][tT]?)?)?)?)?)?)?)?)?)?)?)? ;
DIGIT      : [dD][iI][gG]([iI][tT]?)? ;
DOW        : [dD][oO][wW]? ;
DTOU       : [dD][tT]([oO][uU]?)? ;
EBCDIC     : [eE][bB]([cC]([dD]([iI][cC]?)?)?)? ;
EFFECTIVE  : [eE][fF]([fF]([eE]([cC]([tT]([iI]([vV][eE]?)?)?)?)?)?)? ;
EOMONTH    : [eE][oO]([mM]([oO]([nN]([tT][hH]?)?)?)?)? ;
EXCLUDE    : [eE][xX][cC]([lL]([uU]([dD][eE]?)?)?)? ;
EXP        : [eE][xX][pP] ;
FILESIZE   : [fF][iI][lL]([eE]([sS]([iI]([zZ][eE]?)?)?)?)? ;
FIND       : [fF][iI][nN][dD]? ;
FREQUENCY  : [fF][rR]([eE]([qQ]([uU]([eE]([nN]([cC][yY]?)?)?)?)?)?)? ;
FTYPE      : [fF][tT]([yY]([pP][eE]?)?)? ;
FVANNUITY  : [fF][vV][aA]([nN]([nN]([uU]([iI]([tT][yY]?)?)?)?)?)? ;
FVLUMPSUM  : [fF][vV][lL]([uU]([mM]([pP]([sS]([uU][mM]?)?)?)?)?)? ;
FVSCHEDULE : [fF][vV][sS]([cC]([hH]([eE]([dD]([uU]([lL][eE]?)?)?)?)?)?)? ;
GETOPTIONS : [gG][eE]([tT]([oO]([pP]([tT]([iI]([oO]([nN][sS]?)?)?)?)?)?)?)? ;
GOMONTH    : [gG][oO]([mM]([oO]([nN]([tT][hH]?)?)?)?)? ;
HASH       : [hH][aA]([sS][hH]?)? ;
HEX        : [hH][eE][xX]? ;
HOUR       : [hH][oO]([uU][rR]?)? ;
HTOU       : [hH][tT]([oO][uU]?)? ;
INCLUDE    : [iI][nN][cC]([lL]([uU]([dD][eE]?)?)?)? ;
INSERT     : [iI][nN][sS]([eE]([rR][tT]?)?)? ;
INTF       : [iI][nN][tT] ;
IPMT       : [iI][pP]([mM][tT]?)? ;
ISBLANK    : [iI][sS][bB]([lL]([aA]([nN][kK]?)?)?)? ;
ISDEFINED  : [iI][sS][dD]([eE]([fF]([iI]([nN]([eE][dD]?)?)?)?)?)? ;
ISFUZZYDUP : [iI][sS][fF]([uU]([zZ]([zZ]([yY]([dD]([uU][pP]?)?)?)?)?)?)? ;
LAST       : [lL][aA]([sS][tT]?)? ;

//Values
BOOLOPS    : '>' | '<' | '=' | '>=' | '<=' | '<>' ;
VARSUB     : '%' ALPHA (ALPHA | INT)* '%';
BOOL       : 'T' | 'F' ;
DATE       : '`' INT INT INT INT INT INT (INT INT)? '`' ;
TIME       : '`' ('t' | 'T') INT INT INT INT (INT INT)? '`' ;
DATETIME   : '`' INT INT INT INT INT INT (INT INT)? ('t'|'T'|' ') INT INT INT INT (INT INT)? '`' ;
STRING     : '\'' ~['\r\n]* '\'' 
           | '"' ~["\r\n]* '"'
		   ;
NUM        : INT+ '.' INT*
           | '.' INT+
		   ;
OBJNAME    : ALPHA (ALPHA | INT)* ;
INT        : [0-9] ;
ALPHA      : [a-zA-Z_] ;

//Whitespace and end of line
SEP        : ';' | ',' ;
EOL        : '\r'? '\n' ; 
WS         : ' '+ ;
