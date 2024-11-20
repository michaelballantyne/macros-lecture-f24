#lang racket

(require "xpath.rkt")

(define example-xexpr
  '(*TOP* (html (head (title "My Webpage"))
                (body (div
                       (p "here is a link:"
                          (a (@ [href "https://google.com"]) "click me!")))
                      (div
                       (p "here is another link:"
                          (a (@ [href "https://google.com"]) "click me too!"))
                       (br)
                       (p "ok that's all"))))))


;; Task: Find all link tags (<a>) within the body where the
;; destination of the link is google. Return the text of the links.

(select example-xexpr
        'html
        'body
        1
        (deep 'a)
        (where (has-attribute 'href "https://google.com"))
        0)

;; =>
#;'("click me!" "click me too!")

;; A language of selectors

;; expr      := ...
;;            | (select <expr> <selector> ...)
;; 
;; selector  := predicate             ;; implicitly, "child"
;;            | <number>              ;; implicitly, nth-child
;;            | (deep <predicate>)
;;            | (where <predicate>)
;;
;; predicate := '<tag-name>
;;            | (has-attribute <expr> [<expr>])


;; We can get much of the way with procedural
;; abstraction, but not all the way there. Macros close the gap.

#;
(select example-xexpr
        'html
        'body
        (deep 'a)
        (where (has-attribute 'href "https://google.com"))
        0)
;; Expands to...

(select/f example-xexpr
          (find-child (has-tag 'html))
          (find-child (has-tag 'body))
          (find-deep (has-tag 'a))
          (find-where (has-attribute 'href "https://google.com"))
          (nth-child 0))


