#!/usr/bin/perl
use strict;
use warnings;

# BEGIN { print "@INC\n";}
#Path::Class doesn't come standard; had to cpan Path::Class from command prompt; the rest was black magic witchcraft, and I thank jeebus for that
#after that, starting here:
# http://learn.perl.org/examples/read_write_file.html

use Path::Class;
use autodie; # die if problem reading or writing a file

my $dir = dir("/tmp"); # /tmp

my $file = $dir->file("file.txt");

# Read in the entire contents of a file
my $content = $file->slurp();

# openr() returns an IO::File object to read from
my $file_handle = $file->openr();

# Read in line at a time
while( my $line = $file_handle->getline() ) {
        print $line;
}

print "\n\nNow printing content: \n$content";