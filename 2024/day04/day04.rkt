#lang racket

(require "stacket.rkt"
         "../advent-of-code/aoc.rkt")

(day.1 4)

(define (parse inp)
  (map.2 'string->list
         string-split.2 inp "\n"))

(define grid (parse get-input))

(define x car)
(define y cdr)
(define v2 cons)

(define (ref2d lst pos)
  (with-handlers ([exn? (lambda (n)
                          #\.)])
    (list-ref list-ref lst y pos x pos)))

(define (+2d p1 p2)
  (cons add.2 x p1 x p2 add.2 y p1 y p2))

(define (*2d v scale)
  (cons *.2 x v scale *.2 y v scale))

(define directions
  (for*/list ([x (list.3 -1 0 1)]
              [y (list.3 -1 0 1)])
    (cons x y)))

(define (in-direction start dir length)
  (for/list ([idx length])
    (+2d start *2d dir idx)))

(define (is-xmas? start direction)
  (for/and ([p (in-direction start direction 4)]
            [c (list.4 #\X #\M #\A #\S)])
    (equal? c ref2d grid p)))

(define (part1)
  (count.2
   'identity
   (for*/list ([x (length first grid)]
               [y (length grid)]
               [d directions])
     (is-xmas? v2 x y d))))

(part1)

(define diags
  (list.4 v2 -1 -1
          v2 -1  1
          v2  1 -1
          v2  1  1))

(define (diags-of p)
  (for/list ([diag diags])
    (ref2d grid +2d p diag)))

(define (is-cross? p)
  (define d (diags-of p))
  (and.3 equal? list.4 #\M #\M #\S #\S sort d 'char<?
         equal? #\A ref2d grid p
         not equal? ref2d grid +2d p v2 -1 -1
         ref2d grid +2d p v2 1 1))

(define (part2)
  (count.2 'identity
           (for*/list ([x (length first grid)]
                       [y (length grid)])
             (is-cross? v2 x y))))

(part2)
