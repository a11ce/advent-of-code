#lang racket

(require "../../aoc.rkt")

(year 2019)
(day 2)

(struct vm (pc mem) #:transparent)
(struct fin (v) #:transparent)

(define (decode op)
  (case op
    [(1) 'add]
    [(2) 'mul]
    [(99) 'hlt]))

(define (+pc inc v)
  (vm (+ inc (vm-pc v)) (vm-mem v)))

(define (store v idx val)
  (vm (vm-pc v)
      (list-set (vm-mem v) idx val)))

(define (step v)
  (define (ref idx) (list-ref (vm-mem v) idx))
  (define pc (vm-pc v))
  (define op (ref pc))
  (define (loadloadstore %op a b c)
    (define (rref p) (ref (+ p pc)))
    (define res (%op (ref (rref a)) (ref (rref b))))
    (vm pc (list-set (vm-mem v)
                     (rref c) res)))
  (case (decode op)
    [(add)
     (+pc 4 (loadloadstore + 1 2 3))]
    [(mul)
     (+pc 4 (loadloadstore * 1 2 3))]
    [(hlt)
     (fin v)]
    [else (error 'bad-op (~v (decode op)))]))

(define (parse-intcode str)
  (vm 0 (map string->number (string-split
                             (string-trim
                              str) ","))))

(define ex (parse-intcode "1,9,10,3,2,3,11,0,99,30,40,50"))

(define (run-until-hlt init)
  (let loop ([state init])
    (define next (step state))
    (if (fin? next)
        next
        (loop (step state)))))

(define (output f)
  (car (vm-mem (fin-v f))))

;(run-until-hlt "1,9,10,3,2,3,11,0,99,30,40,50")
(define in (parse-intcode (get-input)))
(define mod-in (store (store in 1 12) 2 2))
(submit1 (output (run-until-hlt mod-in)))

(define (store-12 in v1 v2)
  (store (store in 1 v1) 2 v2))


(define (p2)
  (let/ec return
    (for* ([idx 100]
           [jdx 100])
      (define out
        (output (run-until-hlt (store-12 in idx jdx))))
      (when (= 19690720 out)
        (return (+ (* 100 idx) jdx))))))

(submit2 (p2))
