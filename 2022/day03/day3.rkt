#lang racket

(require threading
         bincraft/bin)

(define (parse in)
  (map
   (λ (l)
     (define r (string->list l))
     (define-values (c1 c2)
       (split-at r (/ (length r) 2)))
     (list c1 c2))
   (string-split in "\n")))

(define (prio i)
  (define n (char->integer i))
  (cond
    [(>= n 97) (- n 96)]
    [else (- n 38)]))

(define (common rs)
  (first (filter (λ (e) (member e (first rs)))
                 (second rs))))

(define input (file->string "input/day3.txt"))

(apply + (map (λ~> common prio) (parse input)))

(define (badge g)
  (first (set->list
          (apply set-intersect (map (λ (r)
                                      (list->set (append (first r) (second r)
                                                         )))
                                    g)))))
  
(define (badges rs)
  (if (empty? rs) '()
      (let ()
        (define-values (g rss) (split-at rs 3))
        (cons (badge g) (badges rss)))))

(apply + (map prio (badges (parse input))))