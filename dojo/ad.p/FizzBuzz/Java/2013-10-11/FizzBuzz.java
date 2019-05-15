package fizzbuzz;
import java.util.*;

public class FizzBuzz {
    public static void main(String[] args) {
        List<FizzBuzzReplacement> replacements = new ArrayList<>(2);
        // Doesn't have to be 3=Fizz, 5=Buzz, pick your poison...
        replacements.add(new FizzBuzzReplacement(3, "Dev"));
        replacements.add(new FizzBuzzReplacement(5, "Ops"));
        FizzBuzz fb = new FizzBuzz(100, replacements);
        fb.go(true);        // Set to false for stage1 (divisible only), true for stage2 (divisible || contains)
    }

    private int max;
    private SortedSet<FizzBuzzReplacement> replacements;

    public FizzBuzz(int max, Collection<FizzBuzzReplacement> replacements) {
        this.max = max;
        this.replacements = new TreeSet<>(replacements);
    }

    public void go() {
        go(false);
    }

    public void go(bool stage2) {
        for (int i = 1; i <= max; i++) {
            String out = "";
            for (FizzBuzzReplacement fbr : replacements) {
                if (i % fbr.number == 0
                    || (stage2 && String.valueOf(i).contains(String.valueOf(fbr.number)))) {
                    out += fbr.replacement;
                }
            }
            if (out.isEmpty()) {
                out = String.valueOf(i);
            }
            System.out.println(out);
        }
    }

    public static class FizzBuzzReplacement implements Comparable<FizzBuzzReplacement> {
        private int number;
        private String replacement;

        public FizzBuzzReplacement(int number, String replacement) {
            this.number = number;
            this.replacement = replacement;
        }

        public int compareTo(FizzBuzzReplacement that) {
            return this.number - that.number;
        }
    }
}
