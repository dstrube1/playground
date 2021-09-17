using System;
using System.Collections.Generic;
using System.Text;
using RomanNumerals.Interfaces;

namespace RomanNumerals {
    public class Scribe : IScribe {
        struct Pair {
            public uint Arabic;
            public string Roman;
        }

        private static readonly List<Pair> _pairs =
            new List<Pair> {
                new Pair { Arabic = 1000, Roman = "M" },
                new Pair { Arabic = 900, Roman = "CM" },
                new Pair { Arabic = 500, Roman = "D" },
                new Pair { Arabic = 400, Roman = "CD" },
                new Pair { Arabic = 100, Roman = "C" },
                new Pair { Arabic = 90, Roman = "XC" },
                new Pair { Arabic = 50, Roman = "L" },
                new Pair { Arabic = 40, Roman = "XL" },
                new Pair { Arabic = 10, Roman = "X" },
                new Pair { Arabic = 9, Roman = "IX" },
                new Pair { Arabic = 5, Roman = "V" },
                new Pair { Arabic = 4, Roman = "IV" },
                new Pair { Arabic = 1, Roman = "I" },
            };

        public string ToRoman(uint number) {
            if (number == 0) {
                throw new ArgumentException("Number must be greater than zero.");
            }

            var sb = new StringBuilder();

            foreach (var pair in _pairs) {
                while (number >= pair.Arabic) {
                    sb.Append(pair.Roman);
                    number -= pair.Arabic;
                }
            }

            return sb.ToString();
        }

        public uint ToArabic(string numerals) {
            if (string.IsNullOrEmpty(numerals)) {
                throw new ArgumentException();
            }

            numerals = numerals.Trim().ToUpper();
            uint number = 0;

            while (numerals.Length > 0) {
                uint toAdd;
                numerals = GetIntegerComponent(numerals, out toAdd);
                number += toAdd;
            }

            return number;
        }

        private string GetIntegerComponent(string numerals, out uint toAdd) {
            foreach (var pair in _pairs) {
                if (numerals.StartsWith(pair.Roman)) {
                    toAdd = pair.Arabic;
                    return numerals.Substring(pair.Roman.Length);
                }
            }

            throw new InvalidOperationException();
        }
    }
}
