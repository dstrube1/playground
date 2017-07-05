#lang scheme ;if running in DrRacket, must specify language

;FizzBuzz in Scheme
;DS 2014-02-20

(define (contains check num)
  (cond 
    ((= 0 (string-length check)) #f);if empty, not found
    ((string=? (number->string num) (substring check 0 1)) #t);if first char has it, found
    (else (contains (substring check 1 (string-length check)) num) ));send on all but first char
  )

(define (isFizz num stage)
  (if (or (= 0 (modulo num 3)) (and (= stage 2) (contains (number->string num) 3)))
      #t
      #f)
  )

(define (isBuzz num stage)
  (if (or (= 0 (modulo num 5)) (and (= stage 2) (contains (number->string num) 5)))
      #t
      #f)
  )

(define stage 2)

(define (main)
(do ((i 1 (+ i 1)))
    ((> i 100))
    (display
      (cond 
        ((and (isFizz i stage) (isBuzz i stage)) "FizzBuzz")
        ((isFizz i stage)  "Fizz")
        ((isBuzz i stage)  "Buzz")
        (else                i)))
    (newline)))
;another approach - MIT Scheme, from
;http://366daysoffizzbuzz.blogspot.com/2011/04/day-31-scheme.html
(main)
