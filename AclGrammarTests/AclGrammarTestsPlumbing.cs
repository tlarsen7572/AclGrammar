using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using AclGrammar;

namespace AclGrammarTests
{
    public partial class AclGrammarTests
    {
        private class AclErrorListener : BaseErrorListener, IAntlrErrorListener<int>
        {
            private int _errors = 0;

            public int errors { get { return _errors; } }

            public void SyntaxError(IRecognizer recognizer, int a, int b, int c, string str, RecognitionException exception)
            {
                _errors++;
            }

            public override void SyntaxError(IRecognizer recognizer, IToken offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
            {
                _errors++;
                base.SyntaxError(recognizer, offendingSymbol, line, charPositionInLine, msg, e);
            }
        }

        private AclScriptParser PrepareParser(string code, out AclErrorListener errorListener, out CommonTokenStream tokens)
        {
            errorListener = new AclErrorListener();
            AntlrInputStream input = new AntlrInputStream(code);
            AclScriptLexer lexer = new AclScriptLexer(input);
            lexer.AddErrorListener(errorListener);
            tokens = new CommonTokenStream(lexer);
            AclScriptParser parser = new AclScriptParser(tokens);
            parser.AddErrorListener(errorListener);
            tokens.Fill();
            return parser;
        }

        private void VarTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            parser.testVARFLD();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void VarSubTester(string code, bool expectErrors, int expectedTokens)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            parser.testVARSUB();
            Assert.AreEqual(expectErrors, listener.errors > 0);
            Assert.AreEqual(expectedTokens, tokens.Size);
        }

        private void NumValTester(string code, bool expectErrors, int expectedChildren)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.numExpr();
            Assert.AreEqual(expectErrors, listener.errors > 0);
            Assert.AreEqual(expectedChildren, context.ChildCount);
        }

        private void DatetimeValTester(string code, bool expectErrors, int expectedChildren)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.datetimeExpr();
            Assert.AreEqual(expectErrors, listener.errors > 0);
            Assert.AreEqual(expectedChildren, context.ChildCount);
        }

        private void StringValTester(string code, bool expectErrors, int expectedChildren)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.stringExpr();
            Assert.AreEqual(expectErrors, listener.errors > 0);
            Assert.AreEqual(expectedChildren, context.ChildCount);
        }

        private void BoolValTester(string code, bool expectErrors, int expectedChildren)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.boolExpr();
            Assert.AreEqual(expectErrors, listener.errors > 0);
            Assert.AreEqual(expectedChildren, context.ChildCount);
        }

        private void NumFuncTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.numFunc();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void StringFuncTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.stringFunc();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void BoolFuncTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.boolFunc();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void DatetimeFuncTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.datetimeFunc();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void ObjectTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.aclobject();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void CmdTester(string code, bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.command();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void DataTypeTester(string code,bool expectErrors)
        {
            AclErrorListener listener;
            CommonTokenStream tokens;
            var parser = PrepareParser(code, out listener, out tokens);
            var context = parser.datatype();
            Assert.AreEqual(expectErrors, listener.errors > 0);
        }

        private void TestAcceptCmd()
        {
            CmdTester("ACCEPT 'Select the table to open:' FIELDS 'xf' TO v_table_name", false);
            CmdTester("ACCEPT 'Select the table to open:' TO v_table_name", false);
        }

        private void TestActivateCmd()
        {
            CmdTester("ACTIVATE WORKSPACE myspace OK", false);
            CmdTester("ACTIVATE myspace OK", false);
            CmdTester("ACTIVATE myspace", false);
        }

        private void TestAgeCmd()
        {
            CmdTester("AGE ON datefield CUTOFF 20150101 INTERVAL 0,10, 30, 365 SUPPRESS SUBTOTAL numfield1 numfield 2 IF T WHILE T FIRST 100 TO SCREEN KEY textfield HEADER 'Aging' FOOTER 'Created by us' APPEND LOCAL STATISTICS", false);
            CmdTester("AGE ON datefield CUTOFF 20150101 INTERVAL 0,10, 30, 365 SUPPRESS SUBTOTAL numfield1 numfield 2 IF T WHILE T NEXT 100 TO SCREEN KEY textfield HEADER 'Aging' FOOTER 'Created by us' APPEND LOCAL STATISTICS", false);
            CmdTester("AGE ON datefield  INTERVAL 0,10, 30, 365 SUPPRESS SUBTOTAL numfield1 numfield 2 IF T WHILE T NEXT 100 TO SCREEN KEY textfield HEADER 'Aging' FOOTER 'Created by us' APPEND LOCAL STATISTICS", false);
            CmdTester("AGE ON datefield ", false);
            CmdTester("AGE ON datefield CUTOFF 20150101 INTERVAL 0,10, 30, 365 SUBTOTAL numfield1 numfield 2 TO SCREEN", false);
            CmdTester("AGE CUTOFF 20150101 datefield SUBTOTAL numField1 INTERVAL 0,10,20 IF RECNO() > 10 TO TestTable", false);
        }

        private void TestAssignCmd()
        {
            CmdTester("ASSIGN v_Var=TestVal IF T", false);
            CmdTester("v_Var=TestVal IF T", false);
            CmdTester("v_Var = TestVal", false);
            CmdTester("v_Var = %v_OtherVar%", false);
            CmdTester("v_Var = `20150101`", false);
            CmdTester("v_Var = CTOD(DateField 'YYYY-MM-DD')", false);
            CmdTester("v_Var = 2334.11", false);
            CmdTester("v_Var = T", false);
            CmdTester("v_Var = 'String'", false);
            CmdTester("    v_Var = 'String'", false);
            CmdTester("    ASSIGN v_Var = 'String'", false);
        }

        private void TestBenfordCmd()
        {
            CmdTester("BENFORD ON numfield LEADING 2 IF anotherField = 'Cat1' BOUNDS TO GRAPH HEADER 'Benford' FOOTER 'By ACL' WHILE RECNO() > 100 FIRST 10 APPEND OPEN LOCAL", false);
            CmdTester("BENFORD numfield BOUNDS TO PRINT NEXT 500 OPEN", false);
            CmdTester("BENFORD numfield BOUNDS TO BenfordTable", false);
        }

        private void TestCalculateCmd()
        {
            CmdTester("CALCULATE PI()", false);
            CmdTester("CALCULATE REGEXREPLACE('Tom Larsen    ' 'Tom|Thomas|Thom' 'Thomas') AS 'NicknameNormalize'", false);
        }

        private void TestClassifyCmd()
        {
            CmdTester("CLASSIFY ON category SUBTOTAL amount1 amount 2 INTERVALS 2 SUPPRESS TO temptable IF category < 10 WHILE RECNO() > 100 NEXT 100 HEADER 'header' FOOTER 'footer' KEY keyfield OPEN APPEND LOCAL STATISTICS", false);
            CmdTester("CLASSIFY ON category SUBTOTAL amount1 amount 2 TO screen OPEN STATISTICS", false);
            CmdTester("CLASSIFY category TO screen  ", false);
        }

        private void TestCloseCmd()
        {
            CmdTester("CLOSE tablename", false);
            CmdTester("CLOSE PRIMARY", false);
            CmdTester("CLOSE SECONDARY", false);
            CmdTester("CLOSE PRIMARY SECONDARY", false);
            CmdTester("CLOSE INDEX", false);
            CmdTester("CLOSE LOG", false);
            CmdTester("CLOSE LEARN", false);
        }

        private void TestCountCmd()
        {
            CmdTester("COUNT IF Cat='1' WHILE RECNO()>1 FIRST 100", false);
            CmdTester("COUNT IF Cat='1' WHILE RECNO()>1 NEXT 100", false);
            CmdTester("COUNT", false);
        }

        private void TestCrosstabCmd()
        {
            CmdTester("CROSSTAB ON Fld1 Fld2 COLUMNS catField SUBTOTAL Numfield1 Numfield2 TO TestTable IF Numfield1 > 100 WHILE RECNO() < 100 FIRST 100 APPEND COUNT OPEN LOCAL HEADER 'Header' FOOTER 'Footer'", false);
            CmdTester("CROSSTAB Fld1 Fld2 COLUMNS catField SUBTOTAL Numfield1 Numfield2 TO 'TestTable.txt' COUNT  ", false);
            CmdTester("CROSSTAB Fld1 COLUMNS catField TO SCREEN  ", false);
        }

        private void TestDefineColumnCmd()
        {
            CmdTester("DEFINE COLUMN myview fieldname AS 'Test' POSITION 2 WIDTH 50 PIC '9,999.00' SORT D KEY PAGE NODUPS NOZEROES LINE 2", false);
            CmdTester("DEFINE COLUMN myview fieldname ", false);
            CmdTester("DEFINE COLUMN myview relatedTable.fieldname ", false);
        }

        private void TestDefineFieldCmd()
        {
            CmdTester("DEFINE FIELD TestDate DATETIME 12 13 NDATETIME PIC 'MMDDYYYY' AS 'Col' WIDTH 50 ", false);
            CmdTester("DEFINE FIELD TestNum NUMERIC 12 13 2 PIC '9,999.99' AS 'Col' WIDTH 50 ", false);
            CmdTester("DEFINE FIELD TestStr UNICODE 12 13 ", false);
        }

        private void TestDefineFieldCCmd()
        {
            CmdTester("DEFINE FIELD newfld COMPUTED amount1 * amount2", false);
            CmdTester(string.Concat(new string[]
            {
                "DEFINE FIELD newFld COMPUTED ", Environment.NewLine,
                "AS 'newFld'", Environment.NewLine,
                "1 IF Cat = 'A01'",Environment.NewLine,
                "2"
            }
            ), false);
            CmdTester(string.Concat(new string[]
            {
                "DEFINE FIELD newFld COMPUTED ", Environment.NewLine,
                "IF T STATIC WIDTH 50 PIC '9999.00' AS newFld", Environment.NewLine,
                "1 IF Cat = 'A01'",Environment.NewLine,
                "2"
            }
            ), false);
            CmdTester(string.Concat(new string[]
            {
                "DEFINE FIELD newFld COMPUTED ", Environment.NewLine,
                "  STATIC  ", Environment.NewLine,
                "1 IF Cat = 'A01'",Environment.NewLine,
                "2"
            }
            ), false);
        }

        private void TestDefineRelationCmd()
        {
            CmdTester("DEFINE RELATION keyfield WITH sectable INDEX indexName AS 'MyNewRelation'", false);
            CmdTester("DEFINE RELATION keyfield WITH sectable INDEX indexName", false);
        }

        private void TestDefineTableDbCmd()
        {
            CmdTester("DEFINE TABLE DB SOURCE 'mysource' PASSWORD 1 PASSWORD 2 FORMAT mytable SCHEMA 'pub' TITLED 'name' PRIMARY DBTABLE 'Table1' FIELDS 'fld1 fld2' DBTABLE 'Table2' FIELDS ALL WHERE 'Table1.key=Table2.key' ORDER 'fld1' ", false);
            CmdTester("DEFINE TABLE DB SOURCE 'mysource' SCHEMA 'pub' DBTABLE 'Table1' FIELDS 'fld1 fld2'", false);
        }

        private void TestDefineViewCmd()
        {
            CmdTester("DEFINE VIEW myNewView RLINES 2 ALL SUPPRESS SUMMARIZED IF category > 100 WHILE RECNO() < 50 HEADER 'header' FOOTER 'footer' TO 'TestFile' HTML OK ", false);
            CmdTester("DEFINE VIEW myNewView RLINES 2 ALL SUPPRESS SUMMARIZED IF category > 100 WHILE RECNO() < 50 HEADER 'header' FOOTER 'footer' TO 'TestFile'  OK ", false);
            CmdTester("DEFINE VIEW myNewView", false);
        }

        private void TestDeleteCmd()
        {
            CmdTester("DELETE FOLDER myFolder OK ", false);
            CmdTester("DELETE FORMAT myTable OK ", false);
            CmdTester("DELETE REPORT myView OK ", false);
            CmdTester("DELETE SCRIPT myScript OK ", false);
            CmdTester("DELETE BATCH myScript", false);
            CmdTester("DELETE WORKSPACE myWorkspace OK ", false);
            CmdTester("DELETE INDEX myIndex", false);
            CmdTester("DELETE NOTES OK ", false);
            CmdTester("DELETE someVal OK ", false);
            CmdTester("DELETE COLUMN myView myCol ALL OK ", false);
            CmdTester("DELETE COLUMN myView myCol", false);
            CmdTester("DELETE ALL", false);
            CmdTester("DELETE HISTORY 1 OK", false);
            CmdTester("DELETE RELATION myrelation OK", false);
            CmdTester("DELETE 'SomeFile'", false);
        }

        private void TestDialogCmd()
        {
            CmdTester("DIALOG (DIALOG TITLE \"User Dialog\" WIDTH 438 HEIGHT 174 ) (BUTTONSET TITLE \"&OK;&Cancel\" AT 324 12 WIDTH 80 HEIGHT 50 DEFAULT 1 HORZ ) (TEXT TITLE \"Some Text\" AT 12 16 WIDTH 71 HEIGHT 20 CENTER ) (EDIT TO \"v_EDIT1\" AT 12 36 WIDTH 120 HEIGHT 24 DEFAULT \"default text\" ) (CHECKBOX TITLE \"My checkbox\" TO \"v_CHECKBOX1\" AT 12 72 WIDTH 109 HEIGHT 24 CHECKED ) (RADIOBUTTON TITLE \"Option 1;Option 2\" TO \"v_RADIO1\" AT 12 108 WIDTH 158 HEIGHT 24 DEFAULT 1 HORZ ) (DROPDOWN TITLE \"Option 1;Option 2\" TO \"v_DROPDOWN1\" AT 156 12 WIDTH 120 HEIGHT 100 DEFAULT 2 ) (ITEM TITLE \"CN\" TO \"v_ITEM1\" AT 156 48 WIDTH 120 HEIGHT 100 DEFAULT \"something\" ) ", false);
            CmdTester("DIALOG (DIALOG TITLE \"User Dialog\" WIDTH 438 HEIGHT 174 ) (BUTTONSET TITLE \"&OK;&Cancel\" AT 324 12 DEFAULT 1 ) (TEXT TITLE \"Some Text\" AT 12 16 ) (EDIT TO \"v_EDIT1\" AT 12 36 ) (CHECKBOX TITLE \"My checkbox\" TO \"v_CHECKBOX1\" AT 12 72 ) (RADIOBUTTON TITLE \"Option 1;Option 2\" TO \"v_RADIO1\" AT 12 108 ) (DROPDOWN TITLE \"Option 1;Option 2\" TO \"v_DROPDOWN1\" AT 156 12 ) (ITEM TITLE \"CN\" TO \"v_ITEM1\" AT 156 48 ) ", false);
        }

        private void TestDirectoryCmd()
        {
            CmdTester("DIRECTORY 'Subfolder\\*.txt' SUPPRESS SUBDIRECTORY APPEND TO 'Test.FIL' ", false);
            CmdTester("DIRECTORY ", false);
        }

        private void TestDisplayCmd()
        {
            CmdTester("DISPLAY OPEN", false);
            CmdTester("DISPLAY PRIMARY", false);
            CmdTester("DISPLAY SECONDARY", false);
            CmdTester("DISPLAY HISTORY ", false);
            CmdTester("DISPLAY RELATION", false);
            CmdTester("DISPLAY v_Var", false);
            CmdTester("DISPLAY VARIABLES", false);
            CmdTester("DISPLAY VERSION", false);
            CmdTester("DISPLAY DATE", false);
            CmdTester("DISPLAY TIME", false);
            CmdTester("DISPLAY FREE", false);
            CmdTester("DISPLAY SPACE", false);
            CmdTester("  DISPLAY ", false);
        }

        private void TestDoScriptCmd()
        {
            CmdTester("DO SCRIPT MyScript IF v_Bool = T", false);
            CmdTester("DO SCRIPT '\\\\Server\\Library\\MySharedScript.aclscript' WHILE v_Counter < 10", false);
            CmdTester("DO something", false);
        }

        private void TestDuplicatesCmd()
        {
            CmdTester("DUPLICATES ON Fld1 Fld2 D OTHER Fld3 FLd4 UNFORMATTED TO SCREEN APPEND IF v_Test = T WHILE RECNO() > 5 FIRST 100 HEADER 'header' FOOTER 'footer' PRESORT OPEN LOCAL ISOLOCALE en_us ", false);
            CmdTester("DUPLICATES Fld1", false);
        }

        private void TestEscapeCmd()
        {
            CmdTester("ESCAPE ALL IF T", false);
            CmdTester("ESCAPE", false);
        }

        private void TestEvaluateCmd()
        {
            CmdTester("EVALUATE MONETARY ERRORLIMIT 1,1 2,2 3,3 INTERVAL 5 CONFIDENCE 95 TO SCREEN", false);
            CmdTester("EVALUATE MONETARY ERRORLIMIT 1 1 2 2 3 3 INTERVAL 5 CONFIDENCE 95 TO SCREEN", false);
            CmdTester("EVALUATE MONETARY ERRORLIMIT 1,1,2,2,3,3 INTERVAL 5 CONFIDENCE 95 TO SCREEN", false);
            CmdTester("EVALUATE MONETARY ERRORLIMIT 1,1,2,2,3,3 INTERVAL 5 CONFIDENCE 95 ", false);
            CmdTester("EVALUATE RECORD SIZE 20 ERROR 5 CONFIDENCE 95 TO SCREEN", false);
            CmdTester("EVALUATE RECORD SIZE 20 ERROR 5 CONFIDENCE 95", false);
        }

        private void TestExecuteCmd()
        {
            CmdTester("EXECUTE 'TIMEOUT /t 30 ASYNC' ", false);
            CmdTester("EXECUTE 'TIMEOUT /t 30'", false);
        }

        private void TestExportCmd()
        {
            CmdTester("EXPORT FIELDS ALL ACCESS TO 'Test.mdb' IF Category='A1' WHILE BoolField=T FIRST 1000 UNICODE ", false);
            CmdTester("EXPORT Fld1 Fld2 ACLGRC TO '1@eu' PASSWORD 1 OVERWRITE IF Category='A1' WHILE BoolField=T FIRST 1000 UNICODE ", false);
            CmdTester("EXPORT FIELDS ALL ASCII TO 'Test.txt' IF Category='A1' WHILE BoolField=T FIRST 1000 UNICODE APPEND KEEPTITLE", false);
            CmdTester("EXPORT FIELDS ALL CLIPBOARD IF Category='A1' WHILE BoolField=T FIRST 1000 UNICODE ", false);
            CmdTester("EXPORT FIELDS ALL DBASE TO 'Test.dbf' IF Category='A1' WHILE BoolField=T FIRST 1000 ", false);
            CmdTester("EXPORT FIELDS ALL DELIMITED TO 'Test.del' UNICODE APPEND KEEPTITLE SEPARATOR '|' QUALIFIER '\"' ", false);
            CmdTester("EXPORT FIELDS ALL EXCEL TO 'Test.xls' ", false);
            CmdTester("EXPORT FIELDS ALL JSON TO 'Test.Txt' ", false);
            CmdTester("EXPORT FIELDS ALL LOTUS TO 'WhoActuallyUsesLotus.file' ", false);
            CmdTester("EXPORT FIELDS ALL WDPF6 TO 'NoOneUsesThisEither.file' ", false);
            CmdTester("EXPORT FIELDS ALL WORD TO 'Seriously_WhyAreWeExportingDataToWord.doc' ", false);
            CmdTester("EXPORT FIELDS ALL WP TO 'AnotherFileTypeForHopelessPeople.file' ", false);
            CmdTester("EXPORT FIELDS ALL XLS21 TO 'The1980sCalledAndTheyWantTheirFileBack.file' ", false);
            CmdTester("EXPORT FIELDS ALL XLSX TO 'ExcelSucks.xlsx' WORKSHEET 'MyWorksheet'", false);
            CmdTester("EXPORT ALL XML SCHEMA TO 'Test.xml' ", false);
        }

        private void TestExtractCmd()
        {
            CmdTester("EXTRACT RECORD TO NewTable IF Fld > 10 WHILE RunTotal < 500 FIRST 1000 EOF APPEND OPEN LOCAL ", false);
            CmdTester("EXTRACT FIELDS ALL TO NewTable", false);
            CmdTester("EXTRACT ALL TO NewTable", false);
            CmdTester("EXTRACT FIELDS Fld1 Fld2 AS 'Field2' TO newtable", false);
        }

        private void TestFieldshiftCmd()
        {
            CmdTester("FIELDSHIFT START 1 COLUMNS 2 FILTER filtername OK", false);
            CmdTester("FIELDSHIFT START 10 COLUMNS 5", false);
        }

        private void TestFindCmd()
        {
            CmdTester("FIND   df% dergf9 (", false);
            CmdTester("FIND", false);
            CmdTester("FIND RECNO()", false);
        }

        private void TestFuzzyDupCmd()
        {
            CmdTester("FUZZYDUP ON field1 OTHER field2 field3 LEVDISTANCE 1 DIFFPCT 50 RESULTSIZE 500 EXACT IF v_Cat = 4 TO 'myNewTable.fil' LOCAL OPEN", false);
            CmdTester("FUZZYDUP ON field1 LEVDISTANCE 1 TO 'myNewTable.fil'", false);
        }

        private void TestGapsCmd()
        {
            CmdTester("GAPS ON field1 field2 D UNFORMATTED PRESORT MISSING 10 HEADER 'Header' FOOTER 'footer' IF RECNO() > 1 WHILE DoExtract=T FIRST 100 TO SCREEN APPEND LOCAL OPEN", false);
            CmdTester("GAPS field1 ", false);
        }

        private void TestHistogramCmd()
        {
            CmdTester("HISTOGRAM ON charField TO SCREEN IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' KEY keyfield SUPPRESS COLUMNS 100 APPEND LOCAL OPEN", false);
            CmdTester("HISTOGRAM ON numField MINIMUM 1 MAXIMUM 1000 FREE 0,10,20,50,100,200,1000 TO SCREEN IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' KEY keyfield SUPPRESS COLUMNS 100 APPEND LOCAL OPEN", false);
            CmdTester("HISTOGRAM charField", false);
            CmdTester("HISTOGRAM ON numField MINIMUM 1 MAXIMUM 1000 ", false);
        }

        private void TestIfCmd()
        {
            CmdTester("IF T DO 'Test1.aclscript'", false);
            CmdTester("IF v_Amnt > 10 IF Cat='123' v_DoSomething = T ", false);
        }

        private void TestImportAccessCmd()
        {
            CmdTester("IMPORT ACCESS TO tablename PASSWORD 1 'tablename.FIL' FROM 'c:\\StupidAccessDbs\\SeriouslyWhoUsesThemInProduction.accdb' TABLE '[UndoubtedlyABadlyDesignedTable]' CHARMAX 50 MEMOMAX 100 ", false);
            CmdTester("IMPORT ACCESS TO tablename 'tablename.FIL' FROM 'c:\\StupidAccessDbs\\SeriouslyWhoUsesThemInProduction.accdb' TABLE '[UndoubtedlyABadlyDesignedTable]' CHARMAX 50 MEMOMAX 100 ", false);
        }

        private void TestImportDelimitedCmd()
        {
            CmdTester("IMPORT DELIMITED TO tableName 'tableName.FIL' FROM 'c:\\MyDelFile.del' SERVER myprofile 0 SEPARATOR '|' QUALIFIER '\"' CONSECUTIVE STARTLINE 2 KEEPTITLE CRCLEAR LFCLEAR FIELD myfield N AT 10 DEC 0 WID 50 PIC '' AS 'myfield' FIELD myfield2 N AT 60 DEC 0 WID 50 PIC '' AS 'myfield2' IGNORE 2 IGNORE 3 ", false);
            CmdTester("IMPORT DELIMITED TO tableName 'tableName.FIL' FROM 'c:\\MyDelFile.del' 0 SEPARATOR '|' QUALIFIER '\"' CONSECUTIVE STARTLINE 2 KEEPTITLE FIELD myfield N AT 10 DEC 0 WID 50 PIC '' AS 'myfield' FIELD myfield2 N AT 60 DEC 0 WID 50 PIC '' AS 'myfield2' ", false);
        }

        private void TestImportExcelCmd()
        {
            CmdTester("IMPORT EXCEL TO excelFile \"ExcelFile.FIL\" FROM \"MyExcelFile.xlsx\" TABLE \"SomeWorksheet\" CHARMAX 50", false);
            CmdTester("IMPORT EXCEL TO excelFile \"ExcelFile.FIL\" FROM \"MyExcelFile.xlsx\" TABLE \"SomeWorksheet\" CHARMAX 50 IGNORE 2 KEEPTITLE OPEN", false);
            CmdTester("IMPORT EXCEL TO excelFile \"ExcelFile.FIL\" FROM \"MyExcelFile.xlsx\" TABLE \"SomeWorksheet\" FIELD 'Fld1' D PIC '' AS 'Fld1' FIELD 'Fld2' N WID 10 DEC 2 AS 'Fld2' IGNORE 1 IGNORE 2 KEEPTITLE OPEN", false);
            CmdTester("IMPORT EXCEL TO excelFile \"ExcelFile.FIL\" FROM \"MyExcelFile.xlsx\" TABLE \"SomeWorksheet\" FIELD 'Fld1' D PIC '' AS 'Fld1' FIELD 'Fld2' N WID 10 DEC 2 AS 'Fld2'", false);
        }

        private void TestImportGrcProjectCmd()
        {
            CmdTester("IMPORT GRCPROJECT TO tablename 'tablename.FIL' PASSWORD 1 FROM '123/audits' ", false);
            CmdTester("IMPORT GRCPROJECT TO tablename 'tablename.FIL' FROM '123/audits' ", false);
        }

        private void TestImportGrcResultsCmd()
        {
            CmdTester("IMPORT GRCRESULTS TO mynewtable 'mynewtable.fil' PASSWORD 1 FROM '123' WITHCOMMENTS FIELD 'fld1' AS 'fld1' FIELD 'fld2' AS 'fld2'", false);
            CmdTester("IMPORT GRCRESULTS TO mynewtable 'mynewtable.fil'   FROM '123'   FIELD 'fld1' AS 'fld1' FIELD 'fld2' AS 'fld2'", false);
            CmdTester("IMPORT GRCRESULTS TO mynewtable 'mynewtable.fil' PASSWORD 1 FROM '123' INTERPRETATION '12345' WITHCOMMENTS ", false);
            CmdTester("IMPORT GRCRESULTS TO mynewtable 'mynewtable.fil' FROM '123' INTERPRETATION '12345' ", false);
        }

        private void TestImportOdbcCmd()
        {
            CmdTester("IMPORT ODBC SOURCE 'MyDatabase' TABLE 'someTable' QUALIFIER \"'\" OWNER 'dbSuperusers' USERID 'auditUser' PASSWORD 1 WHERE '1<>1' TO 'MyTable.FIL' WIDTH 100 MAXIMUM 200 FIELDS 'Fld1',fld2,'fld3'", false);
            CmdTester("IMPORT ODBC SOURCE 'MyDatabase' TABLE 'someTable'", false);
        }

        private void TestImportPdfCmd()
        {
            CmdTester("IMPORT PDF TO mytable PASSWORD 1 'mytable.fil' FROM 'PdfFilesAreAwful.pdf' SERVER myserver 0 PARSER 'VPDF' PAGES '1-3' RECORD 'Detail' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS '' FIELD 'Fld2' X AT 1,71 SIZE 2,1 DEC 0 WID 10 PIC '' AS '' RECORD 'Header1' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS ''", false);
            CmdTester("IMPORT PDF TO mytable 'mytable.fil' FROM 'PdfFilesAreAwful.pdf' RECORD 'Detail' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS '' FIELD 'Fld2' X AT 1,71 SIZE 2,1 DEC 0 WID 10 PIC '' AS '' RECORD 'Header1' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS ''", false);
            CmdTester("IMPORT PDF TO VendorList  PASSWORD 1 \"Vendors.pdf\" 0 PAGES \"3-4\" RECORD \"Detail\" 0 1 0 TEST 0 0 AT 1,66,0 7 \".\" FIELD \"Vendor_Name\" X AT 1,63 SIZE 7,1 DEC 2 WID 7 PIC \"\" AS \"Vendor Name\"", false);
        }

        private void TestImportPrintCmd()
        {
            CmdTester("IMPORT PRINT TO mytable 'mytable.fil' FROM 'someFile.txt' SERVER myserver 3 65001 RECORD 'Detail' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS '' FIELD 'Fld2' X AT 1,71 SIZE 2,1 DEC 0 WID 10 PIC '' AS '' RECORD 'Header1' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS ''", false);
            CmdTester("IMPORT PRINT TO mytable 'mytable.fil' FROM 'someFile.txt' 0 RECORD 'Detail' 0 1 0 TEST 0 0 AT 1,66,0 7 '.' FIELD 'Fld1' X AT 1,63 SIZE 7,1 DEC 0 WID 10 PIC '' AS '' FIELD 'Fld2' X AT 1,71 SIZE 2,1 DEC 0 WID 10 PIC '' AS ''", false);
            CmdTester("IMPORT PRINT TO ReportTable \"ReportTable.FIL\" FROM \"Report.txt\" 0  RECORD \"Detail\" 0 1 0 TEST 0 0 AT 1,59,59 7 \".\"  FIELD \"Field_1\" X AT 1,6 SIZE 9,1 DEC 0 WID 9 PIC \"\" AS \"Item ID\"  FIELD \"Field_2\" C AT 1,16 SIZE 24,1 DEC 0 WID 24 PIC \"\" AS \"Item Desc.\" FIELD \"Field_3\" N AT 1,40 SIZE 10,1 DEC 0 WID 10 PIC \"\" AS \"On Hand\" FIELD \"Field_4\" N AT 1,50 SIZE 12,1 DEC 2 WID 12 PIC \"\" AS \"Cost\" FIELD \"Field_5\" N AT 1,62 SIZE 12,1 DEC 2 WID 12 PIC \"\" AS \"Total\" RECORD \"Header1\" 1 1 0 TEST 0 0 AT 1,17,0 7 \":\" FIELD \"Field_6\" C AT 1,19 SIZE 2,1 DEC 0 WID 2 PIC \"\" AS \"Prod Class\" FIELD \"Field_7\" C AT 1,24 SIZE 31,1 DEC 0 WID 31 PIC \"\" AS \"Prod Description\"", false);
        }

        private void TestImportSapCmd()
        {
            CmdTester("IMPORT SAP PASSWORD 1 TO Purchasing_doc SOURCE \"SAP AGENT\" <q version=\"6.0\"><s>0</s><d>IDES</d><u>mzunini</u><c>800</c><lg>en</lg><cf>C:\\ACL Data\\Purchasing_doc.fil</cf><sf>E:\\Data\\DL_JSMITH111107.DAT</sf><jcount>11110701</jcount><jname>DL_JSMITH111107.DAT</jname><dl>75</dl><m>1</m><r>500</r><ar>0</ar><e>500</e><ts><t><n>EKKO</n><a>T00001</a><td>Purchasing Document Header</td><fs><f>EBELN</f><f>BUKRS</f><f>BSTYP</f><f>BSART</f><f>STATU</f><f>WKURS</f></fs><wc><w><f>BUKRS</f><o>0</o><l>1000</l><h></h></w></wc></t><t><n>EKPO</n><a>T00002</a><td>Purchasing Document Item</td><fs><f>EBELP</f><f>WERKS</f><f>MENGE</f><f>BRTWR</f></fs><wc></wc></t></ts><js><jc><pt><pa>T00001</pa><pf>EBELN</pf></pt><ct><ca>T00002</ca><cf>EBELN</cf></ct></jc></js></q>", false);
            CmdTester("IMPORT SAP PASSWORD 1 TO Purchasing_doc SOURCE \"SAP AGENT\" <q version=\"6.0\"><s>0</s><d>IDES</d><u>mzunini</u><c>800</c><lg>en</lg><cf>C:\\ACL Data\\Purchasing_doc.fil</cf><sf>E:\\Data\\DL_JSMITH111107.DAT</sf><jcount>11110701</jcount><jname>DL_JSMITH111107.DAT</jname><dl>75</dl><m>1</m><r>500</r><ar>0</ar><e>500</e><ts><t><n>EKKO</n><a>T00001</a><td>Purchasing Document Header</td><fs><f>EBELN</f><f>BUKRS</f><f>BSTYP</f><f>BSART</f><f>STATU</f><f>WKURS</f></fs><wc></wc></t></ts><js></js></q>", false);
        }

        private void TestImportXbrlCmd()
        {
            CmdTester("IMPORT XBRL TO testTable 'testTable.FIL' FROM 'MyXbrlData.xml' CONTEXT 'Context1' 'Context2' FIELD 'Fld1' N AT 10 DEC 0 WID 10 PIC '' AS ''  FIELD 'Fld2' Q AT 18 DEC 0 WID 10 PIC '' AS '' IGNORE 2 IGNORE 5 ", false);
            CmdTester("IMPORT XBRL TO testTable 'testTable.FIL' FROM 'MyXbrlData.xml' CONTEXT 'Context1' FIELD 'Fld1' N AT 10 DEC 0 WID 10 PIC '' AS '' ", false);
            CmdTester("IMPORT XBRL TO Financials \"Financials.fil\" FROM \"FinancialStatemenXBRL.xml\" CONTEXT \"Current_AsOf\" FIELD \"Item\" C AT 1 DEC 0 WID 57 PIC \"\" AS \"\" FIELD \"Value\" X AT 58 DEC 0 WID 7 PIC \"\" AS \"\" IGNORE 1 IGNORE 3 ", false);
        }

        private void TestImportXmlCmd()
        {
            CmdTester("IMPORT XML TO Employees \"Employees.fil\" FROM \"emp.XML\" FIELD \"Empno\" C AT 1 DEC 0 WID 6 PIC \"\" AS \"\" RULE \"/RECORDS/RECORD/Empno/text()\" FIELD \"First\" C AT 7 DEC 0 WID 13 PIC \"\" AS \"\" RULE \"/RECORDS/RECORD/First/text()\" FIELD \"Last\" C AT 20 DEC 0 WID 20 PIC \"\" AS \"\" RULE \"/RECORDS/RECORD/Last/text()\" FIELD \"HireDate\" D AT 40 DEC 0 WID 10 PIC \"YYYY-MM-DD\" AS \"\"   RULE \"/RECORDS/RECORD/HireDate/text()\" FIELD \"Salary\" N AT 50 DEC 2 WID 8 PIC \"\" AS \"\"   RULE \"/RECORDS/RECORD/Salary/text()\"", false);
            CmdTester("IMPORT XML TO Employees \"Employees.fil\" FROM \"emp.XML\" FIELD \"Empno\" C AT 1 DEC 0 WID 6 PIC \"\" AS \"\" RULE \"/RECORDS/RECORD/Empno/text()\" ", false);
        }

        private void TestIndexCmd()
        {
            CmdTester("INDEX ON Fld1 Fld2 D TO 'MyIndex' IF T WHILE T FIRST 100 OPEN ISOLOCALE en_us ", false);
            CmdTester("INDEX Fld1 TO 'MyIndex' ", false);
        }

        private void TestJoinCmd()
        {
            CmdTester("JOIN PRIMARY PKEY field1 field2 FIELDS ALL SKEY field1 field2 WITH fld4 fld5 IF field1 = '123' WHILE RECNO()<1000 FIRST 200 TO 'TableName' LOCAL OPEN APPEND PRESORT SECSORT ISOLOCALE en_us ", false);
            CmdTester("JOIN UNMATCHED PKEY field1 FIELDS ALL SKEY field1 TO TableName  ", false);
            CmdTester("JOIN PKEY field1 FIELDS ALL SKEY field1 TO TableName  ", false);
        }

        private void TestLocateCmd()
        {
            CmdTester("LOCATE IF field1 = 20 WHILE Something = T FIRST 1000", false);
            CmdTester("LOCATE RECORD 2 ", false);
        }

        private void TestMergeCmd()
        {
            CmdTester("MERGE ON fld1 fld2 TO 'mergedTable' PRESORT IF T WHILE T FIRST 1000 APPEND ISOLOCALE en_us OPEN", false);
            CmdTester("MERGE PKEY fld1 fld2 SKEY field1 field2 TO 'mergedTable' PRESORT IF T WHILE T FIRST 1000 APPEND ISOLOCALE en_us OPEN", false);
            CmdTester("MERGE ON fld1 TO 'mergedTable'  ", false);
            CmdTester("MERGE PKEY fld1 SKEY field1 TO 'mergedTable' ", false);
        }

        private void TestNotesCmd()
        {
            CmdTester("NOTES IF CatField = '10' TEXT 'category 10 is for losers' APPEND ", false);
            CmdTester("NOTES IF CatField = '10' CLEAR ", false);
            CmdTester("NOTES CLEAR ", false);
        }

        private void TestNotifyCmd()
        {
            CmdTester("NOTIFY USER 'me@myCompany.com' PASSWORD 'someencodedpassword' MAILBOX 'mail@mail.com' ADDRESS 'someone@myCompany.com' CC 'someoneElse@myCompany.com' BCC 'doNotBccPeople@myCompany.com' SUBJECT 'w00t' MESSAGE 'I quit.  Later.' ATTACHMENT 'somePhoto.png' ", false);
            CmdTester("NOTIFY USER 'me@myCompany.com' MAILBOX 'mail@mail.com' ADDRESS 'someone@myCompany.com' MESSAGE 'I quit.  Later.' ", false);
        }

        private void TestOpenCmd()
        {
            CmdTester("OPEN myTable FORMAT myLayout BUFFERLENGTH 10 CRLF DBASE INDEX myIndex PRIMARY SKIP 10 RELATION fld1", false);
            CmdTester("OPEN myTable", false);
            CmdTester("OPEN myTable SECONDARY", false);
        }

        private void TestPasswordCmd()
        {
            CmdTester("PASSWORD 1 'Enter your password'", false);
            CmdTester("PASSWORD 2", false);
        }

        private void TestPauseCmd()
        {
            CmdTester("PAUSE 'The rain in Spain stays mainly on the plain.' IF Country = 'Spain'", false);
            CmdTester("PAUSE 'AEIOUY?'", false);
        }

        private void TestPrintCmd()
        {
            CmdTester("PRINT 'File.txt'", false);
            CmdTester("PRINT GRAPH ", false);
        }

        private void TestProfileCmd()
        {
            CmdTester("PROFILE FIELDS fld1 fld2 IF T WHILE T FIRST 100", false);
            CmdTester("PROFILE fld1 fld2 IF T WHILE T FIRST 100", false);
            CmdTester("PROFILE FIELDS ALL IF T WHILE T FIRST 100", false);
            CmdTester("PROFILE ALL IF T WHILE T FIRST 100", false);
            CmdTester("PROFILE fld1 fld2 ", false);
            CmdTester("PROFILE ALL ", false);
        }

        private void TestRandomCmd()
        {
            CmdTester("RANDOM NUMBER 5 SEED 23498 MINIMUM 0 MAXIMUM 10000 UNIQUE COLUMNS 2 SORTED TO SCREEN APPEND", false);
            CmdTester("RANDOM NUMBER 5 MINIMUM 0 MAXIMUM 10000  ", false);
        }

        private void TestRefreshCmd()
        {
            CmdTester("REFRESH myTable PASSWORD 1 ", false);
            CmdTester("REFRESH myTable   ", false);
        }

        private void TestRenameCmd()
        {
            CmdTester("RENAME FIELD myfield TO MyAwesomeField OK ", false);
            CmdTester("RENAME FORMAT myTable MyAwesomeTable ", false);
            CmdTester("RENAME INDEX OldName NewName ", false);
            CmdTester("RENAME REPORT OldName NewName ", false);
            CmdTester("RENAME WORKSPACE OldName NewName ", false);
            CmdTester("RENAME SCRIPT OldName NewName ", false);
            CmdTester("RENAME BATCH OldName NewName ", false);
            CmdTester("RENAME DATA OldName NewName ", false);
            CmdTester("RENAME FILE OldName NewName ", false);
            CmdTester("RENAME LOG OldName NewName ", false);
            CmdTester("RENAME TEXT OldName NewName ", false);
        }

        private void TestReportCmd()
        {
            CmdTester("REPORT ON fieldName1 NODUPS PAGE fieldName2 FIELDS fieldName3 SUPPRESS NOZEROES LINE 2 fieldName4 LINE 3 fieldName5 SUMMARIZE SKIP 1 EOF TO SCREEN IF T WHILE T FIRST 100 HEADER 'Header' FOOTER 'footer' APPEND", false);
            CmdTester("REPORT ON fieldName1 FIELDS fieldName3  ", false);
        }

        private void TestSampleCmd()
        {
            CmdTester("SAMPLE ON RECORD INTERVAL 1 FIXED 1 IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' TO tableName ORDER FIELDS fld1 fld2 APPEND OPEN LOCAL ", false);
            CmdTester("SAMPLE ON RECORD CELL INTERVAL 1 RANDOM 1 IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' TO tableName RECORD APPEND OPEN LOCAL ", false);
            CmdTester("SAMPLE RECORD RANDOM 1 NUMBER 1 IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' TO tableName ORDER FIELDS fld1 fld2 APPEND OPEN LOCAL ", false);
            CmdTester("SAMPLE ON musFieldName INTERVAL 1 FIXED 1 CUTOFF 1 SUBSAMPLE REPLACEMENT IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' TO tableName ORDER FIELDS fld1 fld2 APPEND OPEN LOCAL ", false);
            CmdTester("SAMPLE ON musFieldName CELL INTERVAL 1 CUTOFF 1 RANDOM 1 NOREPLACEMENT IF T WHILE T FIRST 100 HEADER 'header' FOOTER 'footer' TO tableName ORDER FIELDS fld1 fld2 APPEND OPEN LOCAL ", false);
            CmdTester("SAMPLE musFieldName RANDOM 1 NUMBER 1 POPULATION 1 TO tableName FIELDS fld1 ", false);
        }

        private void TestSaveCmd()
        {
            CmdTester("SAVE", false);
            CmdTester("SAVE newTableName FORMAT existingTableName", false);
        }

        private void TestSaveLogCmd()
        {
            CmdTester("SAVE LOG SESSION AS 'Test.html' HTML OK", false);
            CmdTester("SAVE LOG AS 'Test.txt' ASCII",false);
        }

        private void TestSaveWorkspaceCmd()
        {
            CmdTester("SAVE WORKSPACE newWorkspace Fld1 Fld2 Fld3 ", false);
            CmdTester("SAVE WORKSPACE newWorkspace Fld1 ", false);
        }

        private void TestSequenceCmd()
        {
            CmdTester("SEQUENCE ON FIELDS Field1 D Field2 UNFORMATTED ERRORLIMIT 2 IF T WHILE T NEXT 100 TO SCREEN APPEND HEADER 'Header' FOOTER 'Footer' PRESORT LOCAL ISOLOCALE en_us ", false);
            CmdTester("SEQUENCE FIELDS Field1 TO 'MyNewTable.txt' ", false);
            CmdTester("SEQUENCE Field1 ", false);
        }
    }
}
