package com.dstrube.jfugue;

/*
commands to compile and run:

from mac ~/java:
compile:
javac -cp bin:bin/jfugue-5.0.9.jar -d bin com/dstrube/jfugue/DrWho.java
run:
java -cp bin:bin/jfugue-5.0.9.jar com.dstrube.jfugue.DrWho

*/

import org.jfugue.player.Player;

import java.util.Scanner;

public class DrWho {

/*
Treble:
FACE
EGBDF - every good boy deserves fudge

Bass:
ACEG - all cows eat grass
GBDFA - good boys do fine always

whole w 
half h 
quarter q 
eighth i 
sixteenth s 
thirty-second t 
sixty-fourth x 
one-twenty-eighth o

*/
	//Page 1, Measures 1-5
	private static final String P1M1_5 = "C D E F G A B";//D3q E3i E3q D3i E3i E3i E3i D3i E3i E3i E3i";
	public static void main(String[] args) {
		Instruments();
	}
	
	//1- Figure out what instruments to use
	private static void Instruments(){
	}
}