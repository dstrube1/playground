#!/usr/bin/perl

#FizzBuzz in perl
#DS 2014-02-02

use strict;
use feature ':5.10';

#because true and false are not keywords in perl
use constant false => 0; 
use constant true  => 1;

use constant V2 => true;

sub isFizzBuzz{
	if( &isFizz($_[0]) and &isBuzz($_[0])){
		return true; 
	}else{
		return false;	
	}
}
sub isFizz{
	my $char = '3';
	if($_[0] % 3 == 0 or (V2 and index($_[0], $char) > -1)){
		return true;
	}else{
		return false;	
	}
}
sub isBuzz{
	my $char = '5';
	if($_[0] % 5 == 0 or (V2 and index($_[0], $char) > -1)){
		return true;
	}else{
		return false;	
	}
}

#MAIN
for(my $i = 1; $i <=100; $i++){
	#print "for loop #$i: ";
	if (&isFizzBuzz($i) ){
			say "FizzBuzz";
	}elsif(&isFizz($i)){
			say "Fizz";
	}elsif(&isBuzz($i)){
			say "Buzz";
	}else{
			say "$i";
	}
}

#one liner, improved from http://c2.com/cgi/wiki?FizzBuzzTest - doesn't include V2 flag check
#print ( ((($_ % 3 and index($_, '3') == -1) ? "" : "Fizz") . (($_ % 5  and index($_, '5') == -1) ? "" : "Buzz")) || $_, "\n") for (1..100);