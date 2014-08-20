(* University of Washington, Programming Languages, Homework 7
   hw7testsprovided.sml *)
(* Will not compile until you implement preprocess and eval_prog *)

(* These tests do NOT cover all the various cases, especially for intersection *)

use "hw7.sml";

(* Must implement preprocess_prog and Shift before running these tests *)

fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;

(* Preprocess tests *)
let
	val Point(a,b) = preprocess_prog(LineSegment(3.2,4.1,3.2,4.1))
	val Point(c,d) = Point(3.2,4.1)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess converts a LineSegment to a Point successfully\n")
	else (print "preprocess does not convert a LineSegment to a Point succesfully\n")
end;

let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(1.1,2.0,1.1,~2.0))
	val LineSegment(e,f,g,h) = LineSegment(1.1,~2.0,1.1,2.0)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper vertical LineSegment successfully - 2\n")
	else (print "preprocess does not flip an improper vertical LineSegment successfully - 2\n")
end;

let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,5.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,5.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully - 3\n")
	else (print "preprocess does not flip an improper LineSegment successfully - 3\n")
end;

let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,10.1,1.1))
	val LineSegment(e,f,g,h) = LineSegment(3.2,4.1,10.1,1.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess does not flip a proper LineSegment\n")
	else (print "preprocess flips a proper LineSegment erroneously\n")
end;

(* eval_prog tests with Shift*)
let 
	val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with empty environment worked\n")
	else (print "eval_prog with empty environment is not working properly\n")
end;

let 
    val Line(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Line(4.0,4.0))), []))
    val Line(c,d) = Line(4.0,~4.0) 
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "shift works with Line\n")
    else (print "shift does NOT work with Line\n")
end;

let 
    val VerticalLine(a) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, VerticalLine(4.0))), []))
    val VerticalLine(c) = VerticalLine(7.0) 
in
    if real_equal(a,c)
    then (print "shift works with VerticalLine\n")
    else (print "shift does NOT work with VerticalLine\n")
end;

let 
    val LineSegment(a, b, a1, b1) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, LineSegment(4.0, 3.0, 12.0, ~2.0))), []))
    val LineSegment(c, d, c1, d1) = LineSegment(7.0, 7.0, 15.0, 2.0) 
in
    if real_equal(a,c) andalso real_equal(b, d) andalso real_equal(a1, c1) andalso real_equal(b1, d1)
    then (print "shift works with LineSegment\n")
    else (print "shift does NOT work with LineSegment\n")
end;

(* Using a Var *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with 'a' in environment is working properly\n")
	else (print "eval_prog with 'a' in environment is not working properly\n")
end;


(* With Variable Shadowing *)
let 
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
	val Point(c,d) = Point(7.0,8.0) 
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with shadowing 'a' in environment is working properly\n")
	else (print "eval_prog with shadowing 'a' in environment is not working properly\n")
end;

let
	val Point(a,b) = (eval_prog (preprocess_prog(Intersect(LineSegment(~3.7,1.5,~3.7,1.5), LineSegment(~3.7,1.5,~3.7,1.5))), []));
	val Point(c,d) = Point(~3.7,1.5)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess_prog handles Intersect type\n")
	else (print "preprocess_prog does not handle Intersect type\n")
end;

let
	val Point(a,b) = eval_prog(preprocess_prog(Let ("x", LineSegment(~3.7,1.5,~3.7,1.5),LineSegment(~3.7,1.5,~3.7,1.5))), [])
	val	Point(c,d) = Point(~3.7,1.5)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess_prog handles Let type correctly\n")
	else (print "preprocess_prog does not handle Let type\n")
end;

(* preprocess_prog(Shift(1.0,1.0,LineSegment(1.0,1.0,0.0,0.0))); *)

let
	val LineSegment(a1,b1,c1,d1) = eval_prog(preprocess_prog(Shift(1.0,1.0,LineSegment(1.0,1.0,0.0,0.0))), []);
	val	LineSegment(a2,b2,c2,d2) = LineSegment(1.0,1.0,2.0,2.0);
in
	if real_equal(a1,a2) andalso real_equal(b1,b2) andalso real_equal(c1,c2) andalso real_equal(d1,d2)
	then (print "Shift handles LineSegment type correctly\n")
	else (print "Shift does not handle LineSegment type\n")
end;

(*
preprocess_prog(Shift(5.5,~1.2,LineSegment(~3.7,1.5,~3.7,1.5)));
eval_prog(preprocess_prog(Shift(5.5,~1.2,LineSegment(~3.7,1.5,~3.7,1.5))), []);
*)

let
	val Point(a,b) = eval_prog(preprocess_prog(Shift(5.5,~1.2, LineSegment(~3.7,1.5,~3.7,1.5))), []);
	val	Point(c,d) = Point(1.8,0.3);
in
	if real_close_point (a,b) (c,d)
	then (print "preprocess_prog handles Shift type correctly\n")
	else (print "preprocess_prog does not handle Shift type\n")
end;

(*
eval_prog(preprocess_prog(Intersect(LineSegment(1.0,1.0,0.0,0.0),LineSegment(1.0,1.0,0.0,0.0))), []);

expected Intersect(LineSegment(0.0,0.0,1.0,1.0),LineSegment(0.0,0.0,1.0,1.0))
*)

(* ok
preprocess_prog(Let ("y",LineSegment(1.0,1.0,0.0,0.0),LineSegment(1.0,1.0,0.0,0.0)))
 was expected to preprocess to Let ("y",LineSegment(0.0,0.0,1.0,1.0),LineSegment(0.0,0.0,1.0,1.0)) *)


