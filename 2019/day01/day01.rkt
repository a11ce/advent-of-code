#lang racket

(require "../../aoc.rkt")

(year 2019)
(day 1)

(submit1
 (apply + (for/list ([line (in-lines (open-input))])
            (- (floor (/ (string->number line) 3)) 2))))

(define inp (map-lines string->number (get-input)))

(define (fuel n)
  (- (floor (/ n 3)) 2))

(define (total-fuel n)
  (if (<= (fuel n) 0)
      0
      (+ (fuel n) (total-fuel (fuel n)))))

;(total-fuel 100756)

(submit2 (apply + (map total-fuel inp)))
