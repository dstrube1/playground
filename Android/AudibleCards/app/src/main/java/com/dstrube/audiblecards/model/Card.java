package com.dstrube.audiblecards.model;

import com.dstrube.audiblecards.exceptions.InvalidCardOperationException;

/**
 * This is the class for a card object
 * @author David Strube
 *
 */public class Card {
	 
	 //Rank stuff
	private String rank;
	public static final String RANK_ACE = "Ace";
	public static final String RANK_2 = "2";
	public static final String RANK_3 = "3";
	public static final String RANK_4 = "4";
	public static final String RANK_5 = "5";
	public static final String RANK_6 = "6";
	public static final String RANK_7 = "7";
	public static final String RANK_8 = "8";
	public static final String RANK_9 = "9";
	public static final String RANK_10 = "10";
	public static final String RANK_JACK = "Jack";
	public static final String RANK_QUEEN = "Queen";
	public static final String RANK_KING = "King";
	public static final String[] rankOptions = { RANK_ACE, RANK_2, RANK_3,
			RANK_4, RANK_5, RANK_6, RANK_7, RANK_8, RANK_9, RANK_10, RANK_JACK,
			RANK_QUEEN, RANK_KING };

	//Suit stuff
	private String suit;
	public static final String SUIT_SPADE = "Spades";
	public static final String SUIT_HEART = "Hearts";
	public static final String SUIT_DIAMOND = "Diamonds";
	public static final String SUIT_CLUB = "Clubs";
	public static final String[] suitOptions = { SUIT_SPADE, SUIT_HEART,
			SUIT_DIAMOND, SUIT_CLUB };

	/**
	 * Empty constructor
	 */
	public Card() {
		rank = null;
		suit = null;
	}

	/**
	 * Parameterized constructor
	 * @param rank
	 * @param suit
	 * @throws InvalidCardOperationException
	 */
	public Card(String rank, String suit) throws InvalidCardOperationException {
		setRank(rank);
		setSuit(suit);
	}

	/**
	 * Get the rank of a card
	 * @return rank
	 */
	public String getRank() {
		return rank;
	}

	/**
	 * Set the rank of a card
	 * @param rank
	 * @throws InvalidCardOperationException
	 */
	public void setRank(String rank) throws InvalidCardOperationException {
		for (String option : rankOptions) {
			if (option.equals(rank)) {
				this.rank = rank;
				return;
			}
		}
		throw new InvalidCardOperationException("Invalid rank: " + rank);
	}

	/**
	 * Get the suit of a card
	 * @return suit
	 */
	public String getSuit() {
		return suit;
	}

	/**
	 * Set the suit of a card
	 * @param suit
	 * @throws InvalidCardOperationException
	 */
	public void setSuit(String suit) throws InvalidCardOperationException{
		for (String option : suitOptions) {
			if (option.equals(suit)) {
				this.suit = suit;
				return;
			}
		}
		throw new InvalidCardOperationException("Invalid suit: " + suit);
	}

}
