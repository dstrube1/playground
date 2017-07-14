#! /bin/bash

###################################################################
# This script shows an example of using regex in bash
#
# see also: http://tille.garrels.be/training/bash/ch04.html
# and http://tldp.org/LDP/abs/html/string-manipulation.html
###################################################################

for i in *.pdf
do
echo "before="$i
#Ex: 2008-09Agenda.pdf
#    01234567890123456
j=${i:0:7}
h=${j:0:4}
g=${j:5:2}
k=${i:7:6}
L=${i:13}
mv $i $k"_"$h"_"$g""$L
# after:Agenda_2008_09.pdf
done