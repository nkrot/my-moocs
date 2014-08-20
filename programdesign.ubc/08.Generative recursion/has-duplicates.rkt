;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname has-duplicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

(define L0 empty)
(define L1 (list 1))
(define L2 (list 1 0))
(define L3 (list 1 1))
(define L4 (list 0 0 1 2))
(define L5 (list 0 1 1 3 5))
(define L6 (list 0 1 2 3 5 5))
(define L7 (list 0 1 2 3 5 6))

(check-expect (has-duplicates? L0) false)
(check-expect (has-duplicates? L1) false)
(check-expect (has-duplicates? L2) false)
(check-expect (has-duplicates? L3) true)
(check-expect (has-duplicates? L4) true)
(check-expect (has-duplicates? L5) true)
(check-expect (has-duplicates? L6) true)
(check-expect (has-duplicates? L7) false)

(define (has-duplicates? lst)
  (cond [(empty? lst) false]
        [(empty? (rest lst)) false]
        [else
         (if (equal? (first lst)
                     (first (rest lst)))
             true
             (has-duplicates? (rest lst)))]))

