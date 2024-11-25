#lang racket

(define (parse in)
  (map (λ (p) (map string->symbol (string-split p)))
       (string-split in "\n")))

(define input (file->string "input/day2.txt"))

(define (as-num v)
  (match v
    [(or 'X 'A) 1]
    [(or 'Y 'B) 2]
    [(or 'Z 'C) 3]
    [else v]))

(define (part-1 r)
  (match-define (list e p) (map as-num r))
  (+ p (* 3 (modulo (add1 (- p e)) 3))))

(apply + (map part-1 (parse input)))

(define (part-2 r)
  (match-define (list e o) (map as-num r))
  (define p (add1 (modulo (+ o e) 3)))
  (part-1 (list e p)))

(apply + (map part-2 (parse input)))
