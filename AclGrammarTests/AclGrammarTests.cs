using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using AclGrammar;

namespace AclGrammarTests
{
    [TestClass]
    public partial class AclGrammarTests
    {
        [TestMethod]
        public void VarMultiCharTest()
        {
            VarTester("_dsfG3SDgklj5", false);
            VarTester("_sakfg!lkdfa", true);
            VarTester("4lkdfa", true);
            VarTester("4lk$dfa", true);
        }

        [TestMethod]
        public void VarSingleCharTest()
        {
            VarTester("x",false);
            VarTester("X",false);
            VarTester("_",false);
            VarTester("9", true);
            VarTester("$", true);
            VarTester("/", true);
        }

        [TestMethod]
        public void VarSubTest()
        {
            VarSubTester("%v_TestVar%", false, 2);
            VarSubTester("%v_TestVar", true, 1);
        }

        [TestMethod]
        public void NumValTest()
        {
            NumValTester("10.", false,1);
            NumValTester("10.0", false,1);
            NumValTester(".1", false, 1);
            NumValTester("-1", false, 2);
            NumValTester("-0.1", false, 2);
            NumValTester("-.1", false, 2);
            NumValTester("1", false,1);
            NumValTester("(12)", false,3);
            NumValTester("12*1", false, 3);
            NumValTester("(12*1)*1",false,3);
            NumValTester("12/1", false, 3);
            NumValTester("1*12/1", false, 3);
            NumValTester("1-1", false, 3);
            NumValTester("1-(-1)", false, 3);
            NumValTester("1+1", false, 3);
            NumValTester("-1*1", false, 2);
            NumValTester("-1*(-1)", false, 2);
            NumValTester("1+3-4*5/3^2", false, 3);
            NumValTester("(1+1)-1", false, 3);
            NumValTester("-1+1", false, 2);
            NumValTester("-5+2--1+5", false, 2);
            NumValTester("(-5+2)+(4*5)/(1+1)", false, 3);
            NumValTester("-(((5^4)-2)*5.43)/(1+1)", false, 2);
            NumValTester("VariableName * 2", false, 5);
            NumValTester("`20150102` - `20150101`", false, 5);
            NumValTester("`t0101` - `20150101`", false, 5);
            NumValTester("`t010105` - `T010101`", false, 5);
        }

        [TestMethod]
        public void DateValTest()
        {
            DatetimeValTester("`19000101`", false, 1);
            DatetimeValTester("`000101`", false, 1);
            DatetimeValTester("`20150101t0101`", false,1);
            DatetimeValTester("`20150101T0101`", false, 1);
            DatetimeValTester("`20150101 0101`", false, 1);
            DatetimeValTester("`20150101t010101`", false, 1);
            DatetimeValTester("`20150101T010101`", false, 1);
            DatetimeValTester("`20150101 010101`", false, 1);
            DatetimeValTester("`201501t010101`", false, 1);
            DatetimeValTester("`201501T010101`", false, 1);
            DatetimeValTester("`201501 010101`", false, 1);
            DatetimeValTester("`201501t0101`", false, 1);
            DatetimeValTester("`201501T0101`", false, 1);
            DatetimeValTester("`151220 0101`", false, 1);
            DatetimeValTester("(`20150101`)", false, 3);
            DatetimeValTester("`20150101`+1", false, 3);
            DatetimeValTester("1+`20150101`", false, 3);
            DatetimeValTester("1+`20150101`+1", false, 3);
            DatetimeValTester("`t0101`", false, 1);
            DatetimeValTester("`T0101`", false, 1);
            DatetimeValTester("`t010101`", false, 1);
            DatetimeValTester("`T010101`", false, 1);
            DatetimeValTester("(`T150101`)", false, 3);
            DatetimeValTester("`T010101`+1", false, 3);
            DatetimeValTester("1+`t150101`", false, 3);
            DatetimeValTester("1+`t010101`+1", false, 3);
        }

        [TestMethod]
        public void StringValTest()
        {
            StringValTester("'Hello World'", false, 1);
            StringValTester("\"Hello World\"", false, 1);
            StringValTester("'Hello World'+\"Hello World\"",false,3);
            StringValTester("('Hello World'+\"Hello World\")+'Test'", false, 3);
        }

        [TestMethod]
        public void BoolValTest()
        {
            BoolValTester("T", false, 1);
            BoolValTester("F", false, 1);
            BoolValTester("1>2", false, 3);
            BoolValTester("1<2", false, 3);
            BoolValTester("1>=2", false, 3);
            BoolValTester("1<=2", false, 3);
            BoolValTester("1=2", false, 3);
            BoolValTester("1<>2", false, 3);
            BoolValTester("NOT T", false, 3);
            BoolValTester("T AND F", false, 5);
            BoolValTester("T OR F", false, 5);
            BoolValTester("('A'='B' AND (2-3>2)) OR F", false, 5);
        }

        [TestMethod]
        public void NumFuncTest()
        {
            NumFuncTester("ABS(1)", false);
            NumFuncTester("AGE(`20150101`)", false);
            NumFuncTester("AGE(`20150101`)", false);
            NumFuncTester("AGE(\"20150101\")", false);
            NumFuncTester("AGE(`20150101`   `20160101`)", false);
            NumFuncTester("AGE(\"20150101\" '20160101')", false);
            NumFuncTester("ASCII('5')", false);
            NumFuncTester("ASC('5')", false);
            NumFuncTester("AT(1,'the','My dog ate the cat')", false);
            NumFuncTester("AT(1'the''My dog ate the cat')", true);
            NumFuncTester("COS(34)", false);
            NumFuncTester("CUMPRINC(1,1,1,1,1,1)", false);
            NumFuncTester("CUMPRINC(1,1,1,1,1)", false);
            NumFuncTester("CUMIPMT(1,1,1,1,1,1)", false);
            NumFuncTester("CUMIPMT(1,1,1,1,1)", false);
            NumFuncTester("DAY(`20150101`)", false);
            NumFuncTester("DEC(23.33 0)", false);
            NumFuncTester("DEC(23 4)", false);
            NumFuncTester("DICECOEFFICIENT('Str1' 'Str2' 2)", false);
            NumFuncTester("DICECOEFFICIENT('Str1' 'Str2')", false);
            NumFuncTester("DIGIT(12 1)", false);
            NumFuncTester("DOW(`20150101`)", false);
            NumFuncTester("EFFECTIVE(12,2)", false);
            NumFuncTester("EXP(1,1)", false);
            NumFuncTester("FILESIZE('c:\\documents\\file.txt')", false);
            NumFuncTester("FREQUENCY('10')", false);
            NumFuncTester("FVANNUITY(10,10,10,0)", false);
            NumFuncTester("FVANNUITY(10,10,10)", false);
            NumFuncTester("FVLUMPSUM(10,10,10)", false);
            NumFuncTester("FVSCHEDULE(1000,0.1)", false);
            NumFuncTester("FVSCHEDULE(1000,0.1,0.2,0.3,0.4,0.5)", false);
            NumFuncTester("INT(12.22)", false);
            NumFuncTester("IPMT(0.085, 3, 3, 9600, 1)",false);
            NumFuncTester("IPMT(0.085, 3, 3, 9600)", false);
        }

        [TestMethod]
        public void StringFuncTest()
        {
            StringFuncTester("AllTrim('dfg ')", false);
            StringFuncTester("ALLT('dgfk ')", false);
            StringFuncTester("BINTOSTR('Value','A')", false);
            StringFuncTester("BINTOSTR('Value','E')", false);
            StringFuncTester("BIT(45)", false);
            StringFuncTester("BLANKS(50)", false);
            StringFuncTester("BYTE(50)",false);
            StringFuncTester("CDOW(`20150101`,5)",false);
            StringFuncTester("CHR(44)",false);
            StringFuncTester("CLEAN('dfgkj' 'sdfg')", false);
            StringFuncTester("CMOY(`20150101` 5)", false);
            StringFuncTester("DATE(`20150101` 'YYYY-MM-DD')",false);
            StringFuncTester("DATE(`20150101` )", false);
            StringFuncTester("DATETIME(`20150101` 'YYYY-MM-DD')", false);
            StringFuncTester("DATETIME( `20150101` )", false);
            StringFuncTester("DBYTE(20)", false);
            StringFuncTester("DHEX('Tesgdfg')", false);
            StringFuncTester("DTOU()", false);
            StringFuncTester("DTOU(`20150101`)", false);
            StringFuncTester("DTOU(`20150101`,'locale')", false);
            StringFuncTester("DTOU(`20150101`,'locale',1)", false);
            StringFuncTester("EBCDIC('Test')", false);
            StringFuncTester("EXCLUDE('SomeString';'qwerty')", false);
            StringFuncTester("FTYPE('SomeFieldName')", false);
            StringFuncTester("GETOPTIONS('separators')", false);
            StringFuncTester("HASH('Data')", false);
            StringFuncTester("HASH(123)", false);
            StringFuncTester("HASH(`20150101`)", false);
            StringFuncTester("HASH(F)", false);
            StringFuncTester("HASH('Data' 'hashvalue')", false);
            StringFuncTester("HASH(123) 1", false);
            StringFuncTester("HEX(123)", false);
            StringFuncTester("HEX('123')", false);
            StringFuncTester("HTOU('20AC')", false);
            StringFuncTester("INCLUDE('123445' '12')", false);
            StringFuncTester("INSERT('The ate the cat' ' dog' 4)", false);
            StringFuncTester("LAST('Hello World' 5)", false);
        }

        [TestMethod]
        public void BoolFuncTest()
        {
            BoolFuncTester("BETWEEN('B' 'A' 'C')", false);
            BoolFuncTester("BETWEEN(1;2;3)", false);
            BoolFuncTester("BETWEEN(`20150101` `20150101` `20150101`)", false);
            BoolFuncTester("BETWEEN(`t010101` `t010101` `t010101`)", false);
            BoolFuncTester("FIND('Test' FieldName)", false);
            BoolFuncTester("FIND('Test')", false);
            BoolFuncTester("ISBLANK('Test')",false);
            BoolFuncTester("ISDEFINED('Test')", false);
            BoolFuncTester("ISFUZZYDUP('Test1', 'Test2',1,1)", false);
            BoolFuncTester("ISFUZZYDUP('Test1', 'Test2',1)", false);
        }

        [TestMethod]
        public void DateFuncTest()
        {
            DatetimeFuncTester("CTOD('2015-01-01' 'YYYY-MM-DD')", false);
            DatetimeFuncTester("CTOD('2015-01-01')", false);
            DatetimeFuncTester("CTOD(20150101 'YYYY-MM-DD')", false);
            DatetimeFuncTester("CTODT(20150101 'YYYY-MM-DD')", false);
            DatetimeFuncTester("CTODT(20150101)", false);
            DatetimeFuncTester("CTOT('20:20:20')", false);
            DatetimeFuncTester("EOMONTH(`20150101` (-1))", false);
            DatetimeFuncTester("EOMONTH(`20150101`)", false);
            DatetimeFuncTester("EOMONTH()", false);
            DatetimeFuncTester("GOMONTH(`20150101` 1)", false);
            DatetimeFuncTester("HOUR(`20150101t010101`)", false);
        }
    }
}
