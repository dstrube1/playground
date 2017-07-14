#! /bin/bash

for n in 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210
#seq is a command in unix, not mac bsd: `seq 0 10`
do
  echo "ping -c 2 -t 2 10.82.0."$n
  ping -c 2 -t 2 10.82.0.$n
done
