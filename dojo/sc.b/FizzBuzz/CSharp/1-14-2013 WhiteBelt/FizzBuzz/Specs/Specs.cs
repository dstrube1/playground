using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace FizzBuzz.Specs
{
    [Binding]
    public class Specs
    {
        private readonly List<int> _listOfNumbers = new List<int>();
        private string _fizzBuzzResult;

        [Given(@"the number (.*)")]
        public void GivenTheNumber(int number)
        {
            _listOfNumbers.Add(number);
        }
        [Given(@"the numbers (\d+) to (\d+)")]
        public void GivenTheNumbersTo(int start, int end)
        {
            _listOfNumbers.AddRange(Enumerable.Range(start, end - start+1));
        }


        [When(@"I convert to FizzBuzz")]
        public void WhenIConvertToFizzBuzz()
        {
            var fizzBuzz = new FizzBuzzer(new Fizzer(), new Buzzer());
            _fizzBuzzResult = fizzBuzz.ConvertAll(_listOfNumbers);
        }
        [When(@"I convert to FizzBuzz with enhanced rules")]
        public void WhenIConvertToFizzBuzzWithEnhancedRules()
        {
            var fizzBuzz = new FizzBuzzer(new FizzerEnhanced(new Fizzer()), new BuzzerEnhanced(new Buzzer()));
            _fizzBuzzResult = fizzBuzz.ConvertAll(_listOfNumbers);
        }


        [Then(@"the result should be '(.*)'")]
        public void ThenTheResultShouldBe(string output)
        {
            Assert.That(_fizzBuzzResult, Is.EqualTo(output));
        }
    }
}