#!/usr/bin/perl
use strict;
use feature ':5.10';
#http://perldoc.perl.org/perldsc.html

#hash of hashes:
#setting
my  %HoH = ( 
        flintstones => {
		lead      => "fred",
		pal       => "barney",
        },
        jetsons     => {
		lead      => "george",
		wife      => "jane",
		"his boy" => "elroy",
        },
        simpsons    => {
		lead      => "homer",
		wife      => "marge",
		kid       => "bart",
	},
 );
 
  # one element
 $HoH{flintstones}{wife} = "wilma"; #wife wasn't there before; is there now
 # another element
 $HoH{simpsons}{lead} =~ s/(\w)/\u$1/; #take first word character ((\w) = 'h') of simpsons lead, replace it ($1) with uppercase (\u = 'H'), capitalizing homer

#printing 
foreach my $family ( keys %HoH ) {
     print "$family: { ";
     for my $role ( keys %{ $HoH{$family} } ) {
         print "$role=$HoH{$family}{$role} ";
     }
     say "}";
 }
 
 say "";
 #say "kinda sorted:";
 say "";
 
 foreach my $family ( sort keys %HoH ) {
     #print "$family: { ";
     for my $role ( sort keys %{ $HoH{$family} } ) {
      #   print "$role=$HoH{$family}{$role} ";
     }
     #say "}";
 }
 
 ###########################
 #array of arrays:
 my @AoA = (
         [ "fred", "barney" ],
         [ "george", "jane", "elroy" ],
         [ "homer", "marge", "bart" ],
);

say "";
#say $AoA[2][1];

##########################
#it's my turn
my $string = "Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP";
my @AoA0 = ();
my @array = split ' ', $string;
push @AoA0, [@array];

#printing each row:
for my $row (@AoA0){
	say "@$row";
}

#each row with tracking:
for my $i ( 0 .. $#AoA0 ) {
    say "row $i is: @{$AoA0[$i]}";
}

#with more tracking
for my $i ( 0 .. $#AoA0 ) {
    for my $j ( 0 .. $#{$AoA0[$i]} ) {
        #say "element $i $j is $AoA0[$i][$j]";
    }
}

#easier with a temporary variable along the way:
for my $i ( 0 .. $#AoA0 ) {
    my $row = $AoA0[$i];
    for my $j ( 0 .. $#{$row} ) {
        say "element [$i] [$j] is $row->[$j]";
    }
}