using FizzBuzzKata;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace TestProject1
{
    
    
    /// <summary>
    ///This is a test class for FizzBuzzTest and is intended
    ///to contain all FizzBuzzTest Unit Tests
    ///</summary>
    [TestClass()]
    public class FizzBuzzTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for FizzOrBuzz(int n)
        ///</summary>
        [TestMethod()]
        public void FizzOrBuzzAssertMod3Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 3;
            string expected = "Fizz";
            string actual;
            actual = target.FizzOrBuzz(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzzAssertMod5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 5;
            string expected = "Buzz";
            string actual;
            actual = target.FizzOrBuzz(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzzAssertMod3and5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 15;
            string expected = "FizzBuzz";
            string actual;
            actual = target.FizzOrBuzz(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzzAssertPrintNumTest() {
            FizzBuzz target = new FizzBuzz();
            int n = 11;
            string expected = "11";
            string actual;
            actual = target.FizzOrBuzz(n);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///Test cases for FizzOrBuzz2(int n)
        ///</summary>
        [TestMethod()]
        public void FizzOrBuzz2AssertMod3Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 3;
            string expected = "Fizz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertMod5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 5;
            string expected = "Buzz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertMod3and5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 15;
            string expected = "FizzBuzz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertContain3Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 31;
            string expected = "Fizz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertContain5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 52;
            string expected = "Buzz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertContain3and5Test() {
            FizzBuzz target = new FizzBuzz();
            int n = 53;
            string expected = "FizzBuzz";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
        public void FizzOrBuzz2AssertPrintNumTest() {
            FizzBuzz target = new FizzBuzz();
            int n = 11;
            string expected = "11";
            string actual;
            actual = target.FizzOrBuzz2(n);
            Assert.AreEqual(expected, actual);
        }
    }
}
