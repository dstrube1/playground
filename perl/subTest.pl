#!/usr/bin/perl
#http://www.perltutorial.org/perl-subroutine-function.aspx

sub print_message{
    print "Perl subroutine tutorial. This subroutine shows how to call a sub.\n";
}
sub print_list{
  print "@_\n";
}

sub max{
  if($_[0] > $_[1]){
     $_[0];
  }
  else{
     $_[1];
  }
}

sub cal_sum{
  print "Next, using last-line return:\nsum of two numbers\n(think of this as a debug line)\n";
  $_[0] + $_[1];
}

sub get_list{
  return 5..10;
}

#MAIN:

&print_message;

#print: this is Perl subroutine tutorial
&print_list("this","is","a","Perl","subroutine","showing how to call a sub with a list of params, using \@_");


$m = max(10,20);
$m2 = max(50,30);
print "Next, using \$_ param variables:\n";
print "max of 10,20: $m\n";
print "max of 50,30: $m2\n";

$result = &cal_sum(10,20); # result is 30
print $result . "\n";

@list = &get_list;
print "@list\n"; #5 6 7 8 9 10