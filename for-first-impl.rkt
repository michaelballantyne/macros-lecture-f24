#lang racket

;; Recall that we thought about translating for/first
;; similarly.

;; That is...
#;#;
(define (find-time times p1-frees p2-frees)
  (for/first ([t times] [p1 p1-frees] [p2 p2-frees]
              #:when (and p1 p2))
    t))

;; Could expand to a local recursive function, like our
;; HTDP-style solution.
(define (find-time times p1-frees p2-frees)
  (letrec ([find (lambda (t p1 p2)
                   (if (or (null? t) (null? p1) (null? p2)) 
                       #f
                       (if (let ([t (first t)]
                                 [p1 (first p1)]
                                 [p2 (first p2)])
                             (and p1 p2))
                           ;; Notice these are duplicate!
                           (let ([t (first t)]     
                                 [p1 (first p1)]
                                 [p2 (first p2)])
                             t)
                           (find (rest times)      
                                 (rest p1)
                                 (rest p2)))))])
    (find times p1-frees p2-frees)))

;; Let's implement this macro.









#;#;#;
(define-syntax for/first
  (syntax-rules ()
    [(for/first ([var rhs] ... #:when condition) body)
     (letrec ([find (lambda (var ...)
                      (if (or (null? var) ...)
                          #f
                          (if (let ([var (first var)]
                                    ...)
                                condition)
                              (let ([var (first var)]
                                    ...)
                                body)
                              (find (rest var) ...))))])
       (find rhs ...))]))

(define (find-time times p1-frees p2-frees)
  (for/first ([t times] [p1 p1-frees] [p2 p2-frees]
              #:when (and p1 p2))
    t))

(find-time '("9am" "10am" "11am" "noon")
             '(#t    #f     #t     #t)
             '(#f    #f     #t     #t))





;; I would rather only bind the variables once...
#;(define-syntax for/first
  (syntax-rules ()
    [(for/first ([var rhs] ... #:when condition) body)
     ;; But no way to generate these var-list variables:
     (letrec ([find (lambda (var-list ...)
                      (if (or (null? var-list) ...)
                          #f
                          (let ([var (first var-list)]
                                ...)
                            (if condition
                                body
                                ;; but the use here is wrong!
                                (find (rest var) ...)))))]) 
       (find rhs ...))]))