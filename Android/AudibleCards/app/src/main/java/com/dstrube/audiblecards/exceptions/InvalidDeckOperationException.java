package com.dstrube.audiblecards.exceptions;

/**
 * Custom exception class for invalid deck operations
 * @author David Strube
 *
 */public class InvalidDeckOperationException extends Exception {
	public InvalidDeckOperationException(String string) {
		super(string);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
}
