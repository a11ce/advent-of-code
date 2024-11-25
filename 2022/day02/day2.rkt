#lang racket

(define (round-score-p1 p)
  (match-define (list o y) p)
  (+ (shape-score (norm y))
     (outcome-score (norm o) (norm y))))

(define (norm s)
  (match s
    ['X 'A]
    ['Y 'B]
    ['Z 'C]
    [else s]))

(define (shape-score y)
  (match y
    ['A 1]
    ['B 2]
    ['C 3]))

(define (outcome-score o y)
  (if (equal? o y) 3
      (match (list (norm o) (norm y))
        [(or '(C B)
             '(B A)
             '(A C)) 0]
        [else 6])))



#|

p + (((p % 3) > e) * 3) + (((p % 3) >= e) * 3)
  
  1 2 3
1 4 8 
2 
3

|#
(define (parse in)
  (map (λ (p) (map string->symbol (string-split p)))
       (string-split in "\n")))

(define input (file->string "input/day2.txt"))

(apply + (map round-score-p1 (parse input)))

(define (move-to-play om oc)
  (match oc
    ['Y om]
    ['X (match om ['B 'A] ['A 'C] ['C 'B])]
    ['Z (match om ['A 'B] ['C 'A] ['B 'C])]))

(define (part2-round-s p)
  (match-define (list om oc) p)
  (+ (match oc ['X 0] ['Y 3] ['Z 6])
     (shape-score (move-to-play om oc))))

(apply + (map part2-round-s (parse input)))


(define (move-num m)
  (match m
    [(or 'X 'A) 1]
    [(or 'Y 'B) 2]
    [(or 'Z 'C) 3]))

(define (round-score r)
  (match-define (list e p) (map move-num r))
  (+ p (* 3 (modulo (add1 (- p e)) 3))))

(apply + (map round-score (parse input)))
