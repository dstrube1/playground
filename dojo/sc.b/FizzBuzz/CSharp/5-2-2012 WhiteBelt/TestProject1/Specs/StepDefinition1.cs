using System.Collections.Generic;
using System.Linq;
using FizzBuzz;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace TestProject1.Specs
{
    [Binding]
    public class StepDefinition1
    {
        public T ContextItem<T>(string key) where T : class
        {
            if (ScenarioContext.Current.ContainsKey(key))
                return ScenarioContext.Current[key] as T;
            return null;
        }
        [Given(@"I have (\d+) integers")]
        public void GivenIHaveNIntegers(int count)
        {
            var items = new List<int>();
            for(int i = 0;i< count;i++)items.Add(i);

            ScenarioContext.Current.Add("numbers", items);
        }

        [When(@"I fizzbuzz")]
        public void WhenIFizzBuzz()
        {
            var numbers = ScenarioContext.Current["numbers"] as List<int>;

            var fizzBuzzer = new FizzBuzzer(new NullWriter(), new FizzCreator());
            var result = fizzBuzzer.ForNumbers(numbers);

            ScenarioContext.Current.Add("result", result.ToList());
        }
        [When(@"get all numbers divisible by (\d+)")]
        public void NumbersDivisibleByN(int divisibleBy)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            ScenarioContext.Current["result"] =result.Where(item => item.Index % divisibleBy == 0);
        }
        [When(@"not divisible by (\d+)")]
        public void NotDivisibleBy(int notDivisibleBy)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            ScenarioContext.Current["result"] = result.Where(item => item.Index % notDivisibleBy != 0);
        }
        [When(@"get all numbers containing a (\d+)")]
        public void AllNumbersContainingN(int contains)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            ScenarioContext.Current["result"] = result.Where(item => item.Index.ToString().Contains(contains.ToString())); 
        }
        [When(@"not contains a (\d+)")]
        public void NotContains(int notContains)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            ScenarioContext.Current["result"] = result.Where(item => !item.Index.ToString().Contains(notContains.ToString()));
        }

        [Then(@"the result should have (\d+) lines")]
        public void TheResultShouldHaveNLines(int lineCount)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            Assert.AreEqual(100, result.Count());
        }

        [Then(@"each should be ([^t].*)")]
        public void EachShouldBe(string output)
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            Assert.That(result.Select(x => x.Value), Is.All.EqualTo(output));
        }
        [Then(@"each should be the index")]
        public void EachShouldBe()
        {
            var result = ContextItem<IEnumerable<LineResult>>("result");
            var isNumber = result.Where(item => item.Value == item.Index.ToString());
            Assert.That(isNumber.Select(x=>x.Value), Is.EquivalentTo(result.Select(x=>x.Value)));
        }
    }
}
