#lang racket

(define input (file->lines "input/day2ex.txt"))

(struct cubes (num color) #:transparent)
(struct game (num sets) #:transparent)

(define (parse-cubes s)
  (define c (string-split s " "))
  (cubes (string->number (car c))
         (cadr c)))

(define (parse-set s)
  (map parse-cubes (map string-trim (string-split s ", "))))

(define (parse-line l)
  (define s (string-split l ":"))
  (define gn 
    (string->number (cadr (string-split (car s) " "))))
  (define sets (map parse-set (string-split (cadr s) ";")))
  ;  (displayln (parse-set (car sets)))
  (game gn sets))


(define parsed-in (map parse-line input))

(