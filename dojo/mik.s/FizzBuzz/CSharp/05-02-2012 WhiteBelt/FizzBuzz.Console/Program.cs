namespace FizzBuzz.Console {
    public class Program {
        public static void Main(string[] args) {
            var printer = new Printer(new LinePrinter());

            foreach (var line in printer.PrintLines(100)) {
                System.Console.Out.WriteLine(line);
            }

            System.Console.ReadLine();
        }
    }
}
