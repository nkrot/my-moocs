#lang racket

(require rackunit)
(require "hw5.rkt")

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
;(define test1
;  (mupllist->racketlist
;   (eval-exp (call (call mupl-mapAddN (int 7))
;                   (racketlist->mupllist 
;                    (list (int 3) (int 4) (int 9)))))))

(define test1_1 (racketlist->mupllist (list (int 1) (int 2) (int 3) (int 4))))

(check-equal? test1_1
              (apair (int 1) (apair (int 2) (apair (int 3) (apair (int 4) (aunit)))))
              "Testing racketlist->mupllist #1")

(check-equal? (mupllist->racketlist test1_1)
              (list (int 1) (int 2) (int 3) (int 4))
              "Testing mupllist->racketlist #1")

(check-equal? (racketlist->mupllist (list (var "s")))
              (apair (var "s") (aunit))
              "Test #2")

(check-equal? (racketlist->mupllist (list (var "foo") (int 4) (apair (int 2) (var "bar")) (var "baz")))
              (apair (var "foo") (apair (int 4) (apair (apair (int 2) (var "bar")) (apair (var "baz") (aunit)))))
              "Test #3")

(check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (apair (int 9) (aunit)))))
              (list (int 3) (int 4) (int 9))
              "Test #2")

;; 2
(check-equal? (eval-exp (ifgreater (int 1) (int 2) (add (int 10) (int 3)) (int 42)))
              (int 42)
              "Testing ifgreater 1 2")

(check-equal? (eval-exp (ifgreater (int 1) (int 2) (add (var "crashifevaluated") (int 3)) (int 42)))
              (int 42)
              "Testing ifgreater 1 2")

(check-equal? (eval-exp (ifgreater (int 2) (int 1) (int 42) (add (var "crashifevaluated") (int 3))))
              (int 42)
              "Testing ifgreater 2 1")

(define p2 (eval-exp (apair (int 7) (int 8))))
;
(check-equal? (eval-exp (fst p2)) (int 7) "Testing fst")

(check-equal? (eval-exp (snd p2)) (int 8) "Testing snd")

; incorrect: (add (int 1) (int 3)))
(check-equal? (eval-exp (fst (apair (add (int 1) (int 3)) (aunit)))) 
              (int 4)
              "Test complex fst/snd")

(check-equal? (int 1)
              (eval-exp (isaunit (aunit))) 
              "Test isaunit #1")

(check-equal? (int 0)
              (eval-exp (isaunit (int 1)))
              "Test isaunit #2")

(check-equal? (eval-exp (mlet "stupid" (int 42) (add (int 1) (var "stupid"))))
              (int 43)
              "Test mlet #1")

(check-equal?
 (eval-exp (mlet "x" (int 5) (mlet "x" (int 6) (var "x"))))
 (int 6)
 "Test mlet #2")

;; let ([f (lambda (x) (+ 5 x))] (f 3))
;; => 8
(check-equal? (eval-exp (mlet "f" (fun #f "x" (add (int 5) (var "x")))
                              (call (var "f") (int 3))))
              (int 8)
              "Test call #1")

(define test-fun-1 (eval-exp (fun "funk" "x" (add (int 42) (var "x")))))

(check-equal? (eval-exp (call test-fun-1 (int 3)))
              (int 45)
              "Testing call")

(define test-fun-2
  (eval-exp
   (mlet "ref" (int 42)
         (fun "funky" "zzz" (add (var "ref") (var "zzz"))))))

(check-equal? (eval-exp (call test-fun-2 (int 3)))
             (int 45)
              "Testing mlet+call")

(check-equal? (eval-exp (mlet "ref" (int 10) (call test-fun-2 (int 3))))
              (int 45)
              "Testing useless mlet and call")

(define test-sum-zero-thru-number
  (eval-exp
   (fun "sum-zero-thru-number" "num"
        (ifgreater (var "num") (int 0)
                   (add (var "num") (call (var "sum-zero-thru-number") (add (int -1) (var "num"))))
                   (int 0)))))

(check-equal? (eval-exp (call test-sum-zero-thru-number (int 10)))
              (int 55)
              "Testing recursive function")

;;;;; constructing the environment
;(define l1 (list (cons "a" 1) (cons "b" 2)))
;(define l2 (list (cons "c" 3) (cons "d" 4)))
;(define p (cons "z" 24))
;; all forms produce single level list of pairs
;ok (append l1 l2)
;ok (cons p l1)
;ok (cons p (append l1 l2))

;; 3
(check-equal? (eval-exp (ifaunit (int 6) (add (var "should fail") (int 1)) (int 42)))
              (int 42)
              "Testing ifaunit #1 - ze first branch")

(check-equal? (eval-exp (ifaunit (aunit) (int 42) (add (var "should fail") (int 1))))
              (int 42)
              "Testing ifaunit #2 - the second branch")

(check-equal? 
 (eval-exp
  (ifaunit (fst (apair (aunit) (int 0)))
           (int 4)
           (int 10)))
 (int 4)
 "Testing ifaunit #3")
 
;(check-equal? (eval-exp (mlet* (list (cons "a" (int 5)) (cons "b" (int 6))) (add (var "b") (var "a"))))
;              (int 11)
;              "Testing mlet*")


(check-equal? 
 (eval-exp
  (mlet* (list (cons "x" (int 1)))
         (var "x")))
 (int 1)
 "Testing mlet*")

(check-equal?
 (eval-exp
  (mlet* (list (cons "f" (int 2)) (cons "y" (int 15)))
         (add (var "f") (add (var "y") (int 3)))))
 (int 20)
 "Testing mlet* again")

(check-equal?
 (eval-exp
  (mlet* 
   (list (cons "w" (int 111)) 
         (cons "x" (add (var "w") (int 1)))
         (cons "y" (int -1))) 
   (add (var "x") (var "y"))))
 (int 111))

(check-equal?
 (eval-exp
  (ifeq (int 5) (int 5)
        (int 42)
        (add (int 0) (var "sucks"))))
 (int 42)
 "Testing ifeq 5 5")

(check-equal?
 (eval-exp
  (ifeq (int 6) (int 5)
        (add (int 0) (var "sucks"))
        (int 42)))
 (int 42)
 "Testing ifeq 6 5")

(check-equal?
 (eval-exp
  (ifeq (int 5) (int 6)
        (add (int 0) (var "should fail"))
        (int 42)))
 (int 42)
 "Testing ifeq 5 6")
