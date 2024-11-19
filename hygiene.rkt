#lang racket

;; Another way to implement for/list
#;#;#;
(for/list ([x '(1 2 3)])
  (* x x))

;; Is with a foldr:
(foldr (lambda (x v)
         (cons (* x x) v))
       '()
       '(1 2 3))

;; It evaluates like this:
(cons (* 1 1)
      (cons (* 2 2)
            (cons (* 3 3) '())))

;; Here's a sexpr-transformer macro that does it:
#;#;
(require "sexp-transformer.rkt")
(define-syntax for/list
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(for/list ([,el ,e]) ,body)
        `(foldr (lambda (,el v)
                  (cons ,body v))
                '()
                ,e)]))))


#;(for/list ([x '(1 2 3)])
  (* x x))

;; Seems to work!

;; I should be able to change the x to a v, right?

#;(for/list ([v '(1 2 3)])
  (* v v))



#;(foldr (lambda (v v)
         (cons (* v v) v))
       '()
       '(1 2 3))


;; A hacky fix


(require "sexp-transformer.rkt")
(define-syntax for/list
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(for/list ([,el ,e]) ,body)
        (define fresh-v (gensym))
        `(foldr (lambda (,el ,fresh-v)
                  (cons ,body ,fresh-v))
                '()
                ,e)]))))

(for/list ([v '(1 2 3)])
  (* v v))








;; What if I try the same thing in syntax-rules?
#;
(define-syntax for/list  
  (syntax-rules ()
    [(_ ([el e]) body)
     (foldr (lambda (el v)
              (cons body v))
            '() e)]))

