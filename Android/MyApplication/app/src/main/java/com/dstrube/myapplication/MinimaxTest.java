package com.dstrube.myapplication;

import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;

/*
* Incomplete
*
* Ruby:
* http://neverstopbuilding.com/minimax
* http://www.flyingmachinestudios.com/programming/minimax/
*
* Java:
* https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaGame_TicTacToe_AI.html
* http://www.codebytes.in/2014/08/minimax-algorithm-tic-tac-toe-ai-in.html
* http://www.codebytes.in/2014/11/alpha-beta-pruning-minimax-algorithm.html
* */

public class MinimaxTest {

    private class Board{
        private final String TAG = Board.class.getSimpleName();

        private HashMap<String, Player> board;
        private int[] rows;
        private int[] columns;

        public Board(){
            rows = new int[3];
            columns = new int[3];

            board = new HashMap<>(rows.length * columns.length);

            for (int i = 0; i< rows.length; i++){
                for (int j = 0; j < columns.length; j++){
                    board.put(""+i+""+j,null);
                }
            }

        }

        public Board(HashMap<String, Player> board){
            this.board = board;
        }

        public HashMap getBoard(){
            return board;
        }

        public void setBoard(final int row, final int column, final Player player){
            final String key = ""+row + "" + column;
            if (board.containsKey(key)){
                board.put(key, player);
            } else {
                Log.e(TAG, "Board does not contain " + key);
            }
        }

        public boolean isGameOver(){
            for (int i = 0; i< rows.length; i++){
                for (int j = 0; j < columns.length; j++){
                    if (board.get(""+i+""+j) == null){
                        return false;
                    }
                }
            }
            return true;
        }

        public boolean isWinner(final Player player){

            if (board.get("00").equals(player)
                    && board.get("01").equals(player)
                    && board.get("02").equals(player)) {
                /*
                row 0:

                _X_|_X_|_X_
                ___|___|___
                   |   |
                 */
                return true;
            } else if (board.get("10").equals(player)
                    && board.get("11").equals(player)
                    && board.get("12").equals(player)) {
                /*
                row 1:

                ___|___|___
                _X_|_X_|_X_
                   |   |
                 */
                return true;
            } else if (board.get("20").equals(player)
                    && board.get("21").equals(player)
                    && board.get("22").equals(player)) {
                /*
                row 2:

                ___|___|___
                ___|___|___
                 X | X | X
                 */
                return true;
            } else if (board.get("00").equals(player)
                    && board.get("10").equals(player)
                    && board.get("20").equals(player)) {
                /*
                column 0:

                _X_|___|___
                _X_|___|___
                 X |   |
                 */
                return true;
            } else if (board.get("01").equals(player)
                    && board.get("11").equals(player)
                    && board.get("21").equals(player)) {
                /*
                column 1:

                ___|_X_|___
                ___|_X_|___
                   | X |
                 */
                return true;
            } else if (board.get("02").equals(player)
                    && board.get("12").equals(player)
                    && board.get("22").equals(player)) {
                /*
                column 2:

                ___|___|_X_
                ___|___|_X_
                   |   | X
                 */
                return true;
            } else if (board.get("00").equals(player)
                    && board.get("11").equals(player)
                    && board.get("22").equals(player)) {
                /*
                diagonal 1:

                _X_|___|___
                ___|_X_|___
                   |   | X
                 */
                return true;
            } else if (board.get("02").equals(player)
                    && board.get("11").equals(player)
                    && board.get("20").equals(player)) {
                /*
                diagonal 2:

                ___|___|_X_
                ___|_X_|___
                 X |   |
                 */
                return true;
            }
            return false;
        }

        public ArrayList<String> getAvailableMoves(){
            ArrayList<String> moves = new ArrayList<>();
            for (int i = 0; i< rows.length; i++){
                for (int j = 0; j < columns.length; j++){
                    if (board.get(""+i+""+j) == null){
                        moves.add(""+i+""+j);
                    }
                }
            }
            return moves;
        }

    }

    private class Player{
        private final String TAG = Player.class.getSimpleName();
        private String name;
        private final String PLAYER_X = "X";
        private final String PLAYER_O = "O";

        public Player(final String name){
            if (! name.equals(PLAYER_O) && !name.equals(PLAYER_X)){
                Log.e(TAG,"Invalid player name: " + name);
            }
            this.name = name;
        }

        public String getName(){
            return name;
        }
    }
}
