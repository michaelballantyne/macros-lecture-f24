#lang racket

(define (every-other n)
  (stream-cons n (every-other (+ n 2))))

#;
(stream->list (stream-take (every-other 4) 5))

#;#;
(define (stream-member? s x)
  (if (stream-empty? s)
      #f
      (if (equal? (stream-first s) x)
          #t
          (stream-member? (stream-rest s) x))))
      
(stream-member? (every-other 0) 4)



#;
(define (stream-member? s x)
  (and (not (stream-empty? s))
       (or (equal? (stream-first s) x)
           (stream-member? (stream-rest s) x))))

#;(stream-member? (every-other 0) 4)


#;(define (or a b)
    (if a
        a
        b))


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

#;(or #f 3 #f)
;; => 3


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


(define-syntax or
  (syntax-rules ()
    [(or)
     #f]
    [(or e1 e ...)
     (let ([e1-v e1])
       (if e1-v
           e1-v
           (or e ...)))]))


;; Let's step through this expansion with the macro stepper.
(define (stream-member? s x)
  (and (not (stream-empty? s))
       (or (equal? (stream-first s) x)
           (stream-member? (stream-rest s) x))))


#;(time
 (stream-member? (every-other 0) 10000000))

  


