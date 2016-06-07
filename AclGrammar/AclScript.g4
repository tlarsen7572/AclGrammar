grammar AclScript;
//Parser rules
command    : accept
           | activate
		   | agecmd
		   | assign
		   | benford
		   | calculate
		   | classify
		   | close
		   | count
		   | crosstab
		   | definecol
		   | definefld
		   | definefldc
		   | definerel
		   | definerpt
		   | definetabdb
		   | defineview
		   | delete
		   | dialog
		   | directory
		   | display
		   | doreport
		   | doscript
		   | duplicates
		   | escape
		   | evaluate
		   | execute
		   | export
		   | extract
		   | fieldshift
		   | find
		   | fuzzydup
		   | gaps
		   | help
		   | histogram
		   | if
		   | importacc
		   | importdel
		   | importxl
		   | importgrcp
		   | importgrcr
		   | importlayout
		   | importodbc
		   | importpdf
		   | importprint
		   | importsap
		   | importxbrl
		   | importxml
		   | index
		   | join
		   | locate
		   | merge
		   | notes
		   | notify
		   | open
		   | password
		   | pause
		   | print
		   | profile
		   | quit
		   | random
		   | refresh
		   | rename
		   | report
		   | retrieve
		   | sample
		   | save
		   | savelayout
		   | savelog
		   | saveworkspace
		   | seek
		   | sequence
		   ;

//commands
accept     : WS? ACCEPT WS stringExpr acceptFldParm? toObjParm cend ;
activate   : WS? ACTIVATE workspaceParm okParm? cend ;
agecmd     : WS? AGECMD agecmdP agecmdP? agecmdP? agecmdP? agecmdP? agecmdP? agecmdP? agecmdP? agecmdP?
             agecmdP? agecmdP? agecmdP? agecmdP? agecmdP? agecmdP? cend
		   ;
agecmdP    : onOptDateParm //required
           | cutoffParm
           | intervalParm
		   | suppressParm
		   | subtotalParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | toAnyParm
		   | keyParm
		   | headerParm
		   | footerParm
		   | appendParm
		   | localParm
		   | statParm
		   ;
assign     : WS? (ASSIGN WS)? aclobject WS? EQ WS? expr ifParm? cend ;
benford    : WS? BENFORD benfordP benfordP? benfordP? benfordP? benfordP? benfordP? benfordP? benfordP?
             benfordP? benfordP? benfordP? benfordP? cend
		   ;
benfordP   : onOptNumParm //required
           | leadingParm
		   | ifParm
		   | boundsParm
		   | toAnyParm
		   | headerParm
		   | footerParm
		   | whileParm
		   | firstNextParm
		   | appendParm
		   | openParm
		   | localParm
		   ;
calculate  : WS? CALCULATE WS expr renamefield cend ;
classify   : WS? CLASSIFY classifyP classifyP? classifyP? classifyP? classifyP? classifyP? classifyP? classifyP?
             classifyP? classifyP? classifyP? classifyP? classifyP? classifyP? classifyP? cend
		   ;
classifyP  : onOptAnyParm //required
           | subtotalParm
		   | intervalsParm
		   | suppressParm
		   | toAnyParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | headerParm
		   | footerParm
		   | keyParm
		   | openParm
		   | appendParm
		   | localParm
		   | statParm
		   ;
close      : WS? CLOSE (WS (stringExpr | INDEX | LOG | LEARN | PRIMARY (WS SECONDARY)? | SECONDARY (WS PRIMARY)?))? cend ;
count      : WS? COUNT countP? countP? countP? cend ;
countP     : ifParm
           | whileParm
		   | firstNextParm
		   ;
crosstab   : WS? CROSSTAB crosstabP crosstabP crosstabP crosstabP? crosstabP? crosstabP? crosstabP? crosstabP?
             crosstabP? crosstabP? crosstabP? crosstabP? crosstabP? cend
		   ;
crosstabP  : onOptStrListParm //required
           | columnsStrParm //required
		   | subtotalParm
		   | toAnyParm //required
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | appendParm
		   | countParm
		   | openParm
		   | localParm
		   | headerParm
		   | footerParm
		   ;
definecol  : WS? DEFINE WS COLUMN WS aclobject fieldAsParm definecolP? definecolP? definecolP? definecolP?
             definecolP? definecolP? definecolP? definecolP? definecolP? cend
		   ;
definecolP : positionParm
           | widthParm
		   | picParm
		   | sortParm
		   | isKeyParm
		   | pageParm
		   | noDupsParm
		   | noZeroesParm
		   | lineParm
		   ;
definefld  : WS? DEFINE WS FIELD WS aclobject WS datatype WS numExpr WS numExpr (WS numExpr)? nDateTimeParm? picParm?
             renamefield? widthParm? cend
           ;
definefldc : WS? DEFINE WS FIELD WS aclobject WS COMPUTED WS expr WS? cend
           | WS? DEFINE WS FIELD WS aclobject WS COMPUTED WS? EOL
		     WS? (IF WS boolExpr)? (WS? STATIC)? (WS? WIDTH WS numExpr)? (WS? PIC WS stringExpr)? (WS? AS WS stringExpr)? WS? EOL
			 (WS? expr ifParm WS? EOL)*
			 WS? expr cend
		   ;
definerel  : WS? DEFINE WS RELATION WS aclobject definerelP definerelP cend ;
definerelP : withParm | indexParm ;
definerpt  : WS? DEFINE WS REPORT WS aclobject cend ;
definetabdb: WS? DEFINE WS TABLE WS DB definetabdbP definetabdbP definetabdbP definetabdbP? definetabdbP? definetabdbP?
             definetabdbP? definetabdbP? definetabdbP? definetabdbP? cend
		   ;
definetabdbP: sourceParm //required
           | passwordParm //allowed twice
		   | formatParm
		   | schemaParm //required
		   | titledParm
		   | WS (PRIMARY | SECONDARY)
		   | (WS DBTABLE WS stringExpr WS FIELDS WS (stringExpr | ALL))+ //required
		   | whereParm
		   | orderParm
		   ;
defineview : WS? DEFINE WS VIEW WS aclobject defineviewP? defineviewP? defineviewP? defineviewP?
             defineviewP? defineviewP? defineviewP? defineviewP? defineviewP? defineviewP? cend
		   ;
defineviewP: rlinesParm
           | allParm
		   | suppressParm
		   | summarizedParm
		   | ifParm
		   | whileParm
		   | headerParm
		   | footerParm
		   | toStrParm (WS HTML)?
		   | okParm
		   ;
delete     : WS? DELETE WS (
               (FOLDER | FORMAT | REPORT | SCRIPT | BATCH | WORKSPACE | INDEX) WS aclobject
			 | NOTES
			 | aclobject
			 | ALL
			 | COLUMN WS aclobject WS aclobject allParm?
			 | HISTORY WS numExpr
			 | RELATION WS aclobject
			 | stringExpr
			 ) okParm? cend
		   ;
dialog     : WS? DIALOG WS LP WS? DIALOG WS TITLE WS stringExpr widthParm heightParm WS? RP
             WS? LP WS? BUTTONSET WS TITLE WS stringExpr WS dialogat WS DEFAULT WS numExpr (WS HORZ)? WS? RP
			 (
			   WS? LP
			   (
			     WS? TEXT WS TITLE WS stringExpr WS dialogat (WS (CENTER | RIGHT))?
				|WS? EDIT WS dialogstd widthParm? heightParm? (WS DEFAULT WS stringExpr)?
				|WS? CHECKBOX WS TITLE WS stringExpr WS dialogstd widthParm? heightParm? (WS CHECKED)?
				|WS? RADIOBUTTON WS TITLE WS stringExpr WS dialogstd (WS DEFAULT WS numExpr)? (WS HORZ)?
				|WS? DROPDOWN WS TITLE WS stringExpr WS dialogstd (WS DEFAULT WS numExpr)?
				|WS? ITEM WS TITLE WS stringExpr WS dialogstd (WS DEFAULT WS stringExpr)?
			   ) WS? RP
			 )* cend
		   ;
dialogstd  : TO WS stringExpr WS dialogat ;
dialogat   : AT WS numExpr sep numExpr widthParm? heightParm? ;
directory  : WS? DIRECTORY directoryP? directoryP? directoryP? directoryP? directoryP? cend ;
directoryP : WS stringExpr
           | suppressParm
		   | subDirParm
		   | appendParm
		   | toStrParm
		   ;
display    : WS? DISPLAY
             (WS
			   ( OPEN
			   | PRIMARY
			   | SECONDARY
			   | HISTORY
			   | RELATION
			   | aclobject
			   | VARIABLES
			   | VERSION
			   | DATEPARM
			   | TIMEPARM
			   | FREE
			   | SPACE
			   )
			 )? cend
		   ;
doreport   : WS? DO WS REPORT WS aclobject cend ;
doscript   : WS? DO (WS SCRIPT)? doscriptP doscriptP? cend ;
doscriptP  : WS (aclobject | stringExpr) //required
           | ifOrWhileParm
		   ;
duplicates : WS? DUPLICATES duplicatesP duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP?
             duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP? duplicatesP? cend
		   ;
duplicatesP: (WS ON)? (WS aclobject)+ //required
           | WS D
		   | otherParm
		   | unformattedParm
		   | toAnyParm
		   | appendParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | headerParm
		   | footerParm
		   | presortParm
		   | openParm
		   | localParm
		   | isolocaleParm
		   ;
escape     : WS? ESCAPE (WS ALL)? ifParm? cend ;
evaluate   : WS? EVALUATE WS
               ( MONETARY errorLimitParm intervalParm
			   | RECORD sizeParm errorParm )
		     confidenceParm toStrScrParm? cend
		   ;
execute    : WS? EXECUTE executeP executeP? cend ;
executeP   : WS stringExpr //required
           | asyncParm
		   ;
export     : WS? EXPORT exportP exportP exportP? exportP? exportP? exportP? exportP? exportP? exportP? exportP? exportP?
             exportP? exportP? exportP? exportP? cend
		   ;
exportP    : (WS FIELDS)? WS (ALL | savefield (sep savefield)*) //required
           | WS exporttype //required
		   | isSchemaParm
		   | toStrParm
		   | passwordParm
		   | overwriteParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | unicodeParm
		   | appendParm
		   | keepTitleParm
		   | separatorParm
		   | qualifierParm
		   | worksheetParm
		   ;
extract    : WS? EXTRACT extractP extractP extractP? extractP? extractP? extractP? extractP? extractP? extractP? cend ;
extractP   :  WS (RECORD | (FIELDS WS)? ALL | FIELDS WS savefield WS savefield*) //required
           | toStrParm //required
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | eofParm
		   | appendParm
		   | openParm
		   | localParm
		   ;
fieldshift : WS? FIELDSHIFT fieldshiftP fieldshiftP fieldshiftP? fieldshiftP? cend ;
fieldshiftP: startParm //required
           | columnsNumParm //required
		   | filterParm
		   | okParm
		   ;
find       : WS? FIND any* cend ;
fuzzydup   : WS? FUZZYDUP fuzzydupP fuzzydupP fuzzydupP fuzzydupP? fuzzydupP? fuzzydupP? fuzzydupP? fuzzydupP?
             fuzzydupP? fuzzydupP? cend
		   ;
fuzzydupP  : onStrParm //required
           | otherParm
		   | levdistanceParm //required
		   | diffPctParm
		   | resultsizeParm
		   | exactParm
		   | ifParm
		   | toStrParm //required
		   | localParm
		   | openParm
		   ;
gaps       : WS? GAPS gapsP gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? gapsP? cend ;
gapsP      : (WS ON)? WS expr (WS D)? (sep expr (WS D)?)* //required
           | unformattedParm
		   | presortParm
		   | missingParm
		   | headerParm
		   | footerParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | toAnyParm
		   | appendParm
		   | localParm
		   | openParm
		   ;
help       : WS? HELP cend ;
histogram  : WS? HISTOGRAM histogramP histogramP? histogramP? histogramP? histogramP? histogramP? histogramP? histogramP?
             histogramP? histogramP? histogramP? histogramP? histogramP? cend
		   ;
histogramP :  (WS ON)? (WS stringExpr | WS numExpr minimumParm maximumParm intervalsParm? freeParm? ) //required
           | toAnyParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | headerParm
		   | footerParm
		   | keyParm
		   | suppressParm
		   | columnsNumParm
		   | appendParm
		   | localParm
		   | openParm
		   ;
if         : WS? IF WS boolExpr WS command cend ;
importacc  : WS? IMPORT WS ACCESS importaccP importaccP importaccP importaccP importaccP importaccP importaccP? cend ;
importaccP : toObjParm //required
           | passwordParm
		   | WS stringExpr //required
		   | fromParm //required
		   | tableParm //required
		   | charmaxParm //required
		   | memomaxParm //required
		   ;
importdel  : WS? IMPORT WS DELIMITED importdelP importdelP importdelP importdelP importdelP importdelP importdelP importdelP
             importdelP? importdelP? importdelP? importdelP? importdelP? cend
		   ;
importdelP : toObjParm WS stringExpr //required
           | fromParm //required
		   | serverParm
		   | WS INT //required
		   | separatorParm //required
		   | qualifierParm //required
		   | consecutiveParm //required
		   | startLineParm //required
		   | keepTitleParm
		   | crClearParm
		   | lfClearParm
		   | fieldSyntaxDel fieldSyntaxDel* //required
		   | ignoreParm
		   ;
importxl   : WS? IMPORT WS EXCEL importxlP importxlP importxlP importxlP importxlP? importxlP? importxlP? cend
		   ;
importxlP  : toObjParm WS stringExpr //required
           | fromParm //required
		   | tableParm //required
		   | (charmaxParm | WS fieldSyntaxXl (sep fieldSyntaxXl)*) //required
		   | ignoreParm
		   | keepTitleParm
		   | openParm
		   ;
importgrcp : WS? IMPORT WS GRCPROJECT toObjParm WS stringExpr passwordParm? fromParm cend ;
importgrcr : WS? IMPORT WS GRCRESULTS toObjParm WS stringExpr passwordParm? fromParm
               ( withCommentsParm? fieldSyntaxGrcR fieldSyntaxGrcR*
			   | interpretationParm withCommentsParm? )
			 cend
		   ;
importlayout:WS? IMPORT WS LAYOUT WS stringExpr toStrParm cend ;
importodbc : WS? IMPORT WS ODBC importodbcP importodbcP importodbcP? importodbcP? importodbcP? importodbcP?
             importodbcP? importodbcP? importodbcP? importodbcP? importodbcP? cend ;
importodbcP: sourceParm //required
           | tableParm //required
		   | qualifierParm
		   | ownerParm
		   | userIdParm
		   | passwordParm
		   | whereParm
		   | toStrParm
		   | widthParm
		   | maximumParm
		   | WS FIELDS WS stringExpr (sep stringExpr)*
		   ;
importpdf  : WS? IMPORT WS PDF importpdfP importpdfP importpdfP importpdfP importpdfP importpdfP?
             importpdfP? importpdfP? importpdfP? cend ;
importpdfP : toObjParm //required
           | passwordParm
		   | WS stringExpr //required
		   | fromParm //required
		   | serverParm
		   | WS numExpr //required
		   | parserParm
		   | pagesParm
		   | recordSyntaxTxt+ //required
		   ;
importprint: WS? IMPORT WS PRINT importprintP importprintP importprintP importprintP importprintP importprintP? cend ;
importprintP:toObjParm //required
           | WS stringExpr //required
		   | fromParm //required
		   | serverParm
		   | WS numExpr (WS numExpr)? //required
		   | recordSyntaxTxt+ //required
		   ;
importsap  : WS? IMPORT WS SAP passwordParm toObjParm sourceParm WS dlQuery cend ;
importxbrl : WS? IMPORT WS XBRL importxbrlP importxbrlP importxbrlP importxbrlP importxbrlP? cend ;
importxbrlP: toObjParm WS stringExpr //required
		   | fromParm //required
		   | contextParm //required
		   | fieldSyntaxXbrl+ //required
		   | ignoreParm
		   ;
importxml  : WS? IMPORT WS XML importxmlP importxmlP importxmlP cend ;
importxmlP : toObjParm WS stringExpr //required
           | fromParm //required
		   | fieldSyntaxXml+ //required
		   ;
index      : WS? INDEX indexP indexP indexP? indexP? indexP? indexP? indexP? cend ;
indexP     : (WS ON)? WS aclobject (WS D)? (WS aclobject (WS D)?)* //required
           | toStrParm //required
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | openParm
		   | isolocaleParm
		   ;
join       : WS? JOIN joinP joinP joinP joinP joinP? joinP? joinP? joinP? joinP? joinP? joinP? joinP? joinP?
             joinP? joinP? cend ;
joinP      : WS (PRIMARY | BOTH | SECONDARY | PRIMARY WS SECONDARY | UNMATCHED | MANY)
           | pkeyParm //Required
		   | (fieldsParm | WS FIELDS WS ALL)  //Required
		   | skeyParm //Required
		   | (withFieldsParm | WS WITH WS ALL)
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | toStrParm //Required
		   | localParm
		   | openParm
		   | appendParm
		   | presortParm
		   | secsortParm
		   | isolocaleParm
		   ;
locate     : WS? LOCATE ( ifParm whileParm? firstNextParm? | WS RECORD WS numExpr) ;
merge      : WS? MERGE mergeP mergeP mergeP? mergeP? mergeP? mergeP? mergeP? mergeP? mergeP? cend ;
mergeP     : (onAnyListParm | pkeyParm skeyParm) //required
           | toStrParm //required
		   | presortParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | appendParm
		   | isolocaleParm
		   | openParm
		   ;
notes      : WS? NOTES notesP notesP? notesP? notesP? cend ;
notesP     : ifParm
           | textParm
		   | appendParm
		   | clearParm
		   ;
notify     : WS? NOTIFY notifyP notifyP notifyP notifyP notifyP? notifyP? notifyP? notifyP? notifyP? cend ;
notifyP    : WS USER WS stringExpr //Required
           | WS PASSWORD WS stringExpr
		   | WS MAILBOX WS stringExpr //Required
		   | WS ADDRESS WS stringExpr //Required
		   | WS CC WS stringExpr
		   | WS BCC WS stringExpr
		   | WS SUBJECT WS stringExpr
		   | WS MESSAGE WS stringExpr //Required
		   | WS ATTACHMENT WS stringExpr
		   ;
open       : WS? OPEN openP openP? openP? openP? openP? openP? openP? openP? openP? cend ;
openP      : WS stringExpr //required
           | formatParm
		   | bufferlengthParm
		   | crlfParm
		   | dbaseParm
		   | indexObjParm
		   | WS (PRIMARY | SECONDARY)
		   | skipParm
		   | relationParm
		   ;
password   : WS? PASSWORD WS numExpr (WS stringExpr)? cend ;
pause      : WS? PAUSE WS stringExpr ifParm? cend ;
print      : WS? PRINT WS (stringExpr | GRAPH) cend ;
profile    : WS? PROFILE profileP profileP? profileP? profileP? cend ;
profileP   : (WS FIELDS)? WS (numExpr (WS numExpr)* | ALL) //Required
           | ifParm
		   | whileParm
		   | firstNextParm
		   ;
quit       : WS? QUIT cend ;
random     : WS? RANDOM randomP randomP randomP randomP? randomP? randomP? randomP? randomP? randomP? cend ;
randomP    : numberParm //Required
           | seedParm
		   | minimumParm //Required
		   | maximumParm //Required
		   | uniqueParm
		   | columnsNumParm
		   | sortedParm
		   | toStrScrParm
		   | appendParm
		   ;
refresh    : WS? REFRESH WS aclobject passwordParm? cend ;
rename     : WS? RENAME renameP renameP renameP renameP? cend ;
renameP    : itemtypeParm //Required
           | WS stringExpr //Required
		   | WS (AS | TO) WS stringExpr //required
		   | okParm
		   ;
report     : WS? REPORT reportP reportP reportP? reportP? reportP? reportP? reportP? reportP? reportP?
             reportP? reportP? reportP? reportP? reportP? reportP? cend ;
reportP    : reportOnParm //Required
           | fldOrSubtotalParm //Required
		   | suppressParm
		   | noZeroesParm
		   | lineFldsParm+
		   | summarizeParm
		   | skipParm
		   | eofParm
		   | toStrScrPrntParm
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | headerParm
		   | footerParm
		   | appendParm
		   ;
retrieve   : WS? RETRIEVE WS aclobject passwordParm cend ;
sample     : WS? SAMPLE sampleP sampleP sampleP sampleP? sampleP? sampleP? sampleP? sampleP? sampleP?
             sampleP? sampleP? cend ;
sampleP    : (sampleRec | sampleMus) //Required
           | ifParm
		   | whileParm
		   | firstNextParm
		   | headerParm
		   | footerParm
		   | toStrParm //Required
		   | ((WS ORDER)? fieldsParm | WS RECORD) //Required
		   | appendParm
		   | openParm
		   | localParm
		   ;
sampleRec  : onOptRecParm
               ( WS INTERVAL WS numExpr WS FIXED WS numExpr
			   | WS CELL WS INTERVAL WS numExpr WS RANDOM WS numExpr
			   | WS RANDOM WS numExpr WS NUMBER WS numExpr ) ;
sampleMus  : onOptNumParm
               ( WS INTERVAL WS numExpr WS FIXED WS numExpr WS CUTOFF WS numExpr
			   | WS CELL WS INTERVAL WS numExpr WS CUTOFF WS numExpr WS RANDOM WS numExpr
			   | WS RANDOM WS numExpr WS NUMBER WS numExpr WS POPULATION WS numExpr )
			 subsampleParm? replacementParm? ;
save       : WS? SAVE (WS aclobject WS FORMAT WS aclobject)? cend ;
savelayout : WS? SAVE WS LAYOUT WS (FILE | TABLE) toStrParm ;
savelog    : WS? SAVE WS LOG savelogP savelogP savelogP? savelogP? cend ;
savelogP   : sessionParm
           | asParm //Required
		   | WS (ASCII | HTML) //Required
		   | okParm
		   ;
saveworkspace: WS? SAVE WS WORKSPACE WS aclobject WS aclobject (WS aclobject)* cend ;
seek       : WS? SEEK WS stringExpr cend ;
sequence   : WS? SEQUENCE sequenceP sequenceP? sequenceP? sequenceP? sequenceP? sequenceP? sequenceP?
             sequenceP? sequenceP? sequenceP? sequenceP? sequenceP? sequenceP? cend ;
sequenceP  : (WS ON)? (WS FIELDS)? fieldAsParm (WS D)? (fieldAsParm (WS D)?)* //Required
           | unformattedParm
		   | WS ERRORLIMIT WS numExpr
		   | ifParm
		   | whileParm
		   | firstNextParm
		   | toStrScrPrntParm
		   | appendParm
		   | headerParm
		   | footerParm
		   | presortParm
		   | localParm
		   | isolocaleParm
		   ;

//command parameters
acceptFldParm   : WS FIELDS WS stringExpr ;
allParm         : WS ALL ;
appendParm      : WS APPEND ;
asParm          : WS AS WS stringExpr ;
asyncParm       : WS ASYNC ;
boundsParm      : WS BOUNDS ;
bufferlengthParm: WS BUFFERLENGTH WS numExpr ;
charmaxParm     : WS CHARMAX WS numExpr ;
clearParm       : WS CLEAR ;
columnsNumParm  : WS COLUMNS WS numExpr ;
columnsStrParm  : WS COLUMNS WS stringExpr ;
consecutiveParm : WS CONSECUTIVE ;
countParm       : WS COUNT ;
confidenceParm  : WS CONFIDENCE WS numExpr ;
contextParm     : WS CONTEXT WS stringExpr (WS stringExpr)* ;
crClearParm     : WS CRCLEAR ;
crlfParm        : WS CRLF ;
cutoffParm      : WS CUTOFF WS (INT INT INT INT INT INT INT INT | VARSUB) ;
dbaseParm       : WS DBASE ;
diffPctParm     : WS DIFFPCT WS numExpr ;
eofParm         : WS EOFPARM ;
errorLimitParm  : WS ERRORLIMIT WS numExpr sep numExpr (sep numExpr sep numExpr)* ;
errorParm       : WS ERROR WS numExpr ;
exactParm       : WS EXACT ;
fieldAsParm     : WS expr renamefield? ;
fieldsParm      : WS FIELDS fieldAsParm+ ;
fieldSyntaxDel  : WS FIELD WS aclobject WS importtype WS AT WS numExpr WS DEC WS numExpr WS WID WS numExpr WS PIC WS stringExpr WS AS WS stringExpr ;
fieldSyntaxGrcR : WS FIELD WS stringExpr WS AS WS stringExpr ;
fieldSyntaxTxt  : WS FIELD WS stringExpr WS importtype WS AT WS numExpr sep numExpr WS SIZE WS numExpr sep numExpr WS DEC WS numExpr WS WID WS numExpr WS PIC WS stringExpr WS AS WS stringExpr ;
fieldSyntaxXbrl : WS FIELD WS stringExpr WS importtype WS AT WS numExpr WS DEC WS numExpr WS WID WS numExpr WS PIC WS stringExpr WS AS WS stringExpr ;
fieldSyntaxXl   : FIELD WS stringExpr WS importtype WS (PIC WS stringExpr | WID WS numExpr WS DEC WS numExpr) WS AS WS stringExpr ;
fieldSyntaxXml  : WS FIELD WS stringExpr WS importtype WS AT WS numExpr WS DEC WS numExpr WS WID WS numExpr WS PIC WS stringExpr WS AS WS stringExpr WS RULE WS stringExpr ;
filterParm      : WS FILTER WS aclobject ;
firstNextParm   : WS (FIRST | NEXT) WS numExpr ;
fldOrSubtotalParm:WS (FIELDS | SUBTOTAL) fieldAsParm fieldAsParm* ;
footerParm      : WS FOOTER WS stringExpr ;
formatParm      : WS FORMAT WS (stringExpr | aclobject) ;
freeParm        : WS FREE WS numExpr (sep numExpr)+ ;
fromParm        : WS FROM WS stringExpr ;
headerParm      : WS HEADER WS stringExpr ;
heightParm      : WS HEIGHT WS numExpr ;
ifParm          : WS IF WS boolExpr ;
ifOrWhileParm   : WS (IF | WHILE) WS boolExpr ;
ignoreParm      : WS IGNORE WS numExpr (WS IGNORE WS numExpr)* ;
indexObjParm    : WS INDEX WS aclobject ;
indexParm       : WS INDEX fieldAsParm ;
interpretationParm:WS INTERPRETATION WS stringExpr ;
intervalParm    : WS INTERVAL WS numExpr (sep numExpr)* ;
intervalsParm   : WS INTERVALS WS numExpr ;
isKeyParm       : WS KEY ;
isSchemaParm    : WS SCHEMA ;
isolocaleParm   : WS ISOLOCALE WS aclobject ;
itemtypeParm    : WS (FIELD | FORMAT | INDEX | REPORT | WORKSPACE | SCRIPT | BATCH | DATA | FILE | LOG | TEXT) ;
keepTitleParm   : WS KEEPTITLE ;
keyParm         : WS KEY WS aclobject ;
leadingParm     : WS LEADINGPARM WS INT ;
levdistanceParm : WS LEVDISTANCE WS numExpr ;
lfClearParm     : WS LFCLEAR ;
lineParm        : WS LINE WS numExpr;
lineFldsParm    : WS LINE WS numExpr fieldAsParm fieldAsParm* ;
localParm       : WS LOCAL ;
maximumParm     : WS MAXIMUM WS numExpr ;
memomaxParm     : WS MEMOMAX WS numExpr ;
minimumParm     : WS MINIMUM WS numExpr ;
missingParm     : WS MISSING WS numExpr ;
nDateTimeParm   : WS NDATETIME ;
noDupsParm      : WS NODUPS ;
noZeroesParm    : WS NOZEROES ;
numberParm      : WS NUMBER WS numExpr ;
okParm          : WS OK ;
onAnyListParm   : WS ON WS expr (WS expr)* ;
onOptAnyParm    : (WS ON)? WS expr ;
onOptDateParm   : (WS ON)? WS datetimeExpr ;
onOptNumParm    : (WS ON)? WS numExpr ;
onOptRecParm    : (WS ON)? WS RECORD ;
onOptStrParm    : (WS ON)? WS stringExpr ;
onOptStrListParm: onOptStrParm (WS stringExpr)* ;
onStrParm       : WS ON WS stringExpr ;
openParm        : WS OPEN ;
orderParm       : WS ORDER WS stringExpr ;
otherParm       : WS OTHER WS expr (sep expr)* ;
overwriteParm   : WS OVERWRITE ;
ownerParm       : WS OWNER WS stringExpr ;
pageParm        : WS PAGE ;
pagesParm       : WS PAGES WS stringExpr ;
parserParm      : WS PARSER WS stringExpr ;
passwordParm    : WS PASSWORD WS numExpr ;
picParm         : WS PIC WS stringExpr ;
pkeyParm        : WS PKEY fieldAsParm+ ;
positionParm    : WS POSITION WS numExpr ;
presortParm     : WS PRESORT ;
qualifierParm   : WS QUALIFIER WS stringExpr ;
recordSyntaxTxt : WS RECORD WS stringExpr WS numExpr WS numExpr WS numExpr testSyntaxTxt+ fieldSyntaxTxt+ ;
relationParm    : WS RELATION WS expr ;
renamefield     : WS AS WS stringExpr ;
replacementParm : WS (REPLACEMENT | NOREPLACEMENT) ;
reportOnParm    : (WS ON)? WS expr (WS NODUPS)? (WS PAGE)? (WS expr (WS NODUPS)? (WS PAGE)?)* ;
resultsizeParm  : WS RESULTSIZE WS numExpr ;
rlinesParm      : WS RLINES WS numExpr ;
savefield       : aclobject renamefield? ;
schemaParm      : WS SCHEMA WS stringExpr ;
secsortParm     : WS SECSORT ;
seedParm        : WS SEED WS numExpr ;
separatorParm   : WS SEPARATOR WS stringExpr ;
serverParm      : WS SERVER WS aclobject ;
sessionParm     : WS SESSION ;
sizeParm        : WS SIZE WS numExpr ;
skeyParm        : WS SKEY fieldAsParm+ ;
skipParm        : WS SKIP WS numExpr ;
sortParm        : WS SORT (WS D)? ;
sortedParm      : WS SORTED ;
sourceParm      : WS SOURCE WS stringExpr ;
startLineParm   : WS STARTLINE WS numExpr ;
startParm       : WS START WS numExpr ;
statParm        : WS STATISTICS ;
subDirParm      : WS SUBDIRECTORY ;
subsampleParm   : WS SUBSAMPLE ;
subtotalParm    : WS SUBTOTAL WS numExpr (WS numExpr)* ;
summarizedParm  : WS SUMMARIZED ;
summarizeParm   : WS SUMMARIZE ;
suppressParm    : WS SUPPRESS ;
tableParm       : WS TABLE WS stringExpr ;
testSyntaxTxt   : WS TEST WS numExpr WS numExpr WS AT WS numExpr sep numExpr sep numExpr WS numExpr WS stringExpr ;
textParm        : WS TEXT WS stringExpr ;
titledParm      : WS TITLED WS stringExpr ;
toAnyParm       : WS TO WS (SCREEN | stringExpr | GRAPH | PRINT) ;
toObjParm       : WS TO WS aclobject ;
toStrParm       : WS TO WS stringExpr ;
toStrScrParm    : WS TO WS (SCREEN | stringExpr) ;
toStrScrPrntParm: WS TO WS (SCREEN | stringExpr | PRINT) ;
unformattedParm : WS UNFORMATTED ;
unicodeParm     : WS UNICODE ;
uniqueParm      : WS UNIQUE ;
userIdParm      : WS USERID WS stringExpr ;
whereParm       : WS WHERE WS stringExpr ;
whileParm       : WS WHILE WS boolExpr ;
widthParm       : WS WIDTH WS numExpr ;
withParm        : WS WITH WS aclobject ;
withCommentsParm: WS WITHCOMMENTS ;
withFieldsParm  : WS WITH fieldAsParm+ ;
worksheetParm   : WS WORKSHEET WS (aclobject | stringExpr) ;
workspaceParm   : (WS WORKSPACE)? WS aclobject ;

//function groups
func       : numFunc
           | datetimeFunc
		   | stringFunc
		   | boolFunc
		   ;
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
           | findf
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
ascii      : ASCIIF fStart stringExpr fEnd ;
at         : ATF fStart numExpr sep stringExpr sep stringExpr fEnd ;
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
clean      : CLEANF fStart stringExpr sep stringExpr fEnd ;
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
dec        : DECF fStart numExpr sep numExpr fEnd ;
dhex       : DHEX fStart stringExpr fEnd ;
dicecoefficient : DICECOEFFICIENT fStart stringExpr sep stringExpr (sep numExpr)? fEnd ;
digit      : DIGIT fStart numExpr sep numExpr fEnd ;
dow        : DOW fStart datetimeExpr fEnd ;
dtou       : DTOU fStart (datetimeExpr (sep stringExpr (sep numExpr)?)?)? fEnd ;
ebcdic     : EBCDICF fStart stringExpr fEnd ;
effective  : EFFECTIVE fStart numExpr sep numExpr fEnd ;
eomonth    : EOMONTH fStart (datetimeExpr (sep numExpr)?)? fEnd ;
exclude    : EXCLUDE fStart stringExpr sep stringExpr fEnd ;
exp        : EXP fStart numExpr sep numExpr fEnd ;
filesize   : FILESIZE fStart stringExpr fEnd ;
findf      : FINDF fStart stringExpr (sep stringExpr)? fEnd ;
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
last       : LASTF fStart stringExpr sep numExpr fEnd ;
leading    : LEADING fStart numExpr sep numExpr fEnd ;
length     : LENGTH fStart stringExpr fEnd ;
levdist    : LEVDIST fStart stringExpr sep stringExpr (sep boolExpr)? fEnd ;
log        : LOGF fStart numExpr sep numExpr fEnd ;
lower      : LOWER fStart stringExpr fEnd ;
ltrim      : LTRIM fStart stringExpr fEnd ;
map        : MAP fStart stringExpr sep stringExpr fEnd ;
mask       : MASK fStart stringExpr sep stringExpr fEnd ;
match      : MATCH fStart stringExpr (sep stringExpr)+ fEnd
           | MATCH fStart numExpr (sep numExpr)+ fEnd
		   | MATCH fStart datetimeExpr (sep datetimeExpr)+ fEnd
		   | MATCH fStart boolExpr (sep boolExpr)+ fEnd
		   ;
maximum    : MAXIMUMF fStart numExpr sep numExpr fEnd ;
minimum    : MINIMUMF fStart numExpr sep numExpr fEnd ;
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
packed     : PACKEDF fStart numExpr sep numExpr fEnd ;
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
test       : TESTF fStart numExpr sep stringExpr fEnd ;
timef      : TIMEF fStart (datetimeExpr (sep stringExpr)?)? fEnd ;
today      : TODAY fStart fEnd ;
transform  : TRANSFORM fStart stringExpr fEnd ;
trim       : TRIM fStart stringExpr fEnd ;
unsigned   : UNSIGNEDF fStart numExpr sep numExpr fEnd ;
upper      : UPPER fStart stringExpr fEnd ;
utod       : UTOD fStart stringExpr (sep stringExpr (sep numExpr)?)? fEnd ;
value      : VALUE fStart stringExpr sep numExpr fEnd ;
verify     : VERIFYF fStart (stringExpr | numExpr | datetimeExpr) fEnd ;
workday    : WORKDAY fStart datetimeExpr sep datetimeExpr (sep stringExpr)? fEnd ;
year       : YEAR fStart datetimeExpr fEnd ;
zoned      : ZONEDF fStart numExpr sep numExpr fEnd ;
zstat      : ZSTAT fStart numExpr sep numExpr sep numExpr fEnd ;

//Data types
datatype   : numtype
           | stringtype
		   | datetimetype
		   | booltype
		   ;
numtype    : ACCPAC
           | ACL
		   | BASIC
		   | BINARY
		   | FLOAT
		   | HALFBYTE
		   | IBMFLOAT
		   | MICRO
		   | NUMERIC
		   | PACKED
		   | PRINT
		   | UNISYS
		   | UNSIGNED
		   | VAXFLOAT
		   | ZONED
		   ;
stringtype : ASCII
           | CUSTOM
		   | EBCDIC
		   | NOTE
		   | PCASCII
		   | UNICODE
		   ;
datetimetype: DATETIMETY ;
booltype   : LOGICAL ;
exporttype : ACCESS
           | ACLGRC
		   | ASCII
		   | CLIPBOARD
		   | DBASE
		   | DELIMITED
		   | EXCEL
		   | JSON
		   | LOTUS
		   | WDPF6
		   | WORD
		   | WP
		   | XLS21
		   | XLSX
		   | XML
		   ;
importtype : A|B|C|D|E|F|G|I|K|L|N|P|Q|R|S|T|U|V|X|Y|Z ;
graphtype  : PIE2D | PIE3D | BAR2D | BAR3D | STACKED2D | STACKED3D | LAYERED | LINE | BENFORD ;

//Expressions
expr       : numExpr
           | datetimeExpr
		   | stringExpr
		   | boolExpr
		   ;
numExpr    : <assoc=right> numExpr WS? '^' WS? numExpr                          #exponent
           | numExpr WS? '/' WS? numExpr                                        #divide
           | numExpr WS? '*' WS? numExpr                                        #multiply
		   | numExpr WS? '-' WS? numExpr                                        #subtract
		   | numExpr WS? '+' WS? numExpr                                        #add
		   | (DATETIME | DATE | datetimeFunc | TIME) WS? '-' WS? datetimeExpr   #subtractDatetimes
		   | LP WS? datetimeExpr WS? RP   WS? '-' WS? datetimeExpr              #parenthesisSubtractDatetimes
		   | '-' numExpr                                                        #negative
		   | LP WS? numExpr WS? RP                                              #numParenthesis
		   | numFunc                                                            #numFunction
		   | aclobject                                                          #numAclObjectName
		   | NUM                                                                #number
		   | INT+                                                               #integer
		   ;
datetimeExpr: datetimeExpr WS? '+' WS? numExpr   #datePlusNumber
           | numExpr WS? '+' WS? datetimeExpr    #numberPlusDate
           | LP WS? datetimeExpr WS? RP          #dateParenthesis
           | datetimeFunc                        #dateFunction
		   | aclobject                           #dateAclObjectName
           | DATETIME                            #datetime
           | DATE                                #date
		   | TIME                                #time
		   ;
stringExpr : stringExpr WS? '+' WS? stringExpr #concatenate
           | LP WS? stringExpr WS? RP  #stringParenthesis
           | stringFunc                #stringFunction
		   | aclobject                 #stringAclObjectName
           | STRING                    #string
		   ;
boolExpr   : datetimeExpr WS? boolops WS? datetimeExpr
           | stringExpr WS? boolops WS? stringExpr
		   | numExpr WS? boolops WS? numExpr
		   | boolExpr WS? boolops WS? boolExpr
           |'NOT' WS boolExpr
           | boolExpr WS ('AND' | '&') WS boolExpr
           | boolExpr WS ('OR' | '|') WS boolExpr
		   | LP WS? boolExpr WS? RP
           | boolFunc
		   | aclobject
           | bool
		   ;
boolops    : EQ | GT | GE | LT | LE | NE ;
aclobject  : aclobject '.' aclobject
           | (OBJNAME | keyword)? VARSUB (OBJNAME | keyword)?
           | OBJNAME
		   | keyword
           ;
sep        : WS? SEP WS? | WS ;
fStart     : WS? ;
fEnd       : WS? RP ;
cend       : WS? (EOL | EOF) ;

//Lexer testers
testVARFLD : OBJNAME | keyword ;
testNUM    : NUM ;
testSTRING : STRING ;
testDATE   : DATE ;
testBOOL   : bool ;
testVARSUB : VARSUB ;
testTIME   : TIME ;
testDATETIME: DATETIME ;

//Lexer rules
//Commands
ACCEPT     : [aA][cC][cC][eE][pP][tT] ;
ACTIVATE   : [aA][cC][tT][iI][vV][aA][tT][eE] ;
AGECMD     : [aA][gG][eE] ;
ASSIGN     : [aA][sS][sS][iI][gG][nN] ;
ASYNC      : [aA][sS][yY][nN][cC] ;
AT         : [aA][tT] ;
BENFORD    : [bB][eE][nN][fF][oO][rR][dD] ;
CALCULATE  : [cC][aA][lL][cC][uU][lL][aA][tT][eE] ;
CLASSIFY   : [cC][lL][aA][sS][sS][iI][fF][yY] ;
CLOSE      : [cC][lL][oO][sS][eE] ;
COUNT      : [cC][oO][uU][nN][tT] ;
CROSSTAB   : [cC][rR][oO][sS][sS][tT][aA][bB] ;
DEFINE     : [dD][eE][fF][iI][nN][eE] ;
DELETE     : [dD][eE][lL][eE][tT][eE] ;
DIALOG     : [dD][iI][aA][lL][oO][gG] ;
DIRECTORY  : [dD][iI][rR][eE][cC][tT][oO][rR][yY] ;
DISPLAY    : [dD][iI][sS][pP][lL][aA][yY] ;
DO         : [dD][oO] ;
DUPLICATES : [dD][uU][pP][lL][iI][cC][aA][tT][eE][sS] ;
ESCAPE     : [eE][sS][cC][aA][pP][eE] ;
EVALUATE   : [eE][vV][aA][lL][uU][aA][tT][eE] ;
EXECUTE    : [eE][xX][eE][cC][uU][tT][eE] ;
EXPORT     : [eE][xX][pP][oO][rR][tT] ;
EXTRACT    : [eE][xX][tT][rR][aA][cC][tT] ;
FIELDSHIFT : [fF][iI][eE][lL][dD][sS][hH][iI][fF][tT] ;
FIND       : [fF][iI][nN][dD] ;
FUZZYDUP   : [fF][uU][zZ][zZ][yY][dD][uU][pP] ;
GAPS       : [gG][aA][pP][sS] ;
HELP       : [hH][eE][lL][pP] ;
HISTOGRAM  : [hH][iI][sS][tT][oO][gG][rR][aA][mM] ;
IF         : [iI][fF] ;
IMPORT     : [iI][mM][pP][oO][rR][tT] ;
INDEX      : [iI][nN][dD][eE][xX] ;
JOIN       : [jJ][oO][iI][nN] ;
LOCATE     : [lL][oO][cC][aA][tT][eE] ;
MERGE      : [mM][eE][rR][gG][eE] ;
NOTES      : [nN][oO][tT][eE][sS] ;
NOTIFY     : [nN][oO][tT][iI][fF][yY] ;
OPEN       : [oO][pP][eE][nN] ;
PASSWORD   : [pP][aA][sS][sS][wW][oO][rR][dD] ;
PAUSE      : [pP][aA][uU][sS][eE] ;
PRINT      : [pP][rR][iI][nN][tT] ;
PROFILE    : [pP][rR][oO][fF][iI][lL][eE] ;
QUIT       : [qQ][uU][iI][tT] ;
RANDOM     : [rR][aA][nN][dD][oO][mM] ;
REFRESH    : [rR][eE][fF][rR][eE][sS][hH] ;
RENAME     : [rR][eE][nN][aA][mM][eE] ;
REPORT     : [rR][eE][pP][oO][rR][tT] ;
RETRIEVE   : [rR][eE][tT][rR][iI][eE][vV][eE] ;
SAMPLE     : [sS][aA][mM][pP][lL][eE] ;
SAVE       : [sS][aA][vV][eE] ;
SEEK       : [sS][eE][eE][kK] ;
SEQUENCE   : [sS][eE][qQ][uU][eE][nN][cC][eE] ;
SET        : [sS][eE][tT] ;
SORT       : [sS][oO][rR][tT] ;
STATISTICS : [sS][tT][aA][tT][iI][sS][tT][iI][cC][sS] ;
SUMMARIZE  : [sS][uU][mM][mM][aA][rR][iI][zZ][eE] ;
VERIFY     : [vV][eE][rR][iI][fF][yY] ;

//Other keywords
A          : [aA] ;
ACCESS     : [aA][cC][cC][eE][sS][sS] ;
ACCPAC     : [aA][cC][cC][pP][aA][cC] ;
ACL        : [aA][cC][lL] ;
ACLGRC     : [aA][cC][lL][gG][rR][cC] ;
ADDRESS    : [aA][dD][dD][rR][eE][sS][sS] ;
ALL        : [aA][lL][lL] ;
APPEND     : [aA][pP][pP][eE][nN][dD] ;
AS         : [aA][sS] ;
ASCII      : [aA][sS][cC][iI][iI] ;
ATTACHMENT : [aA][tT][tT][aA][cC][hH][mM][eE][nN][tT] ;
B          : [bB] ;
BAR2D      : [bB][aA][rR]'2'[dD] ;
BAR3D      : [bB][aA][rR]'3'[dD] ;
BASIC      : [bB][aA][sS][iI][cC] ;
BATCH      : [bB][aA][tT][cC][hH] ;
BCC        : [bB][cC][cC] ;
BEEP       : [bB][eE][eE][pP] ;
BINARY     : [bB][iI][nN][aA][rR][yY] ;
BOTH       : [bB][oO][tT][hH] ;
BOUNDS     : [bB][oO][uU][nN][dD][sS] ;
BUFFERLENGTH:[bB][uU][fF][fF][eE][rR][lL][eE][nN][gG][tT][hH] ;
BUTTONSET  : [bB][uU][tT][tT][oO][nN][sS][eE][tT] ;
C          : [cC] ;
CC         : [cC][cC] ;
CELL       : [cC][eE][lL][lL] ;
CENTER     : [cC][eE][nN][tT][eE][rR] ;
CENTURY    : [cC][eE][nN][tT][uU][rR][yY] ;
CHARMAX    : [cC][hH][aA][rR][mM][aA][xX] ;
CHECKBOX   : [cC][hH][eE][cC][kK][bB][oO][xX] ;
CHECKED    : [cC][hH][eE][cC][kK][eE][dD] ;
CLEAN      : [cC][lL][eE][aA][nN] ;
CLEAR      : [cC][lL][eE][aA][rR] ;
CLIPBOARD  : [cC][lL][iI][pP][bB][oO][aA][rR][dD] ;
CRLF       : [cC][rR][lL][fF] ;
COLUMN     : [cC][oO][lL][uU][mM][nN] ;
COLUMNS    : [cC][oO][lL][uU][mM][nN][sS] ;
COMPUTED   : [cC][oO][mM][pP][uU][tT][eE][dD] ;
CONFIDENCE : [cC][oO][nN][fF][iI][dD][eE][nN][cC][eE] ;
CONSECUTIVE: [cC][oO][nN][sS][eE][cC][uU][tT][iI][vV][eE] ;
CONTEXT    : [cC][oO][nN][tT][eE][xX][tT] ;
CRCLEAR    : [cC][rR][cC][lL][eE][aA][rR] ;
CUSTOM     : [cC][uU][sS][tT][oO][mM] ;
CUTOFF     : [cC][uU][tT][oO][fF][fF] ;
D          : [dD] ;
DATA       : [dD][aA][tT][aA] ;
DATEPARM   : [dD][aA][tT][eE] ;
DATETIMETY : [dD][aA][tT][eE][tT][iI][mM][eE] ;
DB         : [dD][bB] ;
DBASE      : [dD][bB][aA][sS][eE] ;
DBTABLE    : [dD][bB][tT][aA][bB][lL][eE] ;
DEC        : [dD][eE][cC] ;
DEFAULT    : [dD][eE][fF][aA][uU][lL][tT] ;
DELIMITED  : [dD][eE][lL][iI][mM][iI][tT][eE][dD] ;
DESIGNATION: [dD][eE][sS][iI][gG][nN][aA][tT][iI][oO][nN] ;
DIFFPCT    : [dD][iI][fF][fF][pP][cC][tT] ;
DROPDOWN   : [dD][rR][oO][pP][dD][oO][wW][nN] ;
E          : [eE] ;
EBCDIC     : [eE][bB][cC][dD][iI][cC] ;
ECHO       : [eE][cC][hH][oO] ;
EDIT       : [eE][dD][iI][tT] ;
EOFPARM    : [eE][oO][fF] ;
ERROR      : [eE][rR][rR][oO][rR] ;
ERRORLIMIT : [eE][rR][rR][oO][rR][lL][iI][mM][iI][tT] ;
EXACT      : [eE][xX][aA][cC][tT] ;
EXCEL      : [eE][xX][cC][eE][lL] ;
F          : [fF] ;
FIELD      : [fF][iI][eE][lL][dD] ;
FIELDS     : [fF][iI][eE][lL][dD][sS] ;
FILE       : [fF][iI][lL][eE] ;
FILTER     : [fF][iI][lL][tT][eE][rR] ;
FIRST      : [fF][iI][rR][sS][tT] ;
FIXED      : [fF][iI][xX][eE][dD] ;
FLOAT      : [fF][lL][oO][aA][tT] ;
FOLDER     : [fF][oO][lL][dD][eE][rR] ;
FOOTER     : [fF][oO][oO][tT][eE][rR] ;
FORMAT     : [fF][oO][rR][mM][aA][tT] ;
FREE       : [fF][rR][eE][eE] ;
FROM       : [fF][rR][oO][mM] ;
FUZZYGROUPSIZE: [fF][uU][zZ][zZ][yY][gG][rR][oO][uU][pP][sS][iI][zZ][eE] ;
G          : [gG] ;
GRAPH      : [gG][rR][aA][pP][hH] ;
GRCPROJECT : [gG][rR][cC][pP][rR][oO][jJ][eE][cC][tT] ;
GRCRESULTS : [gG][rR][cC][rR][eE][sS][uU][lL][tT][sS] ;
HALFBYTE   : [hH][aA][lL][fF][bB][yY][tT][eE] ;
HEADER     : [hH][eE][aA][dD][eE][rR] ;
HEIGHT     : [hH][eE][iI][gG][hH][tT] ;
HISTORY    : [hH][iI][sS][tT][oO][rR][yY] ;
HORZ       : [hH][oO][rR][zZ] ;
HTML       : [hH][tT][mM][lL] ;
I          : [iI] ;
IBMFLOAT   : [iI][bB][mM][fF][lL][oO][aA][tT] ;
IGNORE     : [iI][gG][nN][oO][rR][eE] ;
INTERPRETATION:[iI][nN][tT][eE][rR][pP][rR][eE][tT][aA][tT][iI][oO][nN] ;
INTERVAL   : [iI][nN][tT][eE][rR][vV][aA][lL] ;
INTERVALS  : [iI][nN][tT][eE][rR][vV][aA][lL][sS] ;
ISOLOCALE  : [iI][sS][oO][lL][oO][cC][aA][lL][eE] ;
ITEM       : [iI][tT][eE][mM] ;
JSON       : [jJ][sS][oO][nN] ;
K          : [kK] ;
KEEPTITLE  : [kK][eE][eE][pP][tT][iI][tT][lL][eE] ;
KEY        : [kK][eE][yY] ;
L          : [lL] ;
LAST       : [lL][aA][sS][tT] ;
LAYERED    : [lL][aA][yY][eE][rR][eE][dD] ;
LAYOUT     : [lL][aA][yY][oO][uU][tT] ;
LEADINGPARM: [lL][eE][aA][dD][iI][nN][gG] ;
LEARN      : [lL][eE][aA][rR][nN] ;
LEVDISTANCE: [lL][eE][vV][dD][iI][sS][tT][aA][nN][cC][eE] ;
LFCLEAR    : [lL][fF][cC][lL][eE][aA][rR] ;
LINE       : [lL][iI][nN][eE] ;
LOCAL      : [lL][oO][cC][aA][lL] ;
LOG        : [lL][oO][gG] ;
LOGICAL    : [lL][oO][gG][iI][cC][aA][lL] ;
LOTUS      : [lL][oO][tT][uU][sS] ;
MAILBOX    : [mM][aA][iI][lL][bB][oO][xX] ;
MANY       : [mM][aA][nN][yY] ;
MARGIN     : [mM][aA][rR][gG][iI][nN] ;
MATH       : [mM][aA][tT][hH] ;
MAX        : [mM][aA][xX] ;
MAXIMUM    : [mM][aA][xX][iI][mM][uU][mM] ;
MEMOMAX    : [mM][eE][mM][oO][mM][aA][xX] ;
MESSAGE    : [mM][eE][sS][sS][aA][gG][eE] ;
MICRO      : [mM][iI][cC][rR][oO] ;
MIN        : [mM][iI][nN] ;
MINIMUM    : [mM][iI][nN][iI][mM][uU][mM] ;
MISSING    : [mM][iI][sS][sS][iI][nN][gG] ;
MONETARY   : [mM][oO][nN][eE][tT][aA][rR][yY] ;
MONTHS     : [mM][oO][nN][tT][hH][sS] ;
N          : [nN] ;
NEXT       : [nN][eE][xX][tT] ;
NDATETIME  : [nN][dD][aA][tT][eE][tT][iI][mM][eE] ;
NODUPS     : [nN][oO][dD][uU][pP][sS] ;
NONE       : [nN][oO][nN][eE] ;
NOREPLACEMENT:[nN][oO][rR][eE][pP][lL][aA][cC][eE][mM][eE][nN][tT] ;
NOTE       : [nN][oO][tT][eE] ;
NOTIFYFAILSTOP: [nN][oO][tT][iI][fF][yY][fF][aA][iI][lL][sS][tT][oO][pP] ;
NOTIFYRETRYATTEMPTS: [nN][oO][tT][iI][fF][yY][rR][eE][tT][rR][yY][aA][tT][tT][eE][mM][pP][tT][sS] ;
NOTIFYRETRYINTERVAL: [nN][oO][tT][iI][fF][yY][rR][eE][tT][rR][yY][iI][nN][tT][eE][rR][vV][aA][lL] ;
NOZEROES   : [nN][oO][zZ][eE][rR][oO][eE][sS] ;
NUMBER     : [nN][uU][mM][bB][eE][rR] ;
NUMERIC    : [nN][uU][mM][eE][rR][iI][cC] ;
ODBC       : [oO][dD][bB][cC] ;
OFF        : [oO][fF][fF] ;
OK         : [oO][kK] ;
ON         : [oO][nN] ;
ORDER      : [oO][rR][dD][eE][rR] ;
OTHER      : [oO][tT][hH][eE][rR] ;
OWNER      : [oO][wW][nN][eE][rR] ;
OVERFLOW   : [oO][vV][eE][rR][fF][lL][oO][wW] ;
OVERWRITE  : [oO][vV][eE][rR][wW][rR][iI][tT][eE] ;
P          : [pP] ;
PACKED     : [pP][aA][cC][kK][eE][dD] ;
PAGE       : [pP][aA][gG][eE] ;
PAGES      : [pP][aA][gG][eE][sS] ;
PARSER     : [pP][aA][rR][sS][eE][rR] ;
PCASCII    : [pP][cC][aA][sS][cC][iI][iI] ;
PDF        : [pP][dD][fF] ;
PERIODS    : [pP][eE][rR][iI][oO][dD][sS] ;
PIC        : [pP][iI][cC] ;
PICTURE    : [pP][iI][cC][tT][uU][rR][eE] ;
PIE2D      : [pP][iI][eE]'2'[dD] ;
PIE3D      : [pP][iI][eE]'3'[dD] ;
PKEY       : [pP][kK][eE][yY] ;
POPULATION : [pP][oO][pP][uU][lL][aA][tT][iI][oO][nN] ;
POSITION   : [pP][oO][sS][iI][tT][iI][oO][nN] ;
PRESORT    : [pP][rR][eE][sS][oO][rR][tT] ;
PRIMARY    : [pP][rR][iI][mM][aA][rR][yY] ;
Q          : [qQ] ;
QUALIFIER  : [qQ][uU][aA][lL][iI][fF][iI][eE][rR] ;
R          : [rR] ;
RADIOBUTTON: [rR][aA][dD][iI][oO][bB][uU][tT][tT][oO][nN] ;
READAHEAD  : [rR][eE][aA][dD][aA][hH][eE][aA][dD] ;
RECORD     : [rR][eE][cC][oO][rR][dD] ;
RELATION   : [rR][eE][lL][aA][tT][iI][oO][nN] ;
REPLACEMENT: [rR][eE][pP][lL][aA][cC][eE][mM][eE][nN][tT] ;
RESULTSIZE : [rR][eE][sS][uU][lL][tT][sS][iI][zZ][eE] ;
RIGHT      : [rR][iI][gG][hH][tT] ;
RLINES     : [rR][lL][iI][nN][eE][sS] ;
RULE       : [rR][uU][lL][eE] ;
S          : [sS] ;
SAFETY     : [sS][aA][fF][eE][tT][yY] ;
SAP        : [sS][aA][pP] ;
SCHEMA     : [sS][cC][hH][eE][mM][aA] ;
SCREEN     : [sS][cC][rR][eE][eE][nN] ;
SCRIPT     : [sS][cC][rR][iI][pP][tT] ;
SECONDARY  : [sS][eE][cC][oO][nN][dD][aA][rR][yY] ;
SECSORT    : [sS][eE][cC][sS][oO][rR][tT] ;
SEED       : [sS][eE][eE][dD] ;
SEPARATOR  : [sS][eE][pP][aA][rR][aA][tT][oO][rR] ;
SEPARATORS : [sS][eE][pP][aA][rR][aA][tT][oO][rR][sS] ;
SERVER     : [sS][eE][rR][vV][eE][rR] ;
SESSION    : [sS][eE][sS][sS][iI][oO][nN] ;
SIZE       : [sS][iI][zZ][eE] ;
SKEY       : [sS][kK][eE][yY] ;
SKIP       : [sS][kK][iI][pP] ;
SORTED     : [sS][oO][rR][tT][eE][dD] ;
SORTMEMORY : [sS][oO][rR][tT][mM][eE][mM][oO][rR][yY] ;
SOURCE     : [sS][oO][uU][rR][cC][eE] ;
SPACE      : [sS][pP][aA][cC][eE] ;
STACKED2D  : [sS][tT][aA][cC][kK][eE][dD]'2'[dD] ;
STACKED3D  : [sS][tT][aA][cC][kK][eE][dD]'3'[dD] ;
START      : [sS][tT][aA][rR][tT] ;
STARTLINE  : [sS][tT][aA][rR][tT][lL][iI][nN][eE] ;
STATIC     : [sS][tT][aA][tT][iI][cC] ;
SUBDIRECTORY:[sS][uU][bB][dD][iI][rR][eE][cC][tT][oO][rR][yY] ;
SUBJECT    : [sS][uU][bB][jJ][eE][cC][tT] ;
SUBSAMPLE  : [sS][uU][bB][sS][aA][mM][pP][lL][eE] ;
SUBTOTAL   : [sS][uU][bB][tT][oO][tT][aA][lL] ;
SUPPRESS   : [sS][uU][pP][pP][rR][eE][sS][sS] ;
SUPPRESSTIME:[sS][uU][pP][pP][rR][eE][sS][sS][tT][iI][mM][eE] ;
SUPPRESSXML: [sS][uU][pP][pP][rR][eE][sS][sS][xX][mM][lL] ;
SUMMARIZED : [sS][uU][mM][mM][aA][rR][iI][zZ][eE][dD] ;
T          : [tT] ;
TABLE      : [tT][aA][bB][lL][eE] ;
TEST       : [tT][eE][sS][tT] ;
TEXT       : [tT][eE][xX][tT] ;
TIMEPARM   : [tT][iI][mM][eE] ;
TITLE      : [tT][iI][tT][lL][eE] ;
TITLED     : [tT][iI][tT][lL][eE][dD] ;
TO         : [tT][oO] ;
U          : [uU] ;
UNFORMATTED: [uU][nN][fF][oO][rR][mM][aA][tT][tT][eE][dD] ;
UNICODE    : [uU][nN][iI][cC][oO][dD][eE] ;
UNIQUE     : [uU][nN][iI][qQ][uU][eE] ;
UNISYS     : [uU][nN][iI][sS][yY][sS] ;
UNMATCHED  : [uU][nN][mM][aA][tT][cC][hH][eE][dD] ;
UNSIGNED   : [uU][nN][sS][iI][gG][nN][eE][dD] ;
USER       : [uU][sS][eE][rR] ;
USERID     : [uU][sS][eE][rR][iI][dD] ;
UTCZONE    : [uU][tT][cC][zZ][oO][nN][eE] ;
V          : [vV] ;
VARIABLES  : [vV][aA][rR][iI][aA][bB][lL][eE][sS] ;
VERSION    : [vV][eE][rR][sS][iI][oO][nN] ;
VIEW       : [vV][iI][eE][wW] ;
W          : [wW] ;
WDPF6      : [wW][dD][pP][fF][6] ;
WHERE      : [wW][hH][eE][rR][eE] ;
WHILE      : [wW][hH][iI][lL][eE] ;
WID        : [wW][iI][dD] ;
WIDTH      : [wW][iI][dD][tT][hH] ;
WITH       : [wW][iI][tT][hH] ;
WITHCOMMENTS:[wW][iI][tT][hH][cC][oO][mM][mM][eE][nN][tT][sS] ;
WORD       : [wW][oO][rR][dD] ;
WORKSHEET  : [wW][oO][rR][kK][sS][hH][eE][eE][tT] ;
WORKSPACE  : [wW][oO][rR][kK][sS][pP][aA][cC][eE] ;
WP         : [wW][pP] ;
VAXFLOAT   : [vV][aA][xX][fF][lL][oO][aA][tT] ;
X          : [xX] ;
XBRL       : [xX][bB][rR][lL] ;
XLS21      : [xX][lL][sS][2][1] ;
XLSX       : [xX][lL][sS][xX] ;
XML        : [xX][mM][lL] ;
Y          : [yY] ;
Z          : [zZ] ;
ZONED      : [zZ][oO][nN][eE][dD] ;

//Functions
ABS        : [aA][bB][sS]? LP ;
AGE        : [aA][gG][eE]? LP ;
ALLTRIM    : [aA][lL]([lL]([tT]([rR]([iI][mM]?)?)?)?)? LP ;
ASCIIF     : [aA][sS]([cC]([iI][iI]?)?)? LP ;
ATF        : [aA][tT] LP ;
BETWEEN    : [bB][eE]([tT]([wW]([eE]([eE][nN]?)?)?)?)? LP ;
BINTOSTR   : [bB][iI][nN]([tT]([oO]([sS]([tT][rR]?)?)?)?)? LP ;
BIT        : [bB][iI][tT] LP ;
BLANKS     : [bB][lL]([aA]([nN]([kK][sS]?)?)?)? LP ;
BYTE       : [bB][yY]([tT][eE]?)? LP ;
CDOW       : [cC][dD]([oO][wW]?)? LP ;
CHR        : [cC][hH][rR]? LP ;
CLEANF     : [cC][lL]([eE]([aA][nN]?)?)? LP ;
CMOY       : [cC][mM]([oO][yY]?)? LP ;
COS        : [cC][oO][sS]? LP ;
CTOD       : [cC][tT][oO][dD] LP ;
CTODT      : [cC][tT][oO][dD][tT] LP ;
CTOT       : [cC][tT][oO][tT] LP ;
CUMPRINC   : [cC][uU][mM][pP]([rR]([iI]([nN][cC]?)?)?)? LP ;
CUMIPMT    : [cC][uU][mM][iI]([pP]([mM][tT]?)?)? LP ;
DATEF      : [dD][aA][tT][eE] LP ;
DATETIMEF  : [dD][aA][tT][eE][tT]([iI]([mM][eE]?)?)? LP ;
DAY        : [dD][aA][yY] LP ;
DBYTE      : [dD][bB]([yY]([tT][eE]?)?)? LP ;
DECF       : [dD][eE][cC]? LP ;
DHEX       : [dD][hH]([eE][xX]?)? LP ;
DICECOEFFICIENT : [dD][iI][cC]([eE]([cC]([oO]([eE]([fF]([fF]([iI]([cC]([iI]([eE]([nN][tT]?)?)?)?)?)?)?)?)?)?)?)? LP ;
DIGIT      : [dD][iI][gG]([iI][tT]?)? LP ;
DOW        : [dD][oO][wW]? LP ;
DTOU       : [dD][tT]([oO][uU]?)? LP ;
EBCDICF    : [eE][bB]([cC]([dD]([iI][cC]?)?)?)? LP ;
EFFECTIVE  : [eE][fF]([fF]([eE]([cC]([tT]([iI]([vV][eE]?)?)?)?)?)?)? LP ;
EOMONTH    : [eE][oO]([mM]([oO]([nN]([tT][hH]?)?)?)?)? LP ;
EXCLUDE    : [eE][xX][cC]([lL]([uU]([dD][eE]?)?)?)? LP ;
EXP        : [eE][xX][pP] LP ;
FILESIZE   : [fF][iI][lL]([eE]([sS]([iI]([zZ][eE]?)?)?)?)? LP ;
FINDF      : [fF][iI][nN][dD]? LP ;
FREQUENCY  : [fF][rR]([eE]([qQ]([uU]([eE]([nN]([cC][yY]?)?)?)?)?)?)? LP ;
FTYPE      : [fF][tT]([yY]([pP][eE]?)?)? LP ;
FVANNUITY  : [fF][vV][aA]([nN]([nN]([uU]([iI]([tT][yY]?)?)?)?)?)? LP ;
FVLUMPSUM  : [fF][vV][lL]([uU]([mM]([pP]([sS]([uU][mM]?)?)?)?)?)? LP ;
FVSCHEDULE : [fF][vV][sS]([cC]([hH]([eE]([dD]([uU]([lL][eE]?)?)?)?)?)?)? LP ;
GETOPTIONS : [gG][eE]([tT]([oO]([pP]([tT]([iI]([oO]([nN][sS]?)?)?)?)?)?)?)? LP ;
GOMONTH    : [gG][oO]([mM]([oO]([nN]([tT][hH]?)?)?)?)? LP ;
HASH       : [hH][aA]([sS][hH]?)? LP ;
HEX        : [hH][eE][xX]? LP ;
HOUR       : [hH][oO]([uU][rR]?)? LP ;
HTOU       : [hH][tT]([oO][uU]?)? LP ;
INCLUDE    : [iI][nN][cC]([lL]([uU]([dD][eE]?)?)?)? LP ;
INSERT     : [iI][nN][sS]([eE]([rR][tT]?)?)? LP ;
INTF       : [iI][nN][tT] LP ;
IPMT       : [iI][pP]([mM][tT]?)? LP ;
ISBLANK    : [iI][sS][bB]([lL]([aA]([nN][kK]?)?)?)? LP ;
ISDEFINED  : [iI][sS][dD]([eE]([fF]([iI]([nN]([eE][dD]?)?)?)?)?)? LP ;
ISFUZZYDUP : [iI][sS][fF]([uU]([zZ]([zZ]([yY]([dD]([uU][pP]?)?)?)?)?)?)? LP ;
LASTF      : [lL][aA]([sS][tT]?)? LP ;
LEADING    : [lL][eE][aA]([dD]([iI]([nN][gG]?)?)?)? LP ;
LENGTH     : [lL][eE][nN]([gG]([tT][hH]?)?)? LP ;
LEVDIST    : [lL][eE][vV]([dD]([iI]([sS][tT]?)?)?)? LP ;
LOGF       : [lL][oO][gG] LP ;
LOWER      : [lL][oO][wW]([eE][rR]?)? LP ;
LTRIM      : [lL][tT]([rR]([iI][mM]?)?)? LP ;
MAP        : [mM][aA][pP] LP ;
MASK       : [mM][aA][sS][kK]? LP ;
MATCH      : [mM][aA][tT]([cC][hH]?)? LP ;
MAXIMUMF   : [mM][aA][xX]([iI]([mM]([uU][mM]?)?)?)? LP ;
MINIMUMF   : [mM][iI][nN]([iI]([mM]([uU][mM]?)?)?)? LP ;
MINUTE     : [mM][iI][nN][uU]([tT][eE]?)? LP ;
MOD        : [mM][oO][dD] LP ;
MONTH      : [mM][oO][nN]([tT][hH]?)? LP ;
NOMINAL    : [nN][oO][mM]([iI]([nN]([aA][lL]?)?)?)? LP ;
NORMDIST   : [nN][oO][rR][mM][dD]([iI]([sS][tT]?)?)? LP ;
NORMSINV   : [nN][oO][rR][mM][sS]([iI]([nN][vV]?)?)? LP ;
NOW        : [nN][oO][wW] LP ;
NPER       : [nN][pP][eE][rR] LP ;
OCCURS     : [oO][cC]([cC]([uU]([rR][sS]?)?)?)? LP ;
OFFSET     : [oO][fF][fF]([sS]([eE][tT]?)?)? LP ;
OMIT       : [oO][mM]([iI][tT]?)? LP ;
PACKEDF    : [pP][aA]([cC]([kK]([eE][dD]?)?)?)? LP ;
PI         : [pP][iI] LP ;
PMT        : [pP][mM][tT]? LP ;
PPMT       : [pP][pP]([mM][tT]?)? LP ;
PROPER     : [pP][rR][oO][pP][eE][rR] LP ;
PROPERTIES : [pP][rR][oO][pP][eE][rR][tT]([iI]([eE][sS]?)?)? LP ;
PVANNUITY  : [pP][vV][aA]([nN]([nN]([uU]([iI]([tT][yY]?)?)?)?)?)? LP ;
PVLUMPSUM  : [pP][vV][lL]([uU]([mM]([pP]([sS]([uU][mM]?)?)?)?)?)? LP ;
RAND       : [rR][aA][nN][dD]? LP ;
RATE       : [rR][aA][tT][eE]? LP ;
RECLEN     : [rR][eE][cC][lL]([eE][nN]?)? LP ;
RECNO      : [rR][eE][cC][nN][oO]? LP ;
RECOFFSET  : [rR][eE][cC][oO]([fF]([fF]([sS]([eE][tT]?)?)?)?)? LP ;
REGEXFIND  : [rR][eE][gG][eE][xX][fF]([iI]([nN][dD]?)?)? LP ;
REGEXREPLACE: [rR][eE][gG][eE][xX][rR]([eE]([pP]([lL]([aA]([cC][eE]?)?)?)?)?)? LP ;
REMOVE     : [rR][eE][mM]([oO]([vV][eE]?)?)? LP ;
REPEAT     : [rR][eE][pP][eE]([aA][tT]?)? LP ;
REPLACE    : [rR][eE][pP][lL]([aA]([cC][eE]?)?)? LP ;
REVERSE    : [rR][eE][vV]([eE]([rR]([sS][eE]?)?)?)? LP ;
RJUSTIFY   : [rR][jJ]([uU]([sS]([tT]([iI]([fF][yY]?)?)?)?)?)? LP ;
ROOT       : [rR][oO][oO][tT]? LP ;
ROUND      : [rR][oO][uU]([nN][dD]?)? LP ;
SECOND     : [sS][eE]([cC]([oO]([nN][dD]?)?)?)? LP ;
SHIFT      : [sS][hH]([iI]([fF][tT]?)?)? LP ;
SIN        : [sS][iI][nN]? LP ;
SOUNDEX    : [sS][oO][uU][nN][dD][eE][xX]? LP ;
SOUNDSLIKE : [sS][oO][uU][nN][dD][sS]([lL]([iI]([kK][eE]?)?)?)? LP ;
SPLIT      : [sS][pP]([lL]([iI][tT]?)?)? LP ;
STOD       : [sS][tT][oO][dD] LP ;
STODT      : [sS][tT][oO][dD][tT] LP ;
STOT       : [sS][tT][oO][tT] LP ;
STRINGF    : [sS][tT][rR]([iI]([nN][gG]?)?)? LP ;
SUBSTRING  : [sS][uU]([bB]([sS]([tT]([rR]([iI]([nN][gG]?)?)?)?)?)?)? LP ;
TAN        : [tT][aA][nN]? LP ;
TESTF      : [tT][eE]([sS][tT]?)? LP ;
TIMEF      : [tT][iI]([mM][eE]?)? LP ;
TODAY      : [tT][oO]([dD]([aA][yY]?)?)? LP ;
TRANSFORM  : [tT][rR][aA]([nN]([sS]([fF]([oO]([rR][mM]?)?)?)?)?)? LP ;
TRIM       : [tT][rR][iI][mM]? LP ;
UNSIGNEDF  : [uU][nN]([sS]([iI]([gG]([nN]([eE][dD]?)?)?)?)?)? LP ;
UPPER      : [uU][pP]([pP]([eE][rR]?)?)? LP ;
UTOD       : [uU][tT]([oO][dD]?)? LP ;
VALUE      : [vV][aA]([lL]([uU][eE]?)?)? LP ;
VERIFYF    : [vV][eE]([rR]([iI]([fF][yY]?)?)?)? LP ;
WORKDAY    : [wW]([oO]([rR]([kK]([dD]([aA][yY]?)?)?)?)?)? LP ;
YEAR       : [yY]([eE]([aA][rR]?)?)? LP ;
ZONEDF     : [zZ][oO]([nN]([eE][dD]?)?)? LP ;
ZSTAT      : [zZ][sS]([tT]([aA][tT]?)?)? LP ;

//DirectLink tags
dlQuery     : QTAG
               STAG
			   DTAG
			   UTAG
			   CTAG
			   LGTAG
			   CFTAG
			   SFTAG
			   JCOUNTTAG
			   JNAMETAG
			   DLTAG
			   MTAG
			   RTAG
			   ARTAG
			   ETAG
               TSTAG
			     (TTAG
				   NTAG
				   ATAG
				   TDTAG
				   FSTAG
				     FTAG+
				   FSTAGEND
				   WCTAG
				     (WTAG
					   FTAG
					   OTAG
					   LTAG
					   HTAG
					 WTAGEND)*
				   WCTAGEND
				 TTAGEND)+
			   TSTAGEND
			   JSTAG
			     (JCTAG
				   PTTAG
				     PATAG
					 PFTAG
				   PTTAGEND
				   CTTAG
				     CATAG
					 CFTAG
				   CTTAGEND
				 JCTAGEND)*
			   JSTAGEND
			 QTAGEND ;

fragment STUFF: ~[<]* ;
QTAG       : '<q' ~[>]* '>' ;
QTAGEND    : '</q>' ;
STAG       : '<s>' STUFF '</s>' ;
DTAG       : '<d>' STUFF '</d>' ;
UTAG       : '<u>' STUFF '</u>' ;
CTAG       : '<c>' STUFF '</c>' ;
LGTAG      : '<lg>' STUFF '</lg>' ;
CFTAG      : '<cf>' STUFF '</cf>' ;
SFTAG      : '<sf>' STUFF '</sf>' ;
JCOUNTTAG  : '<jcount>' STUFF '</jcount>' ;
JNAMETAG   : '<jname>' STUFF '</jname>' ;
DLTAG      : '<dl>' STUFF '</dl>' ;
MTAG       : '<m>' STUFF '</m>' ;
RTAG       : '<r>' STUFF '</r>' ;
ARTAG      : '<ar>' STUFF '</ar>' ;
ETAG       : '<e>' STUFF '</e>' ;
TSTAG      : '<ts>' ;
TSTAGEND   : '</ts>' ;
TTAG       : '<t>' ;
TTAGEND    : '</t>' ;
NTAG       : '<n>' STUFF '</n>' ;
ATAG       : '<a>' STUFF '</a>' ;
TDTAG      : '<td>' STUFF '</td>' ;
FSTAG      : '<fs>' ;
FSTAGEND   : '</fs>' ;
FTAG       : '<f>' STUFF '</f>' ;
WCTAG      : '<wc>' ;
WCTAGEND   : '</wc>' ;
WTAG       : '<w>' ;
WTAGEND    : '</w>' ;
OTAG       : '<o>' STUFF '</o>' ;
LTAG       : '<l>' STUFF '</l>' ;
HTAG       : '<h>' STUFF '</h>' ;
JSTAG      : '<js>' ;
JSTAGEND   : '</js>' ;
JCTAG      : '<jc>' ;
JCTAGEND   : '</jc>' ;
PTTAG      : '<pt>' ;
PTTAGEND   : '</pt>' ;
PATAG      : '<pa>' STUFF '</pa>' ;
PFTAG      : '<pf>' STUFF '</pf>' ;
CTTAG      : '<ct>' ;
CTTAGEND   : '</ct>' ;
CATAG      : '<ca>' STUFF '</ca>' ;

//Values
GT         : '>' ;
GE         : '>=' ;
LT         : '<' ;
LE         : '<=' ;
EQ         : '=' ;
NE         : '<>' ;
LP         : '(' ;
RP         : ')' ;
VARSUB     : '%' ALPHA (ALPHA | INT)* '%';
bool       : T | F ;
DATE       : '`' INT INT INT INT INT INT (INT INT)? '`' ;
TIME       : '`' T INT INT INT INT (INT INT)? '`' ;
DATETIME   : '`' INT INT INT INT INT INT (INT INT)? (T|' ') INT INT INT INT (INT INT)? '`' ;
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

//Catch-alls
SYMB       : ~[\r\n] ;
any        : ALPHA
           | NUM
		   | INT
		   | OBJNAME
           | boolops
           | LP
		   | RP
		   | VARSUB
		   | bool
		   | DATE
		   | TIME
		   | DATETIME
		   | STRING
		   | SEP
		   | WS
		   | SYMB
		   | keyword
		   ;
keyword    : exporttype
           | importtype
           | ACCEPT
           | ACTIVATE
		   | RECNO
           ;
