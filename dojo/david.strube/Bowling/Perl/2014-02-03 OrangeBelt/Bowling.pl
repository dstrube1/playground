#!/usr/bin/perl

#Bowling in perl
#DS 2014-02-03

use strict;
use bytes;

use autodie; # die if problem reading or writing a file
use feature ':5.10'; #so now we can say "blah" instead of print "blah\n";"

#because true and false are not keywords in perl
use constant true  => 1;
use constant false => 0;

use constant SPARE => "/";
use constant STRIKE => "x";
use constant GUTTER => "-";

sub getRolls{
	my $line = <STDIN>;
	chomp $line;
	
	$line = lc $line;
	
	if (length($line) == 0){
		say "You entered nothing.";
		return;
	}
	elsif (! &hasOnlyValidCharacters($line)){
		say "Invalid sequence";
		return;
	}
	
	if (length($line) == 1){
		say "Value of sequence is " . &getCharacterValue($line);
		return;
	}
	
	#else, now the fun part
	my $counter = 0;
	my $frame = 0;
	my $total = 0;
	while (length($line) >= $counter){
		#one way to do it:
		#$line = reverse $line;
		#my $char = chop $line;
		#$line = reverse $line;
		#another (this way leaves the first char in place):
		my $char = substr($line,$counter,1);
		my $c1ahead;
		my $c2ahead;
		my $c1back;
		my $prevRollWasNumber;
		my $beginningOfFrame = true;
		
		if ($counter + 1 < length($line)){
			$c1ahead = substr($line, $counter+1,1);
		}else{
			undef $c1ahead;
		}
		if ($counter + 2 < length($line)){
				$c2ahead = substr($line, $counter+2,1)
		}else{
			undef $c2ahead;
		}
		if($counter == 0){
			undef $c1back;
		}else{
			$c1back = substr($line, $counter-1, 1);
		}
		
		if ($char eq STRIKE && $counter == length($line) - 3 && $frame == 10) {
			say "Value of sequence is " . $total + &getCharacterValue($char) + &getCharacterValue($c1ahead) + &getCharacterValue($c2ahead);
			return;
		}elsif ($char eq SPARE && $counter == length($line) - 2 && $frame == 10) {
			say "Value of sequence is " . $total + &getCharacterValue($char) + &getCharacterValue($c1ahead);
			return;
		}elsif($char eq STRIKE){
			if ($c2ahead eq SPARE){
				$total += &getCharacterValue($char) + &getCharacterValue($c2ahead);
			}
			else{
				$total+= &getCharacterValue($char) + &getCharacterValue($c1ahead) + &getCharacterValue($c2ahead);
			}
		}elsif($char eq SPARE){
			$total+= &getCharacterValue($char) + &getCharacterValue($c1ahead);
		}elsif($c1ahead eq SPARE){}
		else{$total += &getCharacterValue($char);}
		
		$prevRollWasNumber = &isCharPostiveNumber($c1back);
		if (! $beginningOfFrame && $prevRollWasNumber && &isCharPostiveNumber($char)){
				$beginningOfFrame  = true;
				$frame++;
			}
			elsif ($char eq SPARE || $char eq STRIKE){
				$beginningOfFrame  = true;
				$frame++;
			}else{
				$beginningOfFrame  = false;
			}
		$counter++;
	}
	say "Value of sequence is $total";
}
sub hasOnlyValidCharacters{
	my $chars = $_[0];
	#alternative: my ($blah,$blah1) = @_;
	
	if (! defined $chars || length($chars) == 0){
		return false;
	}
	
	$chars = lc $chars;
	
	my $invalidsRemoved = $chars;
	$invalidsRemoved =~ s/[^\/\-x1-9]*//g;
	#say "invalidsRemoved: $invalidsRemoved ";
	if (length($invalidsRemoved) == length($chars)){
		return true;
	}else{
		return false;
	}
}

sub getCharacterValue{

	my $char = $_[0];
	
	if (! defined $char || length($char)==0){return 0;}
	
	while (length($char)>1){chop $char;	}
	
	if (! &hasOnlyValidCharacters($char) || $char eq GUTTER){return 0;}
	
	$char = lc $char;
	if ($char eq SPARE || $char eq STRIKE){return 10;}
	return $char;
}

sub isCharPostiveNumber{
	my $char = $_[0];
	if ($char eq "1" || $char eq "2" || $char eq "3" || $char eq "4" || $char eq "5" || 
	$char eq "6" || $char eq "7" || $char eq "8" || $char eq "9"){return true;}
	
	return false;
}

sub testing{
	#my @array = ("1","2");
	#for (@array){
	#	say ; 
	#}
	
	###
	#Testing hasOnlyValidCharacters
	###
	my @valids = ("-","x","xx","X-X","123x","1-2-x3","1","/");
	for my $valid (@valids){
		#split these says up so that debug statements in hasOnlyValidCharacters 
		# don't come before we see what we're looking at
		#say "hasOnlyValidCharacters($valid) = ";
		#say &hasOnlyValidCharacters($valid);
	}
	
	my $myNull;
	my @invalids = ($myNull, "a","0","aa1x8b-cc","");
	for my $invalid (@invalids){
		#say "hasOnlyValidCharacters($invalid) = ";
		#say &hasOnlyValidCharacters($invalid);
	}
	###
	#Testing getCharacterValue
	###
	my @characterValues = ($myNull,"","-","x","/","-X","X-","5"	);
	for my $char (@characterValues){
		#say "getCharacterValue($char) = " . &getCharacterValue($char);
	}
	
	#printing an equation in perl is tedious
	#say "4";
	#say " + " ;
	#say " 5 " ;
	#say " = ";
	#say &getCharacterValue("4") + &getCharacterValue("5") ;
	
	###
	#Testing isCharPostiveNumber
	###
	my @charsGood("1","2","3");
	my @charsBad("-1","0","10");
	for my $charGood (@charsGood){
		#say "isCharPostiveNumber($charGood) = " . &isCharPostiveNumber($charGood);
	}
	for my $charBad (@charsBad){
		#say "isCharPostiveNumber($charBad) = " . &isCharPostiveNumber($charBad);
	}
	
	my $line = "hello";
	my $char0 = substr($line,0,1);
	#say "line = $line; char0 = $char0";
}
#MAIN:

say "Please enter the sequence of rolls.";
&getRolls();

#&testing();
say "Thanks for playing!";		
