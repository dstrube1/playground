#! /bin/bash

###################################################################
# This script shows an example of using regex in bash
#
# see also: http://tille.garrels.be/training/bash/ch04.html
# and http://tldp.org/LDP/abs/html/string-manipulation.html
###################################################################

for i in *.pdf
do
#echo "before="$i
#Ex: 2006-07minutes.pdf
#    012345678901234567
j=${i:0:7}
h=${j:0:4}
g=${j:5:2}
#^year and month- same as with regex1
k=${i:8:6}
L=${i:14}
#echo "mv "$i "M"$k"_"$h"_"$g""$L
mv $i "M"$k"_"$h"_"$g""$L
# after:Minutes_2006_07.pdf
done