#lang racket

(require srfi/61) ;; for vector-assoc-cool
(require "hw4.rkt") 

;(define lst (list 1 2 3 4))
;(append (cdr lst) (list 10 20))

;(define lst2 '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))
(define lst2 '(1 (2 . "b") (3 . "c") (4 . "d") (5 . "e")))
;(assoc 2 lst2)

(define vec (list->vector lst2))
(vector-length vec)
(vector-assoc 1 vec)
(vector-assoc 2 vec)
(vector-assoc 4 vec)
(vector-assoc 5 vec)
(vector-assoc 20 vec)

;;(vector-ref vec 20) out of range

;; question to ask in stackoverflow
;;
;; My question is about rewriting a nested if conditions to a single cond
;; with a branch having a local binding. I am very new to Racket, just making my first
;; steps, so if my question is stupid, please, be lenient.
;;
;; In brief the task is to write a function that takes a vector and searches a value in it.
;; The vector contains mixed stuff -- pairs and non-pairs.
;; The value of interest should be in the car of a pair.
;;
;; The working solution uses a recursive helper function with nested ifs

; [vlen (vector-length vec)]
; [find-in-vector
; (lambda (pos)
;  (if (= pos vlen)                               ;; if the end of the vector has been reached
;      #f                                         ;; then return false
;      (let ([el (vector-ref vec pos)])           ;; Otherwise, extract current element from the vector,
;        (if (and (pair? el) (equal? v (car el))) ;; if the element is a pair and its car is what we want
;            el                                   ;; then return the element
;            (find-in-vector (+ 1 pos))))))]      ;; otherwise keep searching the vector

;; I would like to rewrite it so that it uses cond that looks more compact.
;; The below code is a possible implementation. The problem is that (vector-ref vec pos)
;; is computed several times and this is what I would like to rewrite such that
;; it is computed only once, like in the previous implementation with nested ifs

; [vlen (vector-length vec)]
; [find-in-vector
;  (lambda (pos)
;    (cond [(= pos vlen) #f]
;          [(and (pair? (vector-ref vec pos))            ;; one
;                (equal? v (car (vector-ref vec pos))))  ;; two
;           (vector-ref vec pos)]                        ;; three is too many
;          [#t (find-in-vector (+ 1 pos))]))])

;; And this is what I achieved at most: one call to (vector-ref vec pos) in test-expr
;; and another call in result-expr

; (cond
;   [(= pos vlen) #f]
;   [(letrec ([el (vector-ref vec pos)])      ;; extract current element from the vector
;      (and (pair? el) (equal? v (car el))))  ;; and use it in conditionals
;    (vector-ref vec pos)]                    ;; again, extract and return. FIXIT
;   [#t (find-in-vector (+ 1 pos))]))])       ;; otherwise, keep searching

;; How can I further make `el` shared between the test-expr and result-expression?
;; And i would like `el` to remain local to this particular cond-branch.
;; The below code works incorrectly. AFAIU, the whole letrec expression is
;; viewed as a text-expr of the cond?

; (cond
;  [(= pos vlen) #f]
;  [(letrec ([el (vector-ref vec pos)])
;     (and (pair? el) (equal? v (car el)))
;     el)]
; [#t (find-in-vector (+ 1 pos))])

(define (vector-assoc-nested-if v vec)
  (letrec ([vlen (vector-length vec)]
           [find-in-vector
            (lambda (pos)
              (if (= pos vlen)
                  #f
                  (let ([el (vector-ref vec pos)])
                    (if (and (pair? el) (equal? v (car el)))
                         el
                         (find-in-vector (+ 1 pos))))))])
    (find-in-vector 0)))

(define (vector-assoc-ugly v vec)
  (letrec ([vlen (vector-length vec)]
           [find-in-vector
            (lambda (pos)
              (cond [(= pos vlen) #f]
                    [(and (pair? (vector-ref vec pos))
                          (equal? v (car (vector-ref vec pos))))
                     (vector-ref vec pos)]
                    [#t (find-in-vector (+ 1 pos))]))])
    (find-in-vector 0)))

(define (vector-assoc-less-ugly v vec)
  (letrec ([vlen (vector-length vec)]
           [find-in-vector
            (lambda (pos)
              (cond [(= pos vlen) #f]
                    [(letrec ([el (vector-ref vec pos)])
                       (and (pair? el) (equal? v (car el))))
                     (vector-ref vec pos)]
                    [#t (find-in-vector (+ 1 pos))]))])
    (find-in-vector 0)))

(define (vector-assoc-does-not-work v vec)
  (letrec ([vlen (vector-length vec)]
           [find-in-vector
            (lambda (pos)
              (cond [(= pos vlen) #f]
                    [(letrec ([el (vector-ref vec pos)])
                       (and (pair? el) (equal? v (car el)))
                     el)]
                    [#t (find-in-vector (+ 1 pos))]))])
    (find-in-vector 0)))


(define (find-in-vector-stackoverflow v vec)
  (define vlen (vector-length vec))
  (let loop ((pos 0))
    (cond
      [(= pos vlen) #f]
      ((vector-ref vec pos)
       (lambda (el) (and (pair? el) (equal? v (car el))))
       => values)
      [else (loop (add1 pos))])))

;; does not work
(define (vector-assoc-cool v vec)
  (letrec ([vlen (vector-length vec)]
           [find-in-vector
            (lambda (pos)
              (cond [(= pos vlen) #f]
                    [(vector-ref vec pos)
                     (lambda (el) (and (pair? el) (equal? v (car el))))
                     (values)]
;                     => values] ;; original answer
                    [#t (find-in-vector (+ 1 pos))]))])
    (find-in-vector 0)))



(vector-assoc-nested-if 5 vec)
(vector-assoc-less-ugly 5 vec)
(vector-assoc-nested-if 20 vec)
(vector-assoc-less-ugly 20 vec)

(vector-assoc-does-not-work 5 vec)
(vector-assoc-does-not-work 20 vec)

;(vector-assoc-cool 5 vec)
;(vector-assoc-cool 20 vec)

(find-in-vector-stackoverflow 5 vec)
(find-in-vector-stackoverflow 20 vec)
