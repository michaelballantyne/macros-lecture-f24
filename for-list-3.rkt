#lang racket

;; What if we wanted to support multiple lists?

#;(for/list ([x '(1 2 3)]
           [y '(4 5 6)])
    (+ x y))
;; => '(5 7 9)

#;(map (lambda (x y) (+ x y))
     '(1 2 3)
     '(4 5 6))



#;(define-syntax for/list
  (sexp-transformer
   (lambda (stx)
     (match stx
       [`(for/list ([,var ,rhs] ...) ,body)
        `(map (lambda (,var ...) ,body) ,rhs ...)]))))


;; We need a matching and templating language better specialized to
;; this domain!


;; Luckily, Racket has one.


(define-syntax for/list
  (syntax-rules ()
    [(for/list ([var rhs] ...) body)
     (map (lambda (var ...) body) rhs ...)]))

(for/list ([x '(1 2 3)]
           [y '(4 5 6)])
  (+ x y))

(map (lambda (x y) (+ x y)) '(1 2 3) '(4 5 6))


;; We could also define for/list by translation to a recursive
;; function with the body inlined.

;; Example
#;(for/list ([x '(1 2 3)]
             [y '(4 5 6)])
    (+ x y))
;; ----->
#;(letrec ([loop (lambda (x y)
                   (if (or (null? x) (null? y))
                       '()
                       ;; Note the tricky shadowing:
                       (let ([body-res (let ([x (first x)]
                                             [y (first y)])
                                         (+ x y))])
                         (cons body-res (loop (rest x) (rest y))))))])
    (loop '(1 2 3) '(4 5 6)))

#;
(define-syntax for/list
  (syntax-rules ()
    [(for/list ([var rhs] ...)
       body)
     (letrec ([loop (lambda (var ...)
                      (if (or (null? var) ...)
                          '()
                          (let ([body-res (let ([var (first var)]
                                                ...)
                                            body)])
                            (cons body-res (loop (rest var) ...)))))])
       (loop rhs ...))]))

#;
(for/list ([x '(1 2 3)]
           [y '(4 5 6)])
  (+ x y))


