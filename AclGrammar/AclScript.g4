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
		   | length
		   | levdist
		   | log
		   | maximum
		   | minimum
		   | minute
		   | mod
		   | month
		   | nominal
		   | normdist
		   | normsinv
		   | nper
		   | occurs
		   | offsetnum
		   | packed
		   | pi
		   | pmt
		   | ppmt
		   | pvannuity
		   | pvlumpsum
		   | rand
		   | rate
		   | reclen
		   | recno
		   | recoffsetnum
		   | root
		   | round
		   | second
		   | sin
		   | tan
		   | unsigned
		   | value
		   | workday
		   | year
		   | zstat
		   ;
datetimeFunc: ctod
           | ctodt
		   | ctot
		   | eomonth
		   | gomonth
		   | hour
		   | now
		   | offsetdtm
		   | recoffsetdtm
		   | stod
		   | stodt
		   | stot
		   | today
		   | utod
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
		   | leading
		   | lower
		   | ltrim
		   | mask
		   | offsetstr
		   | omit
		   | proper
		   | properties
		   | recoffsetstr
		   | regexfind
		   | regexreplace
		   | remove
		   | repeat
		   | replace
		   | reverse
		   | rjustify
		   | shift
		   | soundex
		   | split
		   | stringf
		   | substring
		   | timef
		   | transform
		   | trim
		   | upper
		   | zoned
           ;
boolFunc   : between
           | find
		   | isblank
		   | isdefined
		   | isfuzzydup
		   | map
		   | match
		   | soundslike
		   | test
		   | verify
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
leading    : LEADING fStart numExpr sep numExpr fEnd ;
length     : LENGTH fStart stringExpr fEnd ;
levdist    : LEVDIST fStart stringExpr sep stringExpr (sep boolExpr)? fEnd ;
log        : LOG fStart numExpr sep numExpr fEnd ;
lower      : LOWER fStart stringExpr fEnd ;
ltrim      : LTRIM fStart stringExpr fEnd ;
map        : MAP fStart stringExpr sep stringExpr fEnd ;
mask       : MASK fStart stringExpr sep stringExpr fEnd ;
match      : MATCH fStart stringExpr (sep stringExpr)+ fEnd
           | MATCH fStart numExpr (sep numExpr)+ fEnd
		   | MATCH fStart datetimeExpr (sep datetimeExpr)+ fEnd
		   | MATCH fStart boolExpr (sep boolExpr)+ fEnd
		   ;
maximum    : MAXIMUM fStart numExpr sep numExpr fEnd ;
minimum    : MINIMUM fStart numExpr sep numExpr fEnd ;
minute     : MINUTE fStart datetimeExpr fEnd ;
mod        : MOD fStart numExpr sep numExpr fEnd ;
month      : MONTH fStart datetimeExpr fEnd ;
nominal    : NOMINAL fStart numExpr sep numExpr fEnd ;
normdist   : NORMDIST fStart numExpr sep numExpr sep numExpr sep boolExpr fEnd ;
normsinv   : NORMSINV fStart numExpr fEnd ;
now        : NOW fStart fEnd ;
nper       : NPER fStart numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
occurs     : OCCURS fStart stringExpr sep stringExpr fEnd ;
offsetnum  : OFFSET fStart numExpr sep numExpr fEnd ;
offsetstr  : OFFSET fStart stringExpr sep numExpr fEnd ;
offsetdtm  : OFFSET fStart datetimeExpr sep numExpr fEnd ;
omit       : OMIT fStart stringExpr sep stringExpr (sep boolExpr)? fEnd ;
packed     : PACKED fStart numExpr sep numExpr fEnd ;
pi         : PI fStart fEnd ;
pmt        : PMT fStart numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
ppmt       : PPMT fStart numExpr sep numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
proper     : PROPER fStart stringExpr fEnd ;
properties : PROPERTIES fStart stringExpr sep stringExpr sep stringExpr fEnd ;
pvannuity  : PVANNUITY fStart numExpr sep numExpr sep numExpr (sep numExpr)? fEnd ;
pvlumpsum  : PVLUMPSUM fStart numExpr sep numExpr sep numExpr fEnd ;
rand       : RAND fStart numExpr fEnd ;
rate       : RATE fStart numExpr sep numExpr sep numExpr fEnd ;
reclen     : RECLEN fStart fEnd ;
recno      : RECNO fStart fEnd ;
recoffsetstr: RECOFFSET fStart stringExpr sep numExpr fEnd ;
recoffsetnum: RECOFFSET fStart numExpr sep numExpr fEnd ;
recoffsetdtm: RECOFFSET fStart datetimeExpr sep numExpr fEnd ;
regexfind  : REGEXFIND fStart stringExpr sep stringExpr fEnd ;
regexreplace: REGEXREPLACE fStart stringExpr sep stringExpr sep stringExpr fEnd ;
remove     : REMOVE fStart stringExpr sep stringExpr fEnd ;
repeat     : REPEAT fStart stringExpr sep numExpr fEnd ;
replace    : REPLACE fStart stringExpr sep stringExpr sep stringExpr fEnd ;
reverse    : REVERSE fStart stringExpr fEnd ;
rjustify   : RJUSTIFY fStart stringExpr fEnd ;
root       : ROOT fStart numExpr sep numExpr fEnd ;
round      : ROUND fStart numExpr fEnd ;
second     : SECOND fStart datetimeExpr fEnd ;
shift      : SHIFT fStart stringExpr sep numExpr fEnd ;
sin        : SIN fStart numExpr fEnd ;
soundex    : SOUNDEX fStart stringExpr fEnd ;
soundslike : SOUNDSLIKE fStart stringExpr sep stringExpr fEnd ;
split      : SPLIT fStart stringExpr sep stringExpr sep numExpr (sep stringExpr)? fEnd ;
stod       : STOD fStart numExpr (sep datetimeExpr)? fEnd ;
stodt      : STODT fStart numExpr (sep datetimeExpr)? fEnd ;
stot       : STOT fStart numExpr (sep datetimeExpr)? fEnd ;
stringf    : STRINGF fStart numExpr sep numExpr (sep stringExpr)? fEnd ;
substring  : SUBSTRING fStart stringExpr sep numExpr sep numExpr fEnd ;
tan        : TAN fStart numExpr fEnd ;
test       : TEST fStart numExpr sep stringExpr fEnd ;
timef      : TIMEF fStart (datetimeExpr (sep stringExpr)?)? fEnd ;
today      : TODAY fStart fEnd ;
transform  : TRANSFORM fStart stringExpr fEnd ;
trim       : TRIM fStart stringExpr fEnd ;
unsigned   : UNSIGNED fStart numExpr sep numExpr fEnd ;
upper      : UPPER fStart stringExpr fEnd ;
utod       : UTOD fStart stringExpr (sep stringExpr (sep numExpr)?)? fEnd ;
value      : VALUE fStart stringExpr sep numExpr fEnd ;
verify     : VERIFY fStart (stringExpr | numExpr | datetimeExpr) fEnd ;
workday    : WORKDAY fStart datetimeExpr sep datetimeExpr (sep stringExpr)? fEnd ;
year       : YEAR fStart datetimeExpr fEnd ;
zoned      : ZONED fStart numExpr sep numExpr fEnd ;
zstat      : ZSTAT fStart numExpr sep numExpr sep numExpr fEnd ;

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
LEADING    : [lL][eE][aA]([dD]([iI]([nN][gG]?)?)?)? ;
LENGTH     : [lL][eE][nN]([gG]([tT][hH]?)?)? ;
LEVDIST    : [lL][eE][vV]([dD]([iI]([sS][tT]?)?)?)? ;
LOG        : [lL][oO][gG] ;
LOWER      : [lL][oO][wW]([eE][rR]?)? ;
LTRIM      : [lL][tT]([rR]([iI][mM]?)?)? ;
MAP        : [mM][aA][pP] ;
MASK       : [mM][aA][sS][kK]? ;
MATCH      : [mM][aA][tT]([cC][hH]?)? ;
MAXIMUM    : [mM][aA][xX]([iI]([mM]([uU][mM]?)?)?)? ;
MINIMUM    : [mM][iI][nN]([iI]([mM]([uU][mM]?)?)?)? ;
MINUTE     : [mM][iI][nN][uU]([tT][eE]?)? ;
MOD        : [mM][oO][dD] ;
MONTH      : [mM][oO][nN]([tT][hH]?)? ;
NOMINAL    : [nN][oO][mM]([iI]([nN]([aA][lL]?)?)?)? ;
NORMDIST   : [nN][oO][rR][mM][dD]([iI]([sS][tT]?)?)? ;
NORMSINV   : [nN][oO][rR][mM][sS]([iI]([nN][vV]?)?)? ;
NOW        : [nN][oO][wW] ;
NPER       : [nN][pP][eE][rR] ;
OCCURS     : [oO][cC]([cC]([uU]([rR][sS]?)?)?)? ;
OFFSET     : [oO][fF][fF]([sS]([eE][tT]?)?)? ;
OMIT       : [oO][mM]([iI][tT]?)? ;
PACKED     : [pP][aA]([cC]([kK]([eE][dD]?)?)?)? ;
PI         : [pP][iI] ;
PMT        : [pP][mM][tT]? ;
PPMT       : [pP][pP]([mM][tT]?)? ;
PROPER     : [pP][rR][oO][pP][eE][rR] ;
PROPERTIES : [pP][rR][oO][pP][eE][rR][tT]([iI]([eE][sS]?)?)? ;
PVANNUITY  : [pP][vV][aA]([nN]([nN]([uU]([iI]([tT][yY]?)?)?)?)?)? ;
PVLUMPSUM  : [pP][vV][lL]([uU]([mM]([pP]([sS]([uU][mM]?)?)?)?)?)? ;
RAND       : [rR][aA][nN][dD]? ;
RATE       : [rR][aA][tT][eE]? ;
RECLEN     : [rR][eE][cC][lL]([eE][nN]?)? ;
RECNO      : [rR][eE][cC][nN][oO]? ;
RECOFFSET  : [rR][eE][cC][oO]([fF]([fF]([sS]([eE][tT]?)?)?)?)? ;
REGEXFIND  : [rR][eE][gG][eE][xX][fF]([iI]([nN][dD]?)?)? ;
REGEXREPLACE: [rR][eE][gG][eE][xX][rR]([eE]([pP]([lL]([aA]([cC][eE]?)?)?)?)?)? ;
REMOVE     : [rR][eE][mM]([oO]([vV][eE]?)?)? ;
REPEAT     : [rR][eE][pP][eE]([aA][tT]?)? ;
REPLACE    : [rR][eE][pP][lL]([aA]([cC][eE]?)?)? ;
REVERSE    : [rR][eE][vV]([eE]([rR]([sS][eE]?)?)?)? ;
RJUSTIFY   : [rR][jJ]([uU]([sS]([tT]([iI]([fF][yY]?)?)?)?)?)? ;
ROOT       : [rR][oO][oO][tT]? ;
ROUND      : [rR][oO][uU]([nN][dD]?)? ;
SECOND     : [sS][eE]([cC]([oO]([nN][dD]?)?)?)? ;
SHIFT      : [sS][hH]([iI]([fF][tT]?)?)? ;
SIN        : [sS][iI][nN]? ;
SOUNDEX    : [sS][oO][uU][nN][dD][eE][xX]? ;
SOUNDSLIKE : [sS][oO][uU][nN][dD][sS]([lL]([iI]([kK][eE]?)?)?)? ;
SPLIT      : [sS][pP]([lL]([iI][tT]?)?)? ;
STOD       : [sS][tT][oO][dD] ;
STODT      : [sS][tT][oO][dD][tT] ;
STOT       : [sS][tT][oO][tT] ;
STRINGF    : [sS][tT][rR]([iI]([nN][gG]?)?)? ;
SUBSTRING  : [sS][uU]([bB]([sS]([tT]([rR]([iI]([nN][gG]?)?)?)?)?)?)? ;
TAN        : [tT][aA][nN]? ;
TEST       : [tT][eE]([sS][tT]?)? ;
TIMEF      : [tT][iI]([mM][eE]?)? ;
TODAY      : [tT][oO]([dD]([aA][yY]?)?)? ;
TRANSFORM  : [tT][rR][aA]([nN]([sS]([fF]([oO]([rR][mM]?)?)?)?)?)? ;
TRIM       : [tT][rR][iI][mM]? ;
UNSIGNED   : [uU][nN]([sS]([iI]([gG]([nN]([eE][dD]?)?)?)?)?)? ;
UPPER      : [uU][pP]([pP]([eE][rR]?)?)? ;
UTOD       : [uU][tT]([oO][dD]?)? ;
VALUE      : [vV][aA]([lL]([uU][eE]?)?)? ;
VERIFY     : [vV][eE]([rR]([iI]([fF][yY]?)?)?)? ;
WORKDAY    : [wW]([oO]([rR]([kK]([dD]([aA][yY]?)?)?)?)?)? ;
YEAR       : [yY]([eE]([aA][rR]?)?)? ;
ZONED      : [zZ][oO]([nN]([eE][dD]?)?)? ;
ZSTAT      : [zZ][sS]([tT]([aA][tT]?)?)? ;

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
