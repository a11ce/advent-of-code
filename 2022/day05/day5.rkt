#lang racket

(define test-init
  '((N Z)
    (D C M)
    (P)))

(define (parse in)
  (map (λ (l)
         (let ([li (string-split l)])
           (map string->number
                (list (second li)
                      (fourth li)
                      (sixth li)))))
       (string-split in "\n")))

(define (move1 src dst state)
  (let ([src (sub1 src)]
        [dst (sub1 dst)])
    
    (define b (car (list-ref state src)))
    (list-set (list-set state src (rest (list-ref state src)))
              dst (cons b (list-ref state dst)))))

(define (move state n src dst)
  (for ([idx (in-range n)])
    (set! state (move1 src dst state)))
  state)

(define (multimove state n src dst)
  (let ([src (sub1 src)]
        [dst (sub1 dst)])
    (define b (take (list-ref state src) n))
    (list-set (list-set state src (drop (list-ref state src) n))
              dst (append b (list-ref state dst)))))

(define (day1 ops state)
  (for ([op ops])
    (set! state (apply move state op)))
  (map car state))

(define (day2 ops state)
  (for ([op ops])
    (set! state (apply multimove state op)))
  (map car state))


#||#

(define init '((N H S J F W T D)
               (G B N T Q P R H)
               (V Q L)
               (Q R W S B N)
               (B M V T F D N)
               (R T H V B D M)
               (J Q B D)
               (Q H Z R V J N D)
               (S M H N B)))

(day1 (parse (file->string "input/day5.txt")) init)

(day2 (parse (file->string "input/day5.txt")) init)
(day2 '((1 2 1)
        (3 1 3)
        (2 2 1)
        (1 1 2))
      test-init)
