function Printer(linePrinter) {
	if (!linePrinter) {
		throw new Error("linePrinter may not be null");
	}
	
	if (!linePrinter.printLine) {
		throw new Error("linePrinter must have a function called 'printLine'");
	}
	
	this.linePrinter = linePrinter;
}

Printer.prototype.printLines = function(numberOfLines) {
	if (isNaN(numberOfLines) || numberOfLines <= 0) {
		throw new Error("numberOfLines must be a number greater than zero");
	}
	
	var lines = new Array();
	
	for (var i=1; i<=numberOfLines; i++) {
		var line = this.linePrinter.printLine(i);
		lines[i-1] = line;
	}
	
	return lines;
}