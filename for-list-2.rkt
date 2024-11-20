#lang racket

(require rackunit)

;; It's really hard to see the transformation we intend
;; from this code! The comment is quite necessary.

;; (for/list ([<var> <rhs>])
;;   <body>))
;; ---->
;; (map (lambda (<var>) <body>) <rhs>)
#;
(define (for/list-transformer stx)
  (define iteration-clauses (second stx))
  (define body (third stx))
  (define var (first (first iteration-clauses)))
  (define rhs (second (first iteration-clauses)))

  (define fn (list 'lambda (list var) body))
  (list 'map fn rhs))


;; What about using `match`?
#;#;
(define (for/list-transformer stx)
  (match stx
    [(list for/list-id (list (list var rhs)) body)
     
     (define fn (list 'lambda (list var) body))
     (list 'map fn rhs)]))

(for/list-transformer
    '(for/list ([x '(1 2 3)]) (+ x 1)))


;; The matching part looks a little better, but the construction
;; part is still hard to read...

#;(
(define var 'x)
(define body '(+ x 1))
(define rhs ''(1 2 3))

;; This construction...
(list 'map (list 'lambda (list var) body) rhs)

;; Can also be written...
`(map (lambda (,var) ,body) ,rhs))



;; This also works in match patterns!

#;#;
(define (for/list-transformer stx)
  (match stx
    [`(for/list ([,var ,rhs]) ,body)
     `(map (lambda (,var) ,body) ,rhs)]))

(for/list-transformer
    '(for/list ([x '(1 2 3)]) (+ x 1)))


;; Putting it all together into the macro


(require "sexp-transformer.rkt")

(define-syntax for/list
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(for/list ([,var ,rhs]) ,body)
        `(map (lambda (,var) ,body) ,rhs)]))))

(for/list ([x '(1 2 3)])
  (+ x 1))



