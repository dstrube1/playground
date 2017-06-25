package com.dstrube.mvc.calculator;

import java.math.BigInteger;

public class CalcModel {
	//... Constants
	private static final String INITIAL_VALUE = "1";
	
	//... Member variable defining state of calculator.
    private BigInteger m_total;  // The total current value state.

	public void setValue(String value) {
		m_total = new BigInteger(value);
	}

	public String getValue() {
		return m_total.toString();
	}

	public void multiplyBy(String operand) {
		m_total = m_total.multiply(new BigInteger(operand));
		
	}

	public void reset() {
		m_total = new BigInteger(INITIAL_VALUE);
		
	}

}
