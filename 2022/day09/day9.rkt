#lang racket

(struct pos (x y) #:transparent)
(struct rope (head tail) #:transparent)

(define (pos-- p1 p2)
  (pos (- (pos-x p1)
          (pos-x p2))
       (- (pos-y p1)
          (pos-y p2))))

(define (pos-/ p1 f)
  (pos (/ (pos-x p1) f)
       (/ (pos-y p1) f)))

(define (two-step diff)
  (if (or (and (= (abs (pos-x diff)) 2)
               (= pos-y diff 0))
          (and (= (abs (pos-y diff)) 2)
               (= pos-x diff 0)))
      (pos-/ diff 2)
      

(define (move-tail r)
  (define diff (pos-- (rope-head r) (rope-tail r)))
  diff)