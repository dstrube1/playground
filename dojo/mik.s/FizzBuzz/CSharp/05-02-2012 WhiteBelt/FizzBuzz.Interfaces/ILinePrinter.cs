namespace FizzBuzz {
    public interface ILinePrinter {
        /// <summary>
        /// Prints a value corresponding to the line number.
        /// </summary>
        /// <param name="lineNumber">1-based, not 0-based.</param>
        /// <exception cref="System.ArgumentException">Thrown if lineNumber is zero.</exception>
        /// <returns>A value corresponding to the line number.</returns>
        string PrintLine(uint lineNumber);
    }
}
