
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence from to stride)
  (define (helper from to stride xs)
    (if (> from to)
        xs
        (helper (+ from stride) to stride (append xs (list from)))))
  (helper from to stride null))

(define (string-append-map xs prefix)
  (map (lambda (in) (string-append in prefix)) xs))

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (list-ref xs (remainder n (length xs)))]))