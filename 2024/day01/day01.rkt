#lang racket

(require "../../aoc.rkt")

(day 1)

; for uiua. prints:
#|
[3
...
3
]
[4
...
3
]
|#
(define (display-part1)
  (for-each
   (λ (l) (display "[")
     (map (λ (c) (display c) (display "\n")) l) (displayln "]"))
   (apply map list
          (map-lines
           (λ (l)
             (map string->number (string-split l "   ")))
           (get-input)))))

; for spreadsheet. prints:
#|
3, 4
4, 3
...
3, 3
|#
(define (display-part2)
  (for-each
   (λ (l)
     (define v (map string->number (string-split l "   ")))
     (display (car v))
     (display ", ")
     (displayln (cadr v)))
   (lines (get-input))))
