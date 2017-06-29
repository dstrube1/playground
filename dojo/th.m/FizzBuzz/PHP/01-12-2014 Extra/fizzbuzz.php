<?php
/**
* FizzBuzz Kata
* Thorne Melcher
* 01/12/2014
*
* I haven't done this in PHP yet, so why not? And I'll have fun with tertiary
* logic to keep the line count down!
*/
for($i=1; $i<=100; $i++)
{
  $output = ($i%3==0 ? "Fizz" : "") . ($i%5==0 ? "Buzz" : "");
  if($output == "") $output = $i;
  echo $output . "<br />";
}