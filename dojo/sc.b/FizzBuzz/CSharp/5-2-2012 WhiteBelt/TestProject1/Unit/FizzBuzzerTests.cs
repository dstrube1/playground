using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FizzBuzz;
using Moq;
using NUnit.Framework;

namespace TestProject1.Unit
{
    [TestFixture]
    class FizzBuzzerTests
    {
        [Test]
        public void for_numbers_should_call_fizz_creator()
        {
            var outputMock = new Mock<IOutput>();
            var fizzMock = new Mock<IFizzCreator>();
            var sut = new FizzBuzzer(outputMock.Object, fizzMock.Object);

            sut.ForNumbers(new int[] {0, 1, 2}).ToList();

            fizzMock.Verify(x => x.GetLine(It.IsAny<int>()), Times.Exactly(3));
        }
        [Test]
        public void for_numbers_should_not_call_fizz_creator_until_iteration()
        {
            var outputMock = new Mock<IOutput>();
            var fizzMock = new Mock<IFizzCreator>();
            var sut = new FizzBuzzer(outputMock.Object, fizzMock.Object);

            sut.ForNumbers(new int[] {0, 1, 2});

            fizzMock.Verify(x => x.GetLine(It.IsAny<int>()), Times.Never());
        }
    }
}
