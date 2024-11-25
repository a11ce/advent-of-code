#lang racket

(require sugar/coerce
         threading)

(struct Tree (loc height) #:transparent)

(define (parse in)
  (define pos 0)
  (map (λ (l) (map (λ (v) (set! pos (add1 pos)) (Tree pos (~> v ->string ->int)))
                   (string->list l)))
       (string-split in "\n")))

(define (visible run)
  (define cut -1)
  (for/list ([tree run]
             #:when (< cut (Tree-height tree)))
    (set! cut (Tree-height tree))
    tree))

(define ex (parse "30373
25512
65332
33549
35390"))



(define (part1 forest)
  ; (define visible (mutable-set))
  (define runs (append forest
                       (map reverse forest)
                       (apply map list forest)
                       (map reverse (apply map list forest))))
  (define all-vis (flatten (map visible runs)))
  (length (remove-duplicates all-vis)))


(part1 (parse (file->string "input/day8.txt")))

(define (tree-<= t1 t2)
  (<= (Tree-height t1)
      (Tree-height t2)))

(define (view-dist run)
  (define base (first run))
  (length (for/list ([tree (rest run)]
                     #:final (tree-<= base tree))
            tree)))

(define (score tree forest)
  (apply * (map view-dist
                (for/list ([angle (list forest
                                        (map reverse forest)
                                        (apply map list forest)
                                        (map reverse (apply map list forest)))])
                  (member tree (first (filter (λ (r) (member tree r))
                                              angle)))))))

(define (part2 forest)
  (apply max (map (λ (t) (score t forest))
                  (flatten forest))))

(part2 (parse (file->string "input/day8.txt")))