#lang racket/base


(require "sexp-transformer.rkt")

#;(define-syntax or
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(or ,e1 ,e2)
        `(let ([tmp ,e1])
           (if tmp
               tmp
               ,e2))]))))

#;(let ([v 1])
  (or #f (begin (displayln "here") v)))

#;(let ([tmp 1])
  (or #f (begin (displayln "here") tmp)))


(define-syntax or
  (syntax-rules ()
    [(or e1 e2)
     (let ([tmp e1])
           (if tmp
               tmp
               e2))]))
  
(let ([v 1])
  (or #f (begin (displayln "here") v)))

;; How this expands:
#;(let ([tmp 1])
  #;(or #f (begin (displayln "here") tmp))
  ;; expands to:
  (let ([tmp_d #f])
    (if tmp_d
        tmp_d
        (begin (displayln "here") tmp_u))))

  

