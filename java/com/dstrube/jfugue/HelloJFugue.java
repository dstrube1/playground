package com.dstrube.jfugue;

/*
commands to compile and run:

from mac ~/java:
compile:
javac -cp bin:bin/jfugue-5.0.9.jar -d bin com/dstrube/jfugue/HelloJFugue.java
run:
java -cp bin:bin/jfugue-5.0.9.jar com.dstrube.jfugue.HelloJFugue
*/

import org.jfugue.player.Player;
import org.jfugue.pattern.Pattern;
import org.jfugue.theory.Chord;
import org.jfugue.theory.ChordProgression;
import org.jfugue.theory.Note;
import org.jfugue.rhythm.Rhythm;
import org.jfugue.midi.MidiFileManager;
import org.jfugue.realtime.RealtimePlayer;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

import javax.sound.midi.InvalidMidiDataException;
import javax.sound.midi.MidiUnavailableException;


//http://www.jfugue.org/doc/index.html

public class HelloJFugue {
	
	private static final String CtoB = "C D E F G A B";
		private static final int sizeOfSames = 22;
		private static final int[][] sames = new int[sizeOfSames][];

	public static void main(String[] args) throws MidiUnavailableException{
//		Player player = new Player();
//	    player.play("C D E F G A B");		
//		player.play("V0 I[Piano] Eq Ch. | Eq Ch. | Dq Eq Dq Cq   V1 I[Flute] Rw | Rw | GmajQQQ CmajQ");
//		MusicStrings();
			PlayUniqueInstruments();
		/*
		try{
			SeeMidi();
		}catch(IOException e0){
			System.out.println("Caught exception: " + e0);
		}catch(InvalidMidiDataException e1){
			System.out.println("Caught exception: " + e1);
		}*/
	}

//////////////////////////////////////////////////////////////////////////////////////	
	//from Examples
	//http://www.jfugue.org/examples.html

	private static void pattern1(){
		Pattern p1 = new Pattern("V0 I[Piano] Eq Ch. | Eq Ch. | Dq Eq Dq Cq");
	    Pattern p2 = new Pattern("V1 I[Flute] Rw     | Rw     | GmajQQQ  CmajQ");
    	Player player = new Player();
	    player.play(p1, p2);
	}
	private static void pattern2(){
		Pattern p1 = new Pattern("Eq Ch. | Eq Ch. | Dq Eq Dq Cq").setVoice(0).setInstrument("Piano");
    	Pattern p2 = new Pattern("Rw     | Rw     | GmajQQQ  CmajQ").setVoice(1).setInstrument("Flute");
	    Player player = new Player();
	    player.play(p1, p2);
    }
    private static void IntroToChordProgressions(){
    	ChordProgression cp = new ChordProgression("I IV V");

	    Chord[] chords = cp.setKey("C").getChords();
    	for (Chord chord : chords) {
	      System.out.print("Chord "+chord+" has these notes: ");
    	  Note[] notes = chord.getNotes();
	      for (Note note : notes) {
    	    System.out.print(note+" ");
	      }
    	  System.out.println();
	    }

    	Player player = new Player();
	    player.play(cp);
    }
    private static void AdvancedChordProgressions(){
	    ChordProgression cp = new ChordProgression("I IV V");

    	Player player = new Player();
	    System.out.println("Adv Chord 1...");
	    player.play(cp.eachChordAs("$0q $1q $2q Rq"));

	    System.out.println("Adv Chord 2...");
    	player.play(cp.allChordsAs("$0q $0q $0q $0q $1q $1q $2q $0q"));

	    System.out.println("Adv Chord 3...");
	    player.play(cp.allChordsAs("$0 $0 $0 $0 $1 $1 $2 $0").eachChordAs("V0 $0s $1s $2s Rs V1 $!q"));
    }
    private static void TwelveBarBlues(){
	    Pattern pattern = new ChordProgression("I IV V")
                .distribute("7%6")
                .allChordsAs("$0 $0 $0 $0 $1 $1 $0 $0 $2 $1 $0 $0")
                .eachChordAs("$0ia100 $1ia80 $2ia80 $3ia80 $4ia100 $3ia80 $2ia80 $1ia80")
                .getPattern()
                .setInstrument("Acoustic_Bass")
                .setTempo(100);
        new Player().play(pattern);
    }
    private static void IntroToRhythms(){
    	Rhythm rhythm = new Rhythm()
    	    .addLayer("O..oO...O..oOO..")
        	.addLayer("..S...S...S...S.")
	        .addLayer("````````````````")
    	    .addLayer("...............+");
	    new Player().play(rhythm.getPattern().repeat(2));
    }
    private static void AdvancedRhythms(){
    	Rhythm rhythm = new Rhythm()
          .addLayer("O..oO...O..oOO..") // This is Layer 0
          .addLayer("..S...S...S...S.")
          .addLayer("````````````````")
          .addLayer("...............+") // This is Layer 3
          .addOneTimeAltLayer(3, 3, "...+...+...+...+") // Replace Layer 3 with this string on the 4th (count from 0) measure
          .setLength(4); // Set the length of the rhythm to 4 measures
        new Player().play(rhythm.getPattern().repeat(2)); // Play 2 instances of the 4-measure-long rhythm
    }
    private static void OneLiner(){
        new Player().play(new ChordProgression("I IV vi V").eachChordAs("$!i $!i Ri $!i"), new Rhythm().addLayer("..X...X...X...XO"));
    }
    private static void SeeMidi()throws IOException, InvalidMidiDataException{
	    final String folder = "com"+ File.separator +"dstrube"+ File.separator +"jfugue"+ File.separator +"midis" + File.separator;
    	final String fileName = "Michael_Jackson_-_Beat_It.mid";
    	//"Movie_Themes_-_Addams_Family.mid";
    	//"Guns_n_Roses_-_Knockin_On_Heaven's_Door.mid";
    	Pattern pattern = MidiFileManager.loadPatternFromMidi(new File(folder + fileName));
    	Player player = new Player();
    	System.out.println("Playing " + fileName);
    	player.play(pattern);
        //System.out.println(pattern);
    }
    private static void RealtimeExample()throws MidiUnavailableException{
    	RealtimePlayer player = new RealtimePlayer();
        Random random = new Random();
        Scanner scanner = new Scanner(System.in);
        boolean quit = false;
        while (quit == false) {
            System.out.print("Enter a '+C' to start a note, "+
              "'-C' to stop a note, 'i' for a random instrument, " +
              "'p' for a pattern, or 'q' to quit: ");
            String entry = scanner.next();
            if (entry.startsWith("+")) {
               player.startNote(new Note(entry.substring(1)));
            }
            else if (entry.startsWith("-")) {
                player.stopNote(new Note(entry.substring(1)));
            }
            else if (entry.equalsIgnoreCase("i")) {
                player.changeInstrument(random.nextInt(128));
            }
            else if (entry.equalsIgnoreCase("p")) {
                player.play(PATTERNS[random.nextInt(PATTERNS.length)]);
            }
            else if (entry.equalsIgnoreCase("q")) {
                quit = true;
            }
        }
        scanner.close();
        player.close();
    }
    private static Pattern[] PATTERNS = new Pattern[]{
    	new Pattern("Cmajq Dmajq Emajq"),
        new Pattern("V0 Ei Gi Di Ci  V1 Gi Ci Fi Ei"),
        new Pattern("V0 Cmajq V1 Gmajq")
    };
    //END from Examples
//////////////////////////////////////////////////////////////////////////////////////	

    private static void MusicStrings(){
    	//taken from chapter 2 of a manual:
    	//https://www.cs.utexas.edu/ftp/novak/cs315/jfugue-chapter2.pdf
    	String[] strings = new String[]{
    //		"C",
    //		"C7h",
    //		"C5maj7w",
    //		"G5h+B5h+C6q_D6q",
    //		"G5q G5q F5q E5q D5h",
    //		"T[Allegro] V0 I0 G6q A5q V1 A5q G6q",
    //		"V0 Cmajw V1 I[Flute] G4q E4q C4q E4q",
    //		"T120 V0 I[Piano] G5q G5q V9 [Hand_Clap]q Rq",

    //Testing octaves:
    		"C0h C1h C2h C3h C4h C5h C6h C7h C8h C9h C10h", //the following don't work if coming after the above
    		"C10h C9h C8h C7h C6h C5h C4h C3h C2h C1h C0h", 
    //		"C7h C6h C5h C4h C3h C2h C1h C0h", 				
    //		"C7h C8h C9h C10h"								
    	};
    	
    	Player player = new Player();
    	for (String string : strings){
    		System.out.println("Playing " + string);
    		player.play(string);
    	}
    }
    private static void PlayAllInstruments(){
		final int[] instruments = new int[128];
		final Player player = new Player();
		for (int i = 0; i < instruments.length; i++){
			instruments[i] = i;
			System.out.println("i = " + i);
			player.play("I" + instruments[i] + " " + CtoB);
		}
    }
    private static void setSames(){
/*
	sound same:
0,1
4,5
6,7
9-14
15-18,20-23
24-28,31
29,30
32-34
35-37
38,39
40-44
48-51
52-54
56-59
61-63
64-67
72-79
80,81,83,84,86,87,89, 93-97,99-101
102,104-107
112,114
113,115-117,124
118,119

*/
		sames[0] = new int[]{0,1};
		sames[1] = new int[]{4,5};
		sames[2] = new int[]{6,7};
		sames[3] = new int[]{9,10,11,12,13,14};
		sames[4] = new int[]{15,16,17,18,20,21,22,23};
		sames[5] = new int[]{24,25,26,27,28,31};
		sames[6] = new int[]{29,30};
		sames[7] = new int[]{32,33,34};
		sames[8] = new int[]{35,36,37};
		sames[9] = new int[]{38,39};
		sames[10] = new int[]{40,41,42,43,44};
		sames[11] = new int[]{48,49,50,51};
		sames[12] = new int[]{52,53,54};
		sames[13] = new int[]{56,57,58,59};
		sames[14] = new int[]{61,62,63};
		sames[15] = new int[]{64,65,66,67};
		sames[16] = new int[]{72,73,74,75,76,77,78,79};
		sames[17] = new int[]{80,81,83,84,86,87,89,93,94,95,96,97,99,100,101};
		sames[18] = new int[]{102,104,105,106,107};
		sames[19] = new int[]{112,114};
		sames[20] = new int[]{113,115,116,117,124};
		sames[21] = new int[]{118,119};
    }
    private static void PlaySameInstruments(){

		final Scanner scanner = new Scanner(System.in);
		setSames();
		
		final Player player = new Player();
		for (int j = 18; j < sizeOfSames; j++){
			int[] same = sames[j];
			System.out.print("Sames at " + j + " : ");
			for (int s : same){
				System.out.print(s + " ");
				player.play("I" + s + " " + CtoB);
			}
			System.out.println("? (y/n)");
			String entry = scanner.next();
			if (entry.startsWith("y")) {
				continue;
			}
			else{
				System.out.println("Breaking at " + j);
				break;
			}
		}
		
		scanner.close();
    }
    private static void PlayUniqueInstruments(){
    	setSames();
    	final int[] instruments = new int[128];
		final Player player = new Player();
		for (int i = 0; i < instruments.length; i++){
			boolean foundInSames = false;
			instruments[i] = i;
			for (int[] same : sames){
				for (int j = 1; j < same.length; j++){
					if (same[j] == i){
						System.out.println("Skipping duplicate sounding " + i + ".");
						foundInSames = true;
						break;
					}
				}
				if (foundInSames){
					break;
				}
			}
			if (foundInSames){
				continue;
			}
			else{
				System.out.println("i = " + i);
				player.play("I" + instruments[i] + " " + CtoB);
			}
		}

    }
    private static void ChordStuff(){
    	//TODO: 
		//https://www.youtube.com/watch?v=62tIvfP9A2w&t=358
    }
    private static void XXXXXXXXXXXXXX(){
    }
}
