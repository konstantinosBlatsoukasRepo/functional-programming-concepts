#lang racket

(provide (all-defined-out)); this is for making everything public

(define s "hello") ; variable that holds "hello"

(define x 3)
(define y (+ x 2)) ;this is a function call, in that case + is the function

(define cube1
  (lambda (x)
         (* x (* x x)))) ;function definition, lamda is like anonymous function

(define cube2
  (lambda (x)
         (* x x x))) ;function definition, lamda is like anonymous function

(define (cube3 x)
         (* x x x)) ;function definition, lamda is like anonymous function

(define (pow1 x y)
  (if (= y 0)
  1
  (* x (pow1 x (- y 1)))))

(define pow2 ;curried version
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

;racket lists
;empty list: null
;cons constructor: cons
;head of the list: car
;(list e1 ... en)


(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))


(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(define (silly-double x)
  (let ([x (+ x 3)]
        [y (+ x 2)])
    (+ x y -5)))

