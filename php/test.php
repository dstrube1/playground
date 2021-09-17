<?php
/*

//https://www.w3schools.com/php/php_ref_overview.asp

$arr=array("1","2","3"); #indexed array
$arrlength=count($arr);

for($x=0;$x<$arrlength;$x++)
  {
  echo $arr[$x];
  echo "\n";
  }

$assoc = array(1=>"a", 2=>"b", 3=>"c"); #associative array
foreach($assoc as $x=>$x_value)
  {
  echo "Key=" . $x . ", Value=" . $x_value;
  echo "\n";
  }
  
$twoD=array
  (
  array("x",100,96),
  array("y",60,59),
  array("z",110,100)
  );
for($x=0;$x<count($twoD);$x++)
  {
	  for($y = 0; $y<count($twoD[0]);$y++){
  		echo $twoD[$x][$y];
	    echo "\n";
  	}
  
  }
  echo "int max: ".PHP_INT_MAX."\n"; //9223372036854775807
  echo "int min: ".PHP_INT_MIN."\n"; //-9223372036854775808
  echo "float max: ".PHP_FLOAT_MAX."\n"; //1.7976931348623E+308
  echo "float min: ".PHP_FLOAT_MIN."\n"; //2.2250738585072E-308
  echo "random: " . rand() ."\n";
  
  define("blah","I'm a const. Don't give me the same name as a keyword, like const\n");
  echo blah;
  //see also: https://www.w3schools.com/php/php_oop_constants.asp
  */
  
 function my_func1($param=2){
  	echo "Hello from my_func1: " . $param."\n";
  }

my_func();
my_func1('x');

  function my_func(){
  	echo "Hello from my_func. I can be defined before or after my call.\n";
  }
  
  function my_func2():string{
  	return "my_func2: This one has a return\n";
  }
  
  echo my_func2();

function add_five(&$value) {//passing by reference
  $value += 5;
}

$num = 2;
add_five($num);
echo $num."\n";

//Cant' have the $ in front of the string literal representation of these superglobals:
echo "_SERVER['PHP_SELF']: " . $_SERVER['PHP_SELF'] . "\n";
//more here: https://www.w3schools.com/php/php_superglobals_server.asp

date_default_timezone_set("America/New_York");
echo date('Y-m-d-H-i-s')."\n";

require 'required.php';
required();

//try catch: https://www.w3schools.com/php/php_exceptions.asp
//files: https://www.w3schools.com/php/php_file.asp
//json: https://www.w3schools.com/php/php_json.asp
//lambdas: https://phpbuilder.com/lambdas-in-php/
?>