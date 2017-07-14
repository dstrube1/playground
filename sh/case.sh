 #! /bin/bash

echo "black or white?"
read choice

case $choice in
  "black")
    echo "dark"
    ;;
  "white")
    echo "light"
    ;;
  *)
    echo "Please choose either black or white"
    ;;
esac 
