
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file
(define ones (lambda () (cons 1 ones)))
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

(define (stream-for-n-steps s n)
  (define (helper s n xs)
    (if (= n 0)
        xs        
        (helper (cdr (s)) (- n 1) (append xs (list (car (s)))))))
(helper s n null))

(define (funny-number-stream) 
  (define (helper-sequence x)
    (cons (if (= 0 (remainder x 5)) (- x)
           x)
          (lambda () (helper-sequence (+ x 1)))))
  (helper-sequence 1))


(define (dan-then-dog)
  (define (helper-dan-the-dog x)
    (cons (if (= 0 (remainder x 2))
              "dan.jpg" "dog.jpg")
          (lambda () (helper-dan-the-dog (+ x 1)))))
  (helper-dan-the-dog 2))


(define (stream-add-zero s)
       (letrec ([f (lambda(x)
                (lambda() (cons (cons 0 (car (x))) (f (cdr (x))))))])
(f s)))


(define (cycle-lists xs ys)
   (define (helper-cycle xs ys n)
     (lambda ()
       (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
             (helper-cycle xs ys (+ n 1)))))
  (helper-cycle xs ys 0))

;vector-length, vector-ref and equal?
;(vector-length (vector 1 2 3)) ;3
;(vector-ref (vector 1 2 3) 1) ;2
(define (vector-assoc v vec)
  (define (helper v vec index)
    (cond [(= index (vector-length vec)) #f] ;not a pair and the end of the list, then return false
          [(and (pair? (vector-ref vec index)) (= index (- (vector-length vec)) 1) (if (= v (car (vector-ref vec index))) (vector-ref vec index) #f))]
          [(not (pair? (vector-ref vec index)))  (helper v vec (+ index 1))] ;not a pair and not the end of the list, skip it
          [#t (if (= v (car (vector-ref vec index))) (vector-ref vec index) (helper v vec (+ index 1)))]))
  (helper v vec 0))