/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package fizzbuzz;

/**
 *
 * @author T
 */
public class FizzBuzz {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        for(int i=1; i<=100; i++) {
            System.out.println("" + ((i%5==0 || i%3==0) ? ((i%3==0?"Fizz":"")+(i%5==0?"Buzz":"")) : i));
        }
    }
    
}
