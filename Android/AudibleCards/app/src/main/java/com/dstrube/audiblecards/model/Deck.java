package com.dstrube.audiblecards.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

import com.dstrube.audiblecards.exceptions.InvalidDeckOperationException;

/**
 * This is the class for a deck object.
 * This class should use a singleton pattern IFF we want to ensure there is only one deck object at a time.
 * @author David Strube
 *
 */
public class Deck {

	private ArrayList<Card> cards;
	private final int MAX_DECK_SIZE = 52;

	/**
	 * Empty constructor
	 */
	public Deck() {
		this.cards = new ArrayList<>();
	}

	/**
	 * Parameterized constructor
	 * @param cards
	 * @throws InvalidDeckOperationException
	 */
	public Deck(ArrayList<Card> cards) throws InvalidDeckOperationException {
		this.cards = new ArrayList<>();
		//We could just set it and forget it, but I want to make sure all the cards getting added are valid
		for (Card input : cards) {
			addCard(input);
		}
	}

	/**
	 * Check for a null or empty deck
	 * @throws InvalidDeckOperationException
	 */
	private void checkForNullOrEmpty() throws InvalidDeckOperationException {
		if (cards == null) {
			throw new InvalidDeckOperationException("Null deck");
		}
		if (cards.size() == 0) {
			throw new InvalidDeckOperationException("Empty deck");
		}

	}

	/**
	 * Get the deck size
	 * @return size
	 * @throws InvalidDeckOperationException
	 */
	public int getSize() throws InvalidDeckOperationException {

		if (cards == null) {
			throw new InvalidDeckOperationException("Null deck");
		}

		return cards.size();
	}

	/**
	 * Add a card to the deck
	 * @param input
	 * @throws InvalidDeckOperationException
	 */
	public void addCard(Card input) throws InvalidDeckOperationException {
		if (cards == null) {
			cards = new ArrayList<>();
		}

		if (getSize() >= MAX_DECK_SIZE) {
			throw new InvalidDeckOperationException("Too many cards");
		}

		for (Card card : cards) {
			if (card.getRank().equals(input.getRank())
					&& card.getSuit().equals(input.getSuit())) {
				throw new InvalidDeckOperationException(
						"This card already is in the deck: " + input.getRank()
								+ " of " + input.getSuit());
			}
		}
		cards.add(input);
	}

	/**
	 * Draw a given card from the deck
	 * @param card
	 * @return card
	 * @throws InvalidDeckOperationException
	 */
	public Card drawCard(Card card) throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		if (!cards.contains(card)) {
			throw new InvalidDeckOperationException(
					"Card does not exist in the deck");
		}
		cards.remove(card);
		return card;
	}

	/**
	 * Draw a card from the top of the deck
	 * @return card
	 * @throws InvalidDeckOperationException
	 */
	public Card drawTopCard() throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		Card card = cards.get(0);
		cards.remove(0);
		return card;
	}

	/**
	 * Draw a card from the bottom of the deck
	 * @return
	 * @throws InvalidDeckOperationException
	 */
	public Card drawBottomCard() throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		Card card = cards.get(cards.size() - 1);
		cards.remove(cards.size() - 1);
		return card;
	}

	/**
	 * Draw a random card
	 * @return card
	 * @throws InvalidDeckOperationException
	 */
	public Card drawRandomCard() throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		Random rand = new Random();

		int n = rand.nextInt(getSize());

		Card card = cards.get(n);
		cards.remove(n);
		return card;
	}

	/**
	 * Shuffle the deck
	 * @throws InvalidDeckOperationException
	 */
	public void shuffle() throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		long seed = System.nanoTime();
		Collections.shuffle(cards, new Random(seed));
	}

	/**
	 * Get all the cards in the deck
	 * @return ArrayList of cards
	 * @throws InvalidDeckOperationException
	 */
	public ArrayList<Card> getCards() throws InvalidDeckOperationException {

		checkForNullOrEmpty();

		return cards;
	}

}
