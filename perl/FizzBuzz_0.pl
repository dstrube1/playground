#!/usr/bin/perl

#because true and false are not keywords in perl
use constant false => 0; 
use constant true  => 1;


sub isFizzBuzz{
	if( &isFizz($_[0]) and &isBuzz($_[0])){
		#print "\&isFizz(\$_[0]) = isFizz($_[0]) = true\n";
		return true; 
	}else{
		return false;	
	}
}
sub isFizz{
	if($_[0] % 3 == 0){
		return true;
	}else{
		return false;	
	}
}
sub isBuzz{
	if($_[0] % 5 == 0){
		return true;
	}else{
		return false;	
	}
}

for($i = 1; $i <=100; $i++){
	#print "for loop #$i: ";
	if (&isFizzBuzz($i) ){
			#print "FizzBuzz\n";
	}elsif(&isFizz($i)){
			#print "Fizz\n";
	}elsif(&isBuzz($i)){
			#print "Buzz\n";
	}else{
			#print "$i\n";
	}
}

#one liner from http://c2.com/cgi/wiki?FizzBuzzTest
print ( ((($_ % 3) ? "" : "Fizz") . (($_ % 5) ? "" : "Buzz")) || $_, "\n") for (1..100);