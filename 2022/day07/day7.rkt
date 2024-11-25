#lang racket


(struct Node (name parent) #:transparent)
(struct Dir Node (contents) #:mutable #:transparent)
(struct File Node (size) #:transparent)

(define (parse in)
  (define fakeroot (Dir "fakeroot" '() '()))
  (define current-dir fakeroot)
  (for ([line (string-split in "\n")])
    (match (string-split line)
      [(list "$" "cd" "..")
       (set! current-dir (Node-parent current-dir))]
      [(list "$" "cd" dir)
       (let ([new-dir (Dir dir current-dir '())])
         (set-Dir-contents! current-dir
                            (cons new-dir (Dir-contents current-dir)))
         (set! current-dir new-dir))]
      [(list "$" "ls") '()]
      [(list "dir" dir) '()]
      [(list size fn)
       (let ([new-file (File fn current-dir (string->number size))])
         (set-Dir-contents!
          current-dir
          (cons new-file (Dir-contents current-dir))))]))
  fakeroot)

(define (dir-size node)
  (if (File? node)
      (File-size node)
      (apply + (map dir-size (Dir-contents node)))))

(define (flatten-fs node)
  (if (File? node)
      (list node)
      (flatten (cons node (map flatten-fs
                               (Dir-contents node))))))

(define (part1 fs)
  (apply +
         (filter (λ (s) (s . <= . 100000))
                 (map dir-size (filter (λ (d) (and (Dir? d)
                                                   (not (null? (Node-parent d)))))
                                       (flatten-fs fs))))))

(part1 (parse (file->string "input/day7.txt")))

(define (part2 fs)
  (define sizes
    (map dir-size (filter (λ (d) (and (Dir? d)
                                      (not (null? (Node-parent d)))))
                          (flatten-fs fs))))
  (define used (apply max sizes))
  (define unused (- 70000000 used ))
  (define needed (- 30000000 unused))
  (apply min (filter (λ (s) (s . >= . needed)) sizes)))

(part2 (parse (file->string "input/day7.txt")))