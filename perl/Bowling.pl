#!/usr/bin/perl
use strict;

#this is so we can: 
#say "blah"; 
#instead of :
#print "blah\n";"
use feature ':5.10'; 

#because true and false are not keywords in perl
use constant true  => 1;
use constant false => 0;

use constant SPARE => '/';
use constant STRIKE => 'x';
use constant GUTTER => '-';

sub hasOnlyValidCharacters{
	my $len1 = length $_[0];
	my $var = $_[0];
	$var =~ s/[^x1..9\/\-*]//;
	my $len2 = length $var;
	if ($len1 != $len2){
			return false;
		}else{
			return true;
	}
}

#MAIN:

say "Please enter the sequence of rolls.";

while (<>){
	chomp; #chop off \n
	if (length == 0){
		say "You entered nothing. Exiting";
		return;
	}
	#my $reversedPre = reverse;
	#say "$_ reversed = $reversed";
	#say "length of reversed = ". length $reversed;
#	my $lenPre = length;
#	
#	
#	
#	for (my $i = 0; $i < $lenPre; $i++){
#		my $char = chop $reversedPre;
#		say "char = $char";
#	}
	if (! &hasOnlyValidCharacters($_)){
		say "Invalid sequence. Exiting";
		return;
	}
	
	##
	
	say "Please enter the sequence of rolls.";
}