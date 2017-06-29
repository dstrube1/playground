// Initialization
numerals = [
    { // Thousands
        'value': 1000,
        'place': 'm',
        'half': 'd'
    },
    { // Hundreds
        'value': 100,
        'place': 'c',
        'half': 'l'
    },
    { // Tens
        'value': 10,
        'place': 'x',
        'half': 'v'
    },
    { // Ones
        'value': 1,
        'place': 'i'
    }
];

ExecuteTests();

// The implementation
function Romanize(input) {
    var remainder = input;
    var out = '';

    for (var i = 0; i < numerals.length; i++) {
        if (remainder >= numerals[i].value) {
            var placeNum = Math.floor(remainder / numerals[i].value);
            out += stringFill(numerals[i].place, placeNum);
            remainder -= placeNum * numerals[i].value;
        }

        if (i == (numerals.length - 1))
            break; // Nothing below applies to 1s

        if (remainder >= numerals[i].value - numerals[i + 1].value) {
            out += numerals[i + 1].place + numerals[i].place;
            remainder -= numerals[i].value - numerals[i + 1].value;
        }

        if (remainder >= numerals[i].value / 2) {
            out += numerals[i].half;
            remainder -= numerals[i].value / 2;
        }

        if (remainder >= (numerals[i].value / 2) - numerals[i + 1].value) {
            out += numerals[i + 1].place + numerals[i].half;
            remainder -= (numerals[i].value / 2) - numerals[i + 1].value;
        }
    }

    return out.toUpperCase();
};

function ExecuteTests() {
    // Specific tests
    randomTests = 5;
    tests = [
        1, 3, 4, 5,
        10, 11, 14, 15,
        100, 104, 105, 109, 110, 111, 123,
        1000, 1049, 1050, 1099, 1100, 1234, 1400, 1500, 1900, 1999,
        2000, 2001, 2013, 4321
    ];

    // Random tests
    for (i = 0; i < randomTests; i++) {
        tests.push(getRandomInt(1, 9999));
    }

    // Execute tests
    for (i = 0; i < tests.length; i++) {
        console.log("Numeral for " + tests[i] + " is '" + Romanize(tests[i]) + "'.");
    }
}

// Basic string repeater, taken from http://www.webreference.com/programming/javascript/jkm3/3.html
function stringFill(str, count) {
    var s = '';
    for (;;) {
        if (count & 1)
            s += str;

        count >>= 1;

        if (count)
            str += str;
        else
            break;
    }
    return s;
};

// Random int in range helper, taken from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
};