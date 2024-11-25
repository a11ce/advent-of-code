#lang racket

(define input (file->lines "input/day1.txt"))

(define (replace-nums s)
  (for/fold ([str s])
            ([r '(("one" "o1e")
                  ("two" "t2o")
                  ("three" "t3e")
                  ("four" "f4r")
                  ("five" "f5e")
                  ("six" "s6x")
                  ("seven" "s7n")
                  ("eight" "e8t")
                  ("nine" "n9e"))])
    (string-replace str (car r) (cadr r))))

#;(apply + (map (λ (l)
                  (define nums (filter values
                                       (map string->number (string-split l ""))))
                  (+ (* 10 (first nums))
                     (first (reverse nums))))
                input))

(apply + (map (λ (l)
                (define nums (filter values
                                     (map string->number (string-split (replace-nums l) ""))))
                (+ (* 10 (first nums))
                   (first (reverse nums))))
              input))