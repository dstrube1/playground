using System;
using System.Collections.Generic;

namespace FizzBuzz {
    public class Printer {
        private ILinePrinter _linePrinter;

        public Printer(ILinePrinter linePrinter) {
            if (linePrinter == null) {
                throw new ArgumentNullException("linePrinter");
            }

            _linePrinter = linePrinter;
        }

        public IEnumerable<string> PrintLines(uint numberOfLines) {
            if (numberOfLines == 0) {
                throw new ArgumentException();
            }

            for (uint line=1; line<=numberOfLines; line++) {
                yield return _linePrinter.PrintLine(line);
            }
        }
    }
}
