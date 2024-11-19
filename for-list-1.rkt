#lang racket

(require rackunit)

;; How do we program a macro expansion in Racket?
;; We'll start with a simple, familiar idea: manipulating s-expressions.
;; As we'll see, the real answer in Racket gets more complicated.

;; Let's start with a simpler macro, another for form:

#;(for/list ([x '(1 2 3)])
  (+ x 1))
;; ---->
#;(map (lambda (x) (+ x 1)) '(1 2 3))





;; More generally, we want to transform:

;; (for/list ([<var> <rhs>])
;;   <body>))
;; ---->
;; (map (lambda (<var>) <body>) <rhs>)


;; We can represent syntax with s-expressions. These are equivalent:
#;#;
'(for/list ([x '(1 2 3)])
   (+ x 1))
(list 'for/list (list (list 'x (list 'quote (list 1 2 3))))
      (list '+ 'x 1))

;; And we know how to write functions that manipulate lists.

#;#;#;
(define (for/list-transformer stx)
  (define iteration-clauses (second stx))
  (define body (third stx))
  (define var (first (first iteration-clauses)))
  (define rhs (second (first iteration-clauses)))

  (define fn (list 'lambda (list var) body))
  (list 'map fn rhs))

(for/list-transformer
    '(for/list ([x '(1 2 3)]) (+ x 1)))

(check-equal?
 (for/list-transformer
     '(for/list ([x '(1 2 3)]) (+ x 1)))
 '(map (lambda (x) (+ x 1)) '(1 2 3)))




#;#;#;
;; A library that lets us write macros in this simplistic way;
;; see also compatibility/defmacro
(require "sexp-transformer.rkt")

(define-syntax for/list
  (sexp-transformer
   (lambda (stx)
     (define iteration-clauses (second stx))
     (define body (third stx))
     (define var (first (first iteration-clauses)))
     (define rhs (second (first iteration-clauses)))

     (define fn (list 'lambda (list var) body))
     (list 'map fn rhs))))

(for/list ([x '(1 2 3)])
  (+ x 1))
  

