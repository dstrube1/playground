#!/usr/bin/perl
use strict;

#because true and false are not keywords in perl
use constant true  => 1;
use constant false => 0;

sub minA{
	my $minFrac = $_[0] / 60;
	my $minAngle = $minFrac * 360;
	return  $minAngle;
}

sub hrA{
	my $hr = $_[0] % 12;
	my $hrFrac = $hr / 12;
	my $hrAngle = $hrFrac * 360; 
	return $hrAngle; #$_[0] + $_[1];
}

#MAIN:

for(my $i = 0; $i <=23; $i++){
	for(my $j = 0; $j <=59; $j++){
		my $k = ($j <= 9) ? "$i:0".$j : "$i:$j";
		my $minA = &minA($j);
		my $hrA = &hrA($i,$j);
		print "$k = $hrA , $minA\n";
	}
}