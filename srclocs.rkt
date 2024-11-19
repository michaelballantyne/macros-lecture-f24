#lang racket

#;
(define-syntax for/list  
  (syntax-rules ()
    [(_ ([el e]) body)
     (foldr (lambda (el v)
              (cons body v))
            '() e)]))

#;(for/list ([v '(1 2 3)])
  (let res (* x x)
    x))

#;#;
(require "sexp-transformer.rkt")
(define-syntax for/list-sexp
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(for/list-sexp ([,el ,e]) ,body)
        `(foldr (lambda (,el v)
                  (cons ,body v))
                '()
                ,e)]))))

#;(for/list-sexp ([x '(1 2 3)])
  (let res (* x x)
    x))

#;#;
(define-syntax for/list
  (lambda (stx)
    (displayln stx)
    (raise-syntax-error #f "problem with for/list syntax" stx)
    #''TODO))

(for/list ([x '(1 2 3)])
  (let res (* x x)
    x))



;; Syntax errors don't automatically make errors awesome, though.
#;#;
(define-syntax for/list  
  (syntax-rules ()
    [(_ ([el e]) body)
     (foldr (lambda (el v)
              (cons body v))
            '() e)]))

(for/list ([(x y) '(1 2 3)])
  (* x x))

;; The code I wrote doesn't have a lambda! And the docs for for/list say
;; nothing about a "default-value expression"


(require (for-syntax syntax/parse))
#;#;
(define-syntax for/list  
  (syntax-parser
    [(_ ([el e]) body)
     #'(foldr (lambda (el v)
                (cons body v))
              '() e)]))
(for/list ([(x y) '(1 2 3)])
  (* x x))

(define-syntax for/list  
  (syntax-parser
    [(_ ((~describe "iteration clause" [el:id e])) body)
     #'(foldr (lambda (el v)
                (cons body v)))]))

(for/list ()
  (* x x))

