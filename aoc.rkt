#lang racket/base

(require racket/string
         advent-of-code
         advent-of-code/input
         advent-of-code/answer)

(provide ;open-input
         get-input
         submit1
         submit2
         day
         year

         example

         d
         lines
         map-lines
         input-lines)

(define day (make-parameter #f))
(define year (make-parameter 2024))

(define example (make-parameter #f))
#|
(define (open-input)
  (open-aoc-input (find-session) (year) (day) #:cache #t))
|#
(define (get-input)
  (if (example) (example)
      (fetch-aoc-input (find-session) (year) (day) #:cache #t)))

(define (submit part answer)
  (define result (aoc-submit (find-session) (year) (day) part answer))
  (if (string-contains? result "already complete")
      (format "Part ~v already done: ~v" part answer)
      result))

(define (submit1 answer)
  (submit 1 answer))

(define (submit2 answer)
  (submit 2 answer))

;;

(define d displayln)


(define (lines str)
  (string-split str "\n"))

(define (map-lines f str)
  (map f (lines str)))

(define (input-lines)
  (lines (get-input)))
