function FizzBuzz(max = 100) {
    for (var i = 1; i <= max; i++) {
        var out = '';
        if (i % 3 == 0) {
            out = 'Fizz';
        }
        if (i % 5 == 0) {
            out += 'Buzz';
        }
        console.log(out || i);
    }
}