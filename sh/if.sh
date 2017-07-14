 #! /bin/bash

echo "black or white?"
read choice

if [ $choice == "black" ]
then
  echo "dark"
else
  echo "light"
fi
