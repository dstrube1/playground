#!/usr/bin/perl
use feature ':5.10'; #so now we can say "blah" instead of print "blah\n";"

sub test1{
	$var0 = "23";
	$var1 = "51";
	$var2 = 23;
	$var3 = 51;
	
	my $char = '3';
	my $char0 = 3;
	
	my $result = index($var0, $char);
	
	print "Result: $result\n";
	  
	$result = index($var1, $char);
	
	print "Result: $result\n";
	
	$result = index($var2, $char);
	
	print "Result: $result\n";
	
	$result = index($var3, $char);
	
	print "Result: $result\n";
	
	$result = index($var0, $char0);
	
	print "Result: $result\n";
	  
	$result = index($var1, $char0);
	
	print "Result: $result\n";
	
	$result = index($var2, $char0);
	
	print "Result: $result\n";
	
	$result = index($var3, $char0);
	
	print "Result: $result\n";
}

sub test2{
	my $var1 = "97";
	my $var2 = "45";
	my $var3 = $var2 - $var1;
	print "var3 = $var3\n";
	$var3 = abs($var2 - $var1);
	print "var3 = $var3\n";
	$var1 = "97*";
	$var2 = "40";
	$var1 =~ s/(\D)//; #replace any non-digit char with nothing
	#http://www.troubleshooters.com/codecorn/littperl/perlreg.htm
	print "var1 = $var1\n";
	$var3 = abs($var2 - $var1);
	print "var3 = $var3\n";
}

sub test3{ 			#valid: anything with only 0 or more xs, 0 or more -s, 0 or more /s, and 0 or more numbers from 1-9
	my @vars = (	#invlaid: anything else
		"x", 			#valid
		"x1",			#valid
		"x-",			#valid
		"-x-",			#valid
		"x-x--",		#valid
		"x-x-y",		#invalid
		"0",			#invalid
		"x0",			#invalid
		"0x0",			#invalid
		"1",			#valid
		"11",			#valid
		"010",			#invalid
		"/",			#valid
		"x/",			#valid
		"/x",			#valid
		"x//x",			#valid
		"f",			#invalid
		"xf",			#invalid
		"fx",			#invalid
		"xffx",			#invalid
		"x11-//xx1--/",	#valid
		"X"				#valid
		);
	#say "at vars = @vars";
	
	#say "length of vars = ". length @vars; # wrong
	#say "length of vars = ". ($#vars+1); # $#vars != legnth; = maximal index
	
	foreach my $var (@vars){
		#say "var = $var";
		my $len1 = length $var;
		#http://www.comp.leeds.ac.uk/Perl/matching.html
		#http://www.troubleshooters.com/codecorn/littperl/perlreg.htm
		#http://www.cs.tut.fi/~jkorpela/perl/regexp.html
		#$var =~ s/![1..9],x,-*//;
		my $var2 = $var;
		$var =~ s/[^x1..9\/\-*]//; # equivalent: $var =~ s/[^x* ^1..9* ^\/* ^\-*]//;
		#$var =~ s/[^x[1..9]\/-]*//;
		#$var =~ s/!~(x*[1..9]*\/*-*)//;
		#we'll just use a loop to examine every character; come back to this later
#		for (my $i = 0; $i < $lenPre; $i++){
#			my $char = chop $reversedPre;
#			say "char = $char";
#		}
		
		my $len2 = length $var;
		if ($len1 != $len2){
			say "invalid: $var2";
		}else{
			say "valid: $var2";
		}
	}
}
#MAIN:
&test3;