#lang racket

(require "../../aoc.rkt"
         racket/generator)

(year 2023)
(day 8)

#;(example "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
")

(define inp (input-lines))

(define path (car inp))
(define tree-def (cddr inp))

(define (parse-treeline line)
  (filter non-empty-string? (string-split line #rx"[ =(,)]")))

(define tree (map parse-treeline tree-def))

(define (next-node node dir)
  (case dir
    [(#\L) (second node)]
    [(#\R) (third node)]))

(submit1
 (let/ec return 
   (for/fold ([node "AAA"])
             ([idx (in-naturals 1)]
              [dir (in-cycle (string->list path))])
     (define next (next-node (assoc node tree) dir))
     (if (equal? next "ZZZ")
         (return idx)
         next))))

(define (make-tree-gen start-fullnode)
  (define start (car start-fullnode))
  (generator ()
    (for/fold ([node start]) ([dir dir-cycle])
      (define next (next-node (assoc node tree) dir))
      (yield next)
      next)))

(define dir-cycle (in-cycle (string->list path)))

(define (start-node? node)
  (string-suffix? (car node) "A"))

(define (end-nodename? nodename)
  (string-suffix? nodename "Z"))

(define gens (map make-tree-gen (filter start-node? tree)))

#;(let/ec return
    (for/fold ([gens gens])
              ([idx (in-naturals 1)])
      (define nexts (map (λ (g) (g)) gens))
      (if (andmap end-nodename? nexts)
          (return idx)
          gens)))

(define (steps-until-end g)
  (let/ec return
    (for ([idx (in-naturals 1)])
      (define next (g))
      (when (end-nodename? next)
        (return idx)))))

(submit2 (apply lcm (map steps-until-end gens)))
