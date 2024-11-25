#lang racket/base

(require racket/string
         advent-of-code
         advent-of-code/input
         advent-of-code/answer)

(provide open-input
         get-input
         submit1
         submit2
         day
         year

         d
         map-lines)

(define day (make-parameter #f))
(define year (make-parameter 2024))

(define (open-input)
  (open-aoc-input (find-session) (year) (day) #:cache #t))

(define (get-input)
  (fetch-aoc-input (find-session) (year) (day) #:cache #t))

(define (submit part answer)
  (define result (aoc-submit (find-session) (year) (day) part answer))
  (if (string-contains? result "already complete")
      (format "Part ~v already done." part)
      result))

(define (submit1 answer)
  (submit 1 answer))

(define (submit2 answer)
  (submit 2 answer))

;;

(define d displayln)

(define (map-lines f str)
  (map f (string-split str "\n")))