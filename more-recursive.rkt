#lang racket

(define (every-other n)
  (stream-cons n (every-other (+ n 2))))

(define (stream-member? s x)
  (cond
    [(stream-empty? s) #f]
    [(equal? (stream-first s) x) #t]
    [else (stream-member? (stream-rest s) x)]))
      
(stream-member? (every-other 0) 4)

#;(define-syntax cond
  (syntax-rules ()
    ;; ?
    ))


;; (ex!)






#;(let* ([x 1]
       [x (+ x 1)]
       [x (* x 2)])
  x)
;;----->
#;(let ([x 1])
    (let ([x (+ x 1)])
      (let ([x (* x 2)])
        x)))












#;(define-syntax let*
  (syntax-rules ()
    [(let* () body) body]
    [(let* ([var rhs] more-bindings ...) body)
     (let ([var rhs])
       (let* (more-bindings ...) body))]))

#;(let* ([x 1]
         [x (+ x 1)]  ; 2
         [x (* x 2)]) ; 4
    x)

;; What if we want to allow definitions in the body?

#;(let* ([x 1]
       [x (+ x 1)]  ; 2
       [x (* x 2)]) ; 4
  (define y (* x 3))
  y)
