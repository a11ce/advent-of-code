#lang racket

(define (parse in)
  (map (λ (l)
         (map (λ (m)
                (map (λ (i) (string->number i))
                     (string-split m "-"))) (string-split l ",")))
       (string-split in "\n")))


(define (day1 ss)
  (length (filter (λ (s)
                    (match-define (list (list oi oa) (list ti ta)) s)
                    (or (and (oi . >= . ti) (oa . <= . ta))
                        (and (ti . >= . oi) (ta . <= . oa))))
                  ss)))

(define (day2 ss)
  ;  (length
  (length (filter (λ (s)
                    (match-define (list (list oi oa) (list ti ta)) s)
                    (not (set-empty? (set-intersect
                                      (list->set (stream->list (in-range oi (add1 oa))))
                                      (list->set (stream->list (in-range ti (add1 ta))))))))
                  ss)))

(day1
 (parse (file->string "input/day4.txt")))

(day2
 (parse (file->string "input/day4.txt")))

#|
(day2
 (parse "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"))

|#