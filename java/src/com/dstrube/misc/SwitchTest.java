package com.dstrube;

public class SwitchTest {

	public static void main(String[] args) {
		int i = 100;
		
		switch (i){
		case 1:
			System.out.println("1");
			break;
		case 2:
			System.out.println("2");
			break;
		default :
			System.out.println("other: "+ i);
			break;
		}

	}

}
