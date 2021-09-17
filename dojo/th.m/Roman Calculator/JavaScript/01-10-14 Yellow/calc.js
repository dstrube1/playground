var subPairs = {"IV":"IIII", "IX":"VIIII", "XL":"XXXX", "XC":"LXXXX", "CD":"CCCC", "CM":"DCCCC"};
var digits = "IVXLCDM";

$(document).ready(function() {
	$("#calc").click(function() {
		$("[name=sum]").val(sum($("[name=numI]").val(), $("[name=numII]").val()));
	});
});

function sum(numI, numII)
{
	numI = expandSubtractive(numI);
	numII = expandSubtractive(numII);
	
	num = sort(numI + numII);
	num = collapseExtras(num);
	num = collapseToSubtractive(num);
	
	return num;
}

function collapseToSubtractive(num)
{
	for(var key in subPairs)
	{
		num = num.replace(subPairs[key], key);
	}
	
	return num;
}

function collapseExtras(num)
{
	for(i=0; i<digits.length-1; i++)
	{
		if(i%2 == 0) limit = 5;
		else limit = 2;
		
		find = "";
		for(j=0; j<limit; j++) find += digits[i];
		
		replace = digits[i+1];
		
		num = num.replace(find, replace);
	}
	
	return num;
}

function sort(num)
{
	sorted = "";
	
	for(i=digits.length-1; i>=0; i--)
	{	
		count = num.split(digits[i]).length-1;
		
		for(j=0; j<count; j++) sorted += digits[i];
	}
	
	return sorted;
}

function expandSubtractive(num)
{
	for(var key in subPairs)
	{
		num = num.replace(key, subPairs[key]);
	}
	
	return num;
}