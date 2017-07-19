#!/usr/bin/perl
#http://stackoverflow.com/questions/1036347/how-do-i-use-boolean-variables-in-perl

use strict;
use warnings;

use constant false => 0;
use constant true  => 1;

my $boolean = 0;
if ( $boolean ) {
    print "$boolean evaluates to true\n";
} else {
    print "$boolean evaluates to false\n";
}

my $val1 = true;
my $val2 = false;

print $val1, " && ", $val2;
if ( $val1 && $val2 ) {
    print " evaluates to true.\n";
} else {
    print " evaluates to false.\n";
}

print $val1, " || ", $val2;
if ( $val1 || $val2 ) {
    print " evaluates to true.\n";
} else {
    print " evaluates to false.\n";
}

