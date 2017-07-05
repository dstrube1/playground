#lang scheme
;if running in DrRacket, must specify language

;display 1-100:
(let loop ((n 1))
  (if (> n 100)
      '()
      (cons n
	    (loop (+ n 1)))))

(+ 1 2) ;sum of 1 and 2
(cons 1 2) ; cons allocates a memory space for two addresses
(cons 3 (cons 1 2)) ;Cons cells can be beaded
(cons #\a (cons 3 "hello")) ;char a, num 3, string hello
;'() is a list.
;If ls is a list and obj is a kind of data, (cons obj ls) is a list
(car '(1 2 3 4)) ;Contents of the Address part of the Register 
(cdr '(1 2 3 4)) ;Contents of the Decrement part of the Register
'(+ 2 3)
(car '(0)) ; 0
(cdr '(0)) ; ()
(car '((1 2 3) (4 5 6)))
(cdr '(1 2 3 . 4))
(cdr (cons 3 (cons 2 (cons 1 '()))))
(list) ;empty list
(list 1) ;list of 1
(list '(1 2) '(3 4)) ;list of lists
; Hello world as a variable
(define vhello "Hello world variable")

; Hello world as a function
(define fhello (lambda () "Hello world function"))
vhello ;display contents of variable
fhello ;doesn't call it per se
(fhello) ;call it
(define hello
  (lambda (name)
    (string-append "Hello " name "!")))
(hello "Lucy")
(define sum3
  (lambda (a b c)
    (+ a b c)))
(sum3 10 20 30)
"alternate function definitions"
(define (hello2 name)
  (string-append "Hello " name "!"))
(define (sum3a a b c)
  (+ a b c))
(hello2 "Lois")
(sum3a 11 22 33)
"function with a condition"
(define (sum-gp a0 r n)
  (* a0
     (if (= r 1)
	 n
	 (/ (- 1 (expt r n)) (- 1 r)))))   ; !!
(sum-gp 1 2 3)
; /0 test
;(define (div0test) (/ 1 0))
;(div0test)
#t ;true?
#f ;false?
;if so, then why doesn't this work?:
;(define (truthTest) (if (#f) 1 2) (if (#t) 1 2))
;(truthTest)
;ands and ors
"and tests"
(and #f 0) ;if evaluates to true, return greatest truth; else #f
(and 1 2 3)
(and 1 2 3 #f) ;#f
"or tests"
(or #f 0) ;if evaluates to true, return first truth (L->R); else #f
(or 1 2 3)
(or #f 1 2 3)
(or #f #f #f)
(or 1 #f 2 3)
(or 1 2 #f 3)
(or 1 2 3 #f)
(or 3 2 1 #f)
"productIfAllPositive"
(define (productIfAllPositive a b c) 
  (if (and (< 0 a) (< 0 b) (< 0 c)) 
      (* a b c) 
      "not all positive" ;can't put this in ()s - it breaks
      );end if
  );end define
(productIfAllPositive 1 2 3)
(productIfAllPositive 1 2 -3)
"absolute value"
(define (absolute a)
  (if (<= 0 a)
      a
      (sqrt (* a a)) ;interesting difference: (* (sqrt a) (sqrt a))
      )
  )
(absolute 2)
(absolute -22)
;leftoff: http://www.shido.info/lisp/scheme5_e.html
; from http://www.shido.info/lisp/idx_scm_e.html
"conds"
(define (func input)
  (cond
   ((or (<= input 3) (>= input 65)) 0)
   ((<= 4 input 6) 0.5)
   ((<= 7 input 12) 1.0)
   ((<= 13 input 15) 1.5)
   ((<= 16 input 18) 1.8)
   (else 2.0)))
(func 2)
(func 66)
(func 14)
(func 21)
(define (whatIsTheType input)
  (cond 
    (string? input "is string")
    (integer? input "is int" )
    (else "is something else")))
(whatIsTheType 1)
(whatIsTheType #\1)
"lets test"
(let ((i 1) (j 2))
  (+ i j))
"recursion"
(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))
(fact 5)
"and now fun: each letter"
(define (eachLetter foo)
  ;display "car"
  ;(car '(foo));(string->list foo))
  ;"cdr"
  ;(cdr '(foo))
  ;(car (string->list foo))
  (cdr (string->list foo))
  )
(eachLetter (fhello))
