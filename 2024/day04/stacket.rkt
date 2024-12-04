#lang racket

(require (for-syntax syntax/parse
                     racket/syntax
                     racket/string))

(provide (rename-out [quo quote]
                     [^ #%app]
                     [ftop #%top]
                     [+ add]
                     [- sub]
                     [func-and and]))

(struct quo (c) #:transparent)

(define (rpn-interp-list prog)
  (if (equal? (last prog) quo)
      (quo (first prog))
      (let ()
        (define-values
          (result _)
          (for/fold ([stack '()]
                     [to-quote #f])
                    ([dat prog])
            (cond
              [(quo? dat) (values
                           (cons (quo-c dat) stack) to-quote)]
              [(and (not to-quote) (procedure? dat))
               (values (rpn-proc-interp dat stack) #f)]
              [else (values (cons dat stack) #f)])))
        (car result))))

(define (rpn-proc-interp dat stack)
  (define arity (procedure-arity dat)) 
  (if (number? arity)
      (rpn-proc-interp-arity dat stack arity)
      (error "procedure needs explicit arity" dat)))

(define (rpn-proc-interp-arity dat stack arity)
  (define-values (args rest-stack) (split-at stack arity))
  (cons (apply dat args) rest-stack))

(define-syntax-rule
  (^ prog ...)
  (rpn-interp-list (reverse (list prog ...))))

(define-syntax-rule
  (fix proc n)
  (procedure-reduce-arity proc n))

(define-syntax (ftop stx)
  (syntax-parse stx
    [(_ . etc)
     (define name (symbol->string (syntax-e #'etc)))
     (if (string-contains? name ".")
         (let* ([split-name (string-split name ".")]
                [basename (car split-name)]
                [n (string->number (cadr split-name))])
           (with-syntax ([new-id
                          (format-id stx "~a" basename)]
                         [n n])
             (syntax/loc stx (fix new-id n))))
         (syntax/loc stx (#%top . etc)))]))

; extend as needed
(define (func-and . args)
  (andmap identity args))
