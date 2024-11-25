#lang racket

(define (cals/elf in)
  (define elves
    (map (λ (e)
           (apply + (map string->number (string-split e))))
         (string-split in "\n\n")))
  elves)

(define input (file->string "input/day1.txt"))

(apply max (cals/elf input))

(apply + (take (sort (cals/elf input)
                     >)
               3))