
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence from to stride)
  (define (helper from to stride xs)
    (if (> from to)
        xs
        (helper (+ from stride) to stride (append xs (list from)))))
  (helper from to stride null))
