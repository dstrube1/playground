describe("Printer", function() {
	var printer;
	var linePrinter;

	beforeEach(function() {
		linePrinter = new LinePrinter();
		printer = new Printer(linePrinter);
	});
  
	describe("printLines", function() {
		it("should throw an exception if number of lines is not a number", function() {
			expect(function() {
				printer.printLines("Howdy");
			}).toThrow("numberOfLines must be a number greater than zero");
		});

		it("should throw an exception if number of lines is less than one", function() {
			expect(function() {
				printer.printLines(0);
			}).toThrow("numberOfLines must be a number greater than zero");
		});

		it("should return specified number of lines", function() {
			var numberOfLines = 100;
			var count = 0;
			
			var lines = printer.printLines(numberOfLines);
			
			expect(lines.length).toEqual(numberOfLines);
		});
	});
});