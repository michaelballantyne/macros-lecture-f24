#lang racket/base


(require rackunit
         ;;  Let's define our own streams!
         #;racket/stream)


(define (every-other n)
  (stream-cons n (every-other (+ n 2))))

(define (stream-member? s x)
  (cond
    [(stream-empty? s) #f]
    [(equal? (stream-first s) x) #t]
    [else (stream-member? (stream-rest s) x)]))























;; A stream is one of:
;;   '()
;;   (stream-pair any (-> () stream))
#|
(struct stream-pair [first-val rest-fn])

(define example-stream (stream-pair 1 (lambda () (stream-pair 2 (lambda () '())))))

(define (stream-empty? s) (null? s))

(define (stream-first s) (stream-pair-first-val s))

(define (stream-rest s)
  (define fn (stream-pair-rest-fn s))
  (fn))

(check-equal?
 (stream-first (stream-rest example-stream))
 2)

(define-syntax stream-cons
  (syntax-rules ()
    [(stream-cons v e)
     (stream-pair v (lambda () e))]))

(define example-with-stream-cons (stream-cons 1 (stream-cons 2 '())))

(check-equal?
 (stream-first (stream-rest example-with-stream-cons))
 2)


(define (every-other n)
  (stream-cons n (every-other (+ n 2))))

(define (stream-member? s x)
  (cond
    [(stream-empty? s) #f]
    [(equal? (stream-first s) x) #t]
    [else (stream-member? (stream-rest s) x)]))
|#