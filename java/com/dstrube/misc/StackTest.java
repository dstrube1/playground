package com.dstrube;

import java.util.ArrayList;

public class StackTest {

	static int i=0;
	public static void main(String[] args) {
		try{
			try{
				i++;
				a();
			}catch (Exception e){
				System.out.print("\nexception caught in main; levels deep = " + i);
			}
		}catch (Error er){
			System.out.print("\nerror caught in main; levels deep = " + i);
		}
		
		c();
	}

	private static void a(){
		try{
			try{
				System.out.print("a");
				i++;
				b();
			}catch (Exception e){
				System.out.print("\nexception caught in a; levels deep = " + i);
			}
		}catch (Error er){
			System.out.print("\nerror caught in a; levels deep = " + i);
		}
	}
	private static void b(){
		try{
			try{
				System.out.print("b");
				i++;
				a();
			}catch (Exception e){
				System.out.print("\nexception caught in b; levels deep = " + i);
			}
		}catch (Error er){
			System.out.print("\nerror caught in b; levels deep = " + i);
		}
	}
	
	private static void c(){
		i=0;
		ArrayList d = new ArrayList();
		try{
			try{
				while (true){
					System.out.print("c");
					d.add("c");
					i++;
				}
			}catch (Exception e){
				System.out.print("\nexception caught in c; levels deep = " + i);
			}
		}catch (Error er){
			System.out.print("\nerror caught in c; levels deep = " + i);
		}
	}
}
