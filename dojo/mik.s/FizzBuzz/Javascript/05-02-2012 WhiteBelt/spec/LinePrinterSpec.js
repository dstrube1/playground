describe("LinePrinter", function() {
  var linePrinter;

  beforeEach(function() {
    linePrinter = new LinePrinter();
  });
  
  describe("printLine", function() {
    it("should throw an exception if line number is not a number", function() {
      expect(function() {
        linePrinter.printLine("Howdy");
      }).toThrow("lineNumber must be a number greater than zero");
    });
	
	it("should throw an exception if line number is less than one", function() {
      expect(function() {
        linePrinter.printLine(0);
      }).toThrow("lineNumber must be a number greater than zero");
    });
	
	it("should return 'fizz' for numbers divisible only by 3", function() {
		var line = linePrinter.printLine(3);
		expect(line).toEqual('fizz');
	});
	
	it("should return 'fizz' for numbers containing a 3", function() {
		var line = linePrinter.printLine(13);
		expect(line).toEqual('fizz');
	});
	
	it("should return 'buzz' for numbers divisible only by 5", function() {
		var line = linePrinter.printLine(5);
		expect(line).toEqual('buzz');
	});
	
	it("should return 'buzz' for numbers containing a 5", function() {
		var line = linePrinter.printLine(25);
		expect(line).toEqual('buzz');
	});
	
	it("should return 'fizzbuzz' for numbers divisible by 3 and 5", function() {
		var line = linePrinter.printLine(15);
		expect(line).toEqual('fizzbuzz');
	});
	
	it("should return 'fizzbuzz' for numbers containing 3 and 5", function() {
		var line = linePrinter.printLine(53);
		expect(line).toEqual('fizzbuzz');
	});
	
	it("should return 'fizzbuzz' for numbers divisible by 3 and containing 5", function() {
		var line = linePrinter.printLine(51);
		expect(line).toEqual('fizzbuzz');
	});
	
	it("should return 'fizzbuzz' for numbers divisible by 5 and containing 3", function() {
		var line = linePrinter.printLine(35);
		expect(line).toEqual('fizzbuzz');
	});
  });
});