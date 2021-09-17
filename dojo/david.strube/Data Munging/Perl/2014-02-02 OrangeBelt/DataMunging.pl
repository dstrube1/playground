#!/usr/bin/perl

#DataMunging in perl
#DS 2014-02-02

use strict;

use Path::Class;
use autodie; # die if problem reading or writing a file
use feature ':5.10'; #so now we can say "blah" instead of print "blah\n";"

#because true and false are not keywords in perl
use constant true  => 1;
use constant false => 0;

use constant DIR => ".";
use constant WEATHER_FILE => "weather.dat";
use constant FOOTBALL_FILE => "football.dat";
use constant WEATHER_HEADER => "Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP";
use constant FOOTBALL_HEADER => "       Team            P     W    L   D    F      A     Pts";
use constant FOOTER => "</pre>";

sub partOne{
	my $passedHeader = false;
	my $beforeFooter = true;
	my $dayWithSmallestSpread = "";
	my $smallestSpread = 1000;
	my $dir = dir(DIR); 
	my $file = $dir -> file(WEATHER_FILE);
	
	my $file_handle = $file->openr();
	my @arrayOfArrays = ();
	
	# Read in line at a time
	while( my $line = $file_handle->getline() ) {
		
		chomp($line);
		if (length($line) ==0){next;} #continue means something else in perl

		my $index = index($line,FOOTER);
		
        if ($index >= 0){
			$beforeFooter = false;
		}
		
		if ($passedHeader){
			if ($beforeFooter){
				
				#say "weather line: $line";
				my @array = split ' ', $line;
				push @arrayOfArrays, [@array];
			}
		}
		
		$index = index($line,WEATHER_HEADER);
		if ($index >= 0){
			$passedHeader = true;
		}
	} #end while
	
	for my $i ( 0 .. $#arrayOfArrays ) {
		
		my $tempDiff = 0;
 		my $row = $arrayOfArrays[$i];
 		
	    for my $j ( 0 .. $#{$row} ) {
	    	
	    	if ($j == 2){ #at 3rd column, compare 3rd and 2nd
	    	
	    		$row->[$j] =~ s/(\*)//; #replace any non-digit char with nothing
	    		$row->[$j-1] =~ s/(\*)//; 
	    		
	    		$tempDiff = abs($row->[$j] - $row->[$j-1]);
	    		#say "tempDiff = abs($row->[$j] - $row->[$j-1]) = $tempDiff";
	    		
	    		#my $temp = <>;
	    		#say "DEBUG: dayWithSmallestSpread = $dayWithSmallestSpread";
	    		#my $temp2 = <>;
	    		if ($tempDiff < $smallestSpread){ #$dayWithSmallestSpread == "" || 
	    			$dayWithSmallestSpread = $row->[$j-2];
	    			$smallestSpread = $tempDiff;
	    		}
	    	}
	    	
    	#    say "element [$i] [$j] is $row->[$j]";
	    }
	} #end outer for
	
	say "Day with smallest spread = $dayWithSmallestSpread; smallest spread = $smallestSpread\n";
		
}

sub partTwo{
	my $passedHeader = false;
	my $beforeFooter = true;
	my $teamWithSmallestSpread = "";
	my $smallestSpread = 1000;
	
	my $dir = dir(DIR); 
	my $file = $dir->file(FOOTBALL_FILE);
	my $file_handle = $file->openr();
	my @arrayOfArrays = ();
		
	# Read in line at a time
	while( my $line = $file_handle->getline() ) {
		
		chomp($line);
		if (length($line) ==0){next;} #continue means something else in perl
		
        my $index = index($line,FOOTER);
        
        if ($index >= 0){
			$beforeFooter = false;
		}
		if ($passedHeader){
			if ($beforeFooter){
				#say "football line: $line";
				my @array = split ' ', $line;
				push @arrayOfArrays, [@array];
			}
		}
		
		$index = index($line,FOOTBALL_HEADER);
		if ($index >= 0){
			$passedHeader = true;
		}
	} #end while
	
	for my $i ( 0 .. $#arrayOfArrays ) {
		my $tempDiff = 0;
		my $row = $arrayOfArrays[$i];
		
		for my $j (0 .. $#{$row}){
			if ($j == 8){ #at 9th column, compare 7th and 9th
				$tempDiff = abs($row->[$j] - $row->[$j-2]);
				
				if ($tempDiff < $smallestSpread){
					$teamWithSmallestSpread = $row->[$j-7];
					$smallestSpread = $tempDiff;
				}
			}
		}
	} #end outer for
		
	say "Team with smallest spread = $teamWithSmallestSpread; smallest spread = $smallestSpread\n";
}

sub partThree{
	my $passedHeader = false;
	my $beforeFooter = true;
	
	#this seems to only give valid value on true:
	#my $usingWeather = ($_[0] eq WEATHER_FILE);  
	my $usingWeather = false;
	if ($_[0] eq WEATHER_FILE){
		$usingWeather = true; 
	}
	#say "usingWeather == true? : $usingWeather";
	
	my $identifierWithSmallestSpread = "";
	my $smallestSpread = 1000;
	
	my $dir = dir(DIR); 
	my $file = $dir->file($_[0]);
	my $file_handle = $file->openr();
	my @arrayOfArrays = ();
	
	my $header = "";
	if ($usingWeather){
		$header = WEATHER_HEADER;
	}else{
		$header = FOOTBALL_HEADER;
	}
	
	# Read in line at a time
	while( my $line = $file_handle->getline() ) {
		
		chomp($line);
		if (length($line) ==0){next;} #continue means something else in perl
		
        my $index = index($line,FOOTER);
        
        if ($index >= 0){
			$beforeFooter = false;
		}
		if ($passedHeader){
			if ($beforeFooter){
				my @array = split ' ', $line;
				push @arrayOfArrays, [@array];
			}
		}
		
		$index = index($line,$header);
		if ($index >= 0){
			$passedHeader = true;
		}
	} #end while
	
	for my $i ( 0 .. $#arrayOfArrays ) {
		my $tempDiff = 0;
		my $row = $arrayOfArrays[$i];
		
		for my $j (0 .. $#{$row}){
			
			if ($usingWeather && $j == 2){ #at 3rd column, compare 3rd and 2nd
	    	
	    		$row->[$j] =~ s/(\*)//; #replace any non-digit char with nothing
	    		$row->[$j-1] =~ s/(\*)//; 
	    		
	    		$tempDiff = abs($row->[$j] - $row->[$j-1]);
	    		if ($tempDiff < $smallestSpread){  
	    			$identifierWithSmallestSpread = $row->[$j-2];
	    			$smallestSpread = $tempDiff;
	    		}
	    	}elsif (! $usingWeather && $j == 8){ #at 9th column, compare 7th and 9th
				$tempDiff = abs($row->[$j] - $row->[$j-2]);
				
				if ($tempDiff < $smallestSpread){
					$identifierWithSmallestSpread = $row->[$j-7];
					$smallestSpread = $tempDiff;
				}
			}
			
		}
	} #end outer for
	
	if ($usingWeather){
		say "Weather identifier with smallest spread = $identifierWithSmallestSpread; smallest spread = $smallestSpread";
	}else{
		say "Football identifier with smallest spread = $identifierWithSmallestSpread; smallest spread = $smallestSpread";
	}
}
	
#MAIN:

say "Part one:";
&partOne();
		
say "Part two:";
&partTwo();

say "Part three:";
&partThree(WEATHER_FILE);
&partThree(FOOTBALL_FILE);
		
