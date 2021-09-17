<script>
	function isMultipleOfOrContains(i,j)
	{
		if(i%j == 0 )
		{return true;}
		if(String(i).indexOf(String(j)) !== -1)
		{return true;}
		return false;
	}
	
	function fizzBuzz()
	{
        var isFizz = false;
		var isBuzz = false;
		
        for (var i = 1; i < 101; i++) {
            isFizz= isMultipleOfOrContains(i,3);
			isBuzz = isMultipleOfOrContains(i,5);
			
			if(isFizz && isBuzz)
			{ document.write("FizzBuzz <br/>"); }
			else if(isFizz)
            { document.write("Fizz <br/>"); }
            else if (isBuzz)
            { document.write("Buzz <br/>"); }
            else
            { document.write(i + "<br/>"); }
        }
	}
</script>