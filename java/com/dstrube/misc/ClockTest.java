package com.dstrube;

import java.util.ArrayList;

public class ClockTest {

	public static void main(String[] args) {
		ArrayList<String> angles = new ArrayList<String>();
		
		int hour = 18;//6=180; 7=210; 1=30
		int minute=0;
		System.out.println(hour + ":" + (minute > 9 ? "" : "0") + minute);
		angles = getAngles(hour,minute);
		
		for (int k=0;k<angles.size(); k++){
			System.out.println("angles["+k+"]: "+angles.get(k));
		}
	}
//	public static int[] angles(int hours, int minutes){
//		int[] i = new int[9];
//		return i;
//	}
	public static ArrayList<String> getAngles(int hour, int minute){
		if (hour < 0 || hour > 23){
			System.out.println("Invalid value: hour: "+hour);
			return null;
		}
		if (minute <0 || minute > 59){
			System.out.println("Invalid value: minute: " + minute);
			return null;
		}
		
		float minFrac = (float) minute / 60;
//		System.out.println("minFrac="+minFrac );
		
		float minAngle = minFrac * 360;
//		System.out.println("minAngle="+minAngle);
		
		hour %= 12;
		
		float hourFrac = (float) hour / 12;
//		System.out.println("hourFrac ="+hourFrac );
		float hourAngle = hourFrac * 360;
		//+ increment from minutes?
		hourAngle += minute / 2;
		
		ArrayList<String> angles = new ArrayList<String>();
		angles.add(0, "hour angle = "+Float.toString(hourAngle));
		angles.add(1, "minute angle = "+Float.toString(minAngle));
		
		return angles;
	}

}
