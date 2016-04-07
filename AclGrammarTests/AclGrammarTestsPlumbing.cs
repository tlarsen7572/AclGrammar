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
    }
}
