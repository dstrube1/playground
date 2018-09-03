package com.dstrube.audiblecards.controller;

import java.util.ArrayList;

import com.dstrube.audiblecards.R;
import com.dstrube.audiblecards.exceptions.InvalidCardOperationException;
import com.dstrube.audiblecards.exceptions.InvalidDeckOperationException;
import com.dstrube.audiblecards.model.Card;
import com.dstrube.audiblecards.model.Deck;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;

/**
 * This is the main controller class (and the main view class).
 * @author David Strube
 *
 */
public class MainActivity extends Activity {

	private EditText textView;
	private Deck deck;

	/**
	 * Create the activity
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (savedInstanceState == null) {
			getFragmentManager().beginTransaction()
					.add(R.id.container, new PlaceholderFragment()).commit();
		}
	}

	/**
	 * Set up the textView and the deck objects
	 */
	@Override
	protected void onResume() {
		super.onResume();

		textView = findViewById(R.id.editText1);
		
		deck = new Deck();
	}

	/**
	 * Update the textView with the new state of the deck. 
	 * Called only by other methods in this class.
	 */
	private void updateTextView() {
		if (deck==null){
			Toast.makeText(getApplicationContext(), "Null deck",
					Toast.LENGTH_LONG).show();
			return;
		}
		try {
			String text = "";

			if (deck.getSize() <= 0) {
				text = "Empty deck";
			} else {
				ArrayList<Card> cards = deck.getCards();
				for (Card card : cards) {
					text += card.getRank() + " of " + card.getSuit() + "\n";
				}
			}
			textView.setText(text);
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * This is called by the New Empty Deck button
	 * @param v
	 */
	public void createEmptyDeck(View v) {
		deck = new Deck();
		updateTextView();
	}

	/**
	 * This is called by the New Full Deck button
	 * @param v
	 */
	public void createFullDeck(View v) {
		try {
			ArrayList<Card> cards = new ArrayList<Card>();
			for (String rank : Card.rankOptions) {
				for (String suit : Card.suitOptions) {
					Card card = new Card(rank, suit);
					cards.add(card);
				}
			}
			deck = new Deck(cards);
			updateTextView();
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		} catch (InvalidCardOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * This is called by the Shuffle Deck button
	 * @param v
	 */
	public void shuffleDeck(View v) {
		if (deck==null){
			Toast.makeText(getApplicationContext(), "Null deck",
					Toast.LENGTH_LONG).show();
			return;
		}
		try {
			deck.shuffle();
			updateTextView();
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * This is called by the Draw Top button
	 * @param v
	 */
	public void drawTop(View v) {
		if (deck==null){
			Toast.makeText(getApplicationContext(), "Null deck",
					Toast.LENGTH_LONG).show();
			return;
		}
		try {
			Card card = deck.drawTopCard();
			Toast.makeText(getApplicationContext(),
					card.getRank() + " of " + card.getSuit(),
					Toast.LENGTH_SHORT).show();
			updateTextView();
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * This is called by the Draw Bottom button
	 * @param v
	 */
	public void drawBottom(View v) {
		if (deck==null){
			Toast.makeText(getApplicationContext(), "Null deck",
					Toast.LENGTH_LONG).show();
			return;
		}
		try {
			Card card = deck.drawBottomCard();
			Toast.makeText(getApplicationContext(),
					card.getRank() + " of " + card.getSuit(),
					Toast.LENGTH_SHORT).show();
			updateTextView();
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * This is called by the Draw Random button
	 * @param v
	 */
	public void drawRandom(View v) {
		if (deck==null){
			Toast.makeText(getApplicationContext(), "Null deck",
					Toast.LENGTH_LONG).show();
			return;
		}
		try {
			Card card = deck.drawRandomCard();
			Toast.makeText(getApplicationContext(),
					card.getRank() + " of " + card.getSuit(),
					Toast.LENGTH_SHORT).show();
			updateTextView();
		} catch (InvalidDeckOperationException e) {
			Toast.makeText(getApplicationContext(), e.getMessage(),
					Toast.LENGTH_LONG).show();
		}
	}

	/**
	 * A placeholder fragment containing a simple view.
	 */
	public static class PlaceholderFragment extends Fragment {

		public PlaceholderFragment() {
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			View rootView = inflater.inflate(R.layout.fragment_main, container,
					false);
			return rootView;
		}
	}

}
