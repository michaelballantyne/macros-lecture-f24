#lang racket

(define (every-other n)
  (stream-cons n (every-other (+ n 2))))

#;(define (stream-member? s x)
  (cond
    [(stream-empty? s) #f]
    [(equal? (stream-first s) x) #t]
    [else (stream-member? (stream-rest s) x)]))
;; Expands to:
#;(define (stream-member? s x)
  (if (stream-empty? s)
      #f
      (if (equal? (stream-first s) x)
          #t
          (stream-member? (stream-rest s) x))))
         
      
#;(stream-member? (every-other 0) 4)

;; Generalization:
;; (cond [condition consequent] ... {[else consequent]})

(define-syntax cond
  (syntax-rules (else)
    [(cond [else consequent])
     consequent]
    [(cond [condition1 consequent1] more ...)
     (if condition1
         consequent1
         (cond more ...))]
    [(cond)
     (error 'cond "no case matched")]))

(define (stream-member? s x)
  (cond
    [(stream-empty? s) #f]
    [(equal? (stream-first s) x) #t]
    [else (stream-member? (stream-rest s) x)]))

;; (ex!)



#;(let* ([x 1]
       [x (+ x 1)]
       [x (* x 2)])
  x)
;; Expands to:
#;(let ([x 1])
    (let ([x (+ x 1)])
      (let ([x (* x 2)])
        x)))
;; Generalization of the input for this example:
;; (let* ([var rhs] ...) body)
#;#;#;
(define-syntax let*
  (syntax-rules ()
    [(let* () body1 body ...)
     (let () body1 body ...)]
    [(let* ([var1 rhs1] [var rhs] ...) body1 body ...)
     (let ([var1 rhs1])
       (let* ([var rhs] ...)
         body1 body ...))]))

(let* ([x 1]
       [x (+ x 1)]
       [x (* x 2)])
  x)

(let ()
  (define y 6)
  y)


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
