function Calculator() {
}

// Adding to the prototype instead of individual objects (in the constructor 
// above) conserves memory at the slight expense of lookup delay
Calculator.prototype.numerals = [
    "M", "D", "C", "L", "X", "V", "I"
];

Calculator.prototype.subtractions = [
    ["IV", "IIII"],
    ["IX", "VIIII"],
    ["XL", "XXXX"],
    ["XC", "LXXXX"],
    ["CD", "CCCC"],
    ["CM", "DCCCC"]
];

Calculator.prototype.repeats = [
    ["IIIII", "V"],
    ["VV", "X"],
    ["XXXXX", "L"],
    ["LL", "C"],
    ["CCCCC", "D"],
    ["DD", "M"]
];

Calculator.prototype.multiReplace = function(n, replacements, reverse) {
    var text = n;
    
    $(replacements).each(function() {
        text = text.replace(
            new RegExp(this[reverse ? 1 : 0], "g"), 
            this[reverse ? 0 : 1]
        );
    });
    
    return text;
};

Calculator.prototype.removeSubtractions = function(n) {
    return this.multiReplace(n, this.subtractions);
};

Calculator.prototype.collapseRepeats = function(n) {
    return this.multiReplace(n, this.repeats);
};

Calculator.prototype.applySubtractions = function(n) {
    return this.multiReplace(n, this.subtractions, true);
};

// There's probably a better way to do this in Javascript
Calculator.prototype.sortNumerals = function(n) {
    var result = "";
    var chars = n.split('');
    
    $(this.numerals).each(function() {
        var num = "" + this;        // Convert to actual string
        
        $(chars).each(function() {
            var ch = "" + this;     // Convert to actual string
            
            if (ch === num) {
                result = result + this;
            }
        });
    });
   
    return result;
};

Calculator.prototype.add = function(n1, n2) {	
	n1 = this.removeSubtractions(n1);
    n2 = this.removeSubtractions(n2);
    
    var sum = n1 + n2;
    sum = this.sortNumerals(sum);
    sum = this.collapseRepeats(sum);
    sum = this.applySubtractions(sum);

    return sum;
}