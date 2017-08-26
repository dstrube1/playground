package com.dstrube.mvc.calculator;

//import javax.swing.*;

//from:
// http://leepoint.net/notes-java/GUI/structure/40mvc.html 
//see also:
// http://javadude.com/articles/vaddmvc1/mvc1.htm

public class Calculator {
	
	public static void main(String[] args) {
		CalcModel model = new CalcModel();
		CalcView view = new CalcView(model);
		//local variable not used, but constructor call is necessary 
		CalcController controller = new CalcController(model, view);
		
		view.setVisible(true);
	}

}
