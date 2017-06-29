function LinePrinter() {
}

LinePrinter.prototype.printLine = function(lineNumber) {
	if (isNaN(lineNumber) || lineNumber <= 0) {
		throw new Error("lineNumber must be a number greater than zero");
	}
	
	var uses3 = lineNumber % 3 === 0 || String(lineNumber).indexOf('3') >= 0;
	var uses5 = lineNumber % 5 === 0 || String(lineNumber).indexOf('5') >= 0;
	
	if (uses3 && uses5) {
		return 'fizzbuzz';
	}
	
	if (uses5) {
		return 'buzz';
	}
	
	if (uses3) {
		return 'fizz';
	}
	
	return String(lineNumber);
}