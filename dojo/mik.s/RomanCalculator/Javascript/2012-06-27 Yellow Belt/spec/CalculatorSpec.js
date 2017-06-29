describe("Calculator", function() {
	var sut = new Calculator();
    
    // These four tests may be commented as they don't represent the contract
    // exposed by Calculator
    describe("removeSubtractions", function() {
        it("should expand XLIV into XXXXIIII", function() {
            var result = sut.removeSubtractions("XLIV");            
            expect(result).toEqual("XXXXIIII");
        });        
    });
    
    describe("collapseRepeats", function() {
        it("should collapse XXXXXVVVVV into LXXV", function() {
            var result = sut.collapseRepeats("XXXXXVVVVV");    
            expect(result).toEqual("LXXV");
        });        
    });
    
    describe("applySubtractions", function() {
        it("should collapse XXXXIIII into XLIV", function() {
            var result = sut.applySubtractions("XXXXIIII");     
            expect(result).toEqual("XLIV");
        });        
    });
    
    describe("sortNumerals", function() {
        it("should sort XLCDIVM to MDCLXVI", function() {
            var result = sut.sortNumerals("XLCDIVM");    
            expect(result).toEqual("MDCLXVI");
        });        
    });
    
    // These tests represent the public contract for Calculator
    describe("add", function() { 
        it("simple_concatenation_must_return_correct_result", function() {
            var result = sut.add("V", "II");
            expect(result).toEqual("VII");
        });

        it("add_to_higher_level_must_return_correct_result", function() {
            var result = sut.add("III", "III");
            expect(result).toEqual("VI");
        });
        
        it("add_with_subtracted_first_operand_must_return_correct_result", function() { 
            var result = sut.add("IV", "III");
            expect(result).toEqual("VII");
        });
        
        it("add_with_subtracted_second_operand_must_return_correct_result", function() {
            var result = sut.add("III", "IV");
            expect(result).toEqual("VII");
        });
        
        it("add_returning_result_with_four_Is_must_return_subtracted_result", function() {
            var result = sut.add("II", "II");
            expect(result).toEqual("IV");
        });
        
        it("add_returning_result_with_four_Xs_must_return_subtracted_result", function() {
            var result = sut.add("XX", "XX");
            expect(result).toEqual("XL");
        });
        
        it("add_returning_result_with_four_Cs_must_return_subtracted_result", function() {
            var result = sut.add("CC", "CC");
            expect(result).toEqual("CD");
        });
        
        it("add_must_substitute_X_for_two_Vs", function() {
            var result = sut.add("V", "V");
            expect(result).toEqual("X");
        });
        
        it("add_must_substitute_C_for_two_Ls", function() {
            var result = sut.add("L", "L");
            expect(result).toEqual("C");
        });
        
        it("add_must_substitute_M_for_two_Ds", function() {
            var result = sut.add("D", "D");
            expect(result).toEqual("M");
        });
        
        it("add_must_concatenate_multiple_Ms_if_needed", function() {
            var result = sut.add("MD", "MD");
            expect(result).toEqual("MMM");
        });
    });
});