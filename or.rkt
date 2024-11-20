#lang racket



(define (every-other n)
  (stream-cons n (every-other (+ n 2))))


#;#;#;
;; Stream Any -> Boolean
(define (stream-member? s x)
  (if (stream-empty? s)
      #f
      (if (equal? (stream-first s) x)
          #t
          (stream-member? (stream-rest s) x))))

;; Examples
(stream-member? (every-other 0) 4)
(stream-member? (stream-take (every-other 0) 10) 3)


#;(define (or a b)
    (if a
        a
        b))

#;(define-syntax or
  (syntax-rules ()
    [(or expr1 expr2)
     (if expr1
         expr1
         expr2)]))

#;(or (begin (displayln "here")
           #t)
    5)

#;(if (begin (displayln "here")
           #t)
    (begin (displayln "here")
           #t)
    5)

#;(define-syntax or
  (syntax-rules ()
    [(or expr1 expr2)
     (let ([fn (lambda (val1)
                 (if val1
                     val1
                     expr2))])
       (fn expr1))]))

#;(define-syntax or
  (syntax-rules ()
    [(or expr1 expr2)
     (let ()
       (define val1 expr1)
       (if val1
           val1
           expr2))]))

#;(define-syntax or
  (syntax-rules ()
    [(or expr1 expr2)
     (let ([val1 expr1])
       (if val1
           val1
           expr2))]))

#;(or (begin (displayln "here")
           #t)
    5)

#;(let ([val1 (begin (displayln "here")
                   #t)])
  (if val1
      val1
      5))

#;(define (stream-member? s x)
  (and (not (stream-empty? s))
       (or (equal? (stream-first s) x)
           (stream-member? (stream-rest s) x))))

#;(define (stream-member? s x)
  (and (not (stream-empty? s))
       #;(or (equal? (stream-first s) x)
             (stream-member? (stream-rest s) x))
       (if (equal? (stream-first s) x)
         (equal? (stream-first s) x)
         (stream-member? (stream-rest s) x))))

#;(stream-member? (every-other 0) 4)







#;(or #t (displayln "here!"))

#;(define-syntax or
    (syntax-rules ()
      [(or a b)
       (if a
           a
           b)]))

#;(or (begin
        (displayln "here!")
        #t)
      5)

#;(define-syntax or
    (syntax-rules ()
      [(or a b)
       (let ([a-val a])
         (if a-val
             a-val
             b))]))

#;(or (begin
        (displayln "here!")
        #t)
      5)


;; Racket's or works with arbitrarily many values...

;; Specific example
#;(or #f 3 (begin (displayln "here") #f))
;; => 3

;; Slightly generic example
#;(or e1 e2 e3)
;;
#;(let ([v1 e1])
  (if v1
      v1
      (let ([v2 e2])
        (if v2
            v2
            e3))))

(define-syntax or
  (syntax-rules ()
    [(or) #f]
    [(or e) e]
    [(or e1 e ...)
     (let ([v e1])
       (if v
           v
           (or e ...)))]))

(define (f e1 e2 e3)
  (or e1 e2 e3))


#;(or #f 3 (begin (displayln "here") #f))






;; What would we like this to expand to?

#;(or #f 3 #f)
;;----->
#;(let ([v1 #f])
    (if v1
        v1
        (let ([v2 3])
          (if v2
              v2
              (let ([v3 #f])
                v3
                v3
                #f)))))

;; How can we define this macro? The expansion doesn't look like it has
;; a sequence of code fragments corresponding to the sequence of expressions.
#;(define-syntax or
  (syntax-rules ()
    [(or e ...)
     ]))












#;
(define-syntax or
  (syntax-rules ()
    [(or)
     #f]
    [(or e1 e ...)
     (let ([e1-v e1])
       (if e1-v
           e1-v
           (or e ...)))]))

#;
;; Let's step through this expansion with the macro stepper.
(define (stream-member? s x)
  (and (not (stream-empty? s))
       (or (equal? (stream-first s) x)
           (stream-member? (stream-rest s) x))))


;; This isn't quite the right version of or---if you want a challenge,
;; think about how it interacts with tail recursion.

#;(time
   (stream-member? (every-other 0) 10000000))

  


