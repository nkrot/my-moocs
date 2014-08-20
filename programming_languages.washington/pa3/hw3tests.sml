(*
  tests for PA3
*)

use "hw3.sml";

(********************************************************************)
(* problem 1 *)

val mc_words = ["Linux", "GNU", "godisnowhere", "Antananarivo", "frogramming"]
val lc_words = ["apple", "tea", "freak", "bag"]
val uc_words = ["Monday", "Spring", "Sunday", "Summer"]

val test_1_1 = only_capitals [] = []
val test_1_2 = only_capitals mc_words = ["Linux", "GNU", "Antananarivo"]
val test_1_3 = only_capitals lc_words = []
val test_1_4 = only_capitals uc_words = uc_words
val test_1_5 = only_capitals ["A","b","c","d","E"] = ["A","E"]

(********************************************************************)
(* problems 2 and 3 *)

val test_2_1 = longest_string1 [] = ""
val test_2_2 = longest_string1 ["one"] = "one"
val test_2_3 = longest_string1 mc_words = "godisnowhere"
val test_2_4 = longest_string1 lc_words = "apple" (* the 1st longest *)

val test_3_1 = longest_string2 [] = ""
val test_3_2 = longest_string2 ["one"] = "one"
val test_3_3 = longest_string2 mc_words = "Antananarivo"
val test_3_4 = longest_string2 lc_words = "freak" (* the last longest *)

(********************************************************************)
(* problems 4 *)

val test_4a_1 = longest_string3 [] = ""
val test_4a_2 = longest_string3 ["one"] = "one"
val test_4a_3 = longest_string3 mc_words = "godisnowhere" (* the 1st longest *)
val test_4a_4 = longest_string3 lc_words = "apple" (* the 1st longest *)

val test_4b_1 = longest_string4 [] = ""
val test_4b_2 = longest_string4 ["one"] = "one"
val test_4b_3 = longest_string4 mc_words = "Antananarivo" (* the last longest*)
val test_4b_4 = longest_string4 lc_words = "freak" (* the last longest *)

(********************************************************************)
(* problem 5 *)

val test_5_1 = longest_capitalized [] = ""
val test_5_2 = longest_capitalized ["one"] = ""
val test_5_3 = longest_capitalized lc_words = ""
val test_5_4 = longest_capitalized ["Sunday"] = "Sunday"
val test_5_5 = longest_capitalized mc_words = "Antananarivo"

(********************************************************************)
(* problem 6 *)

val test_6_1 = rev_string "" = ""
val test_6_2 = rev_string "Abba" = "abbA"

(********************************************************************)
(* problem 7 *)

fun is_even x =
    if x mod 2 = 0 then SOME([x]) else NONE

(*val t1 = is_even(2) *)

val test_7_1 =  first_answer is_even [1,2,3,4,5,6] = [2]
val test_7_2 =  first_answer is_even [1,3,5,6] = [6]

val test_7_3 = (first_answer is_even []      handle NoAnswer => [0]) = [0];
val test_7_4 = (first_answer is_even [1,3,5] handle NoAnswer => [0]) = [0];

(*
val test_7b_1 =  first_answer2 is_even [1,2,3,4,5,6] (*= [2]*)
val test_7b_2 =  first_answer2 is_even [1,3,5,6] (*= [6]*)
*)

(********************************************************************)
(* problem 8 *)

val test_8_1 = all_answers is_even [1,2,3,4,5,6] = NONE
val test_8_2 = all_answers is_even [2,4,6] = SOME([2,4,6])
val test_8_3 = all_answers is_even [] = SOME([])

(********************************************************************)
(* problems 9 *)

val pat1 = TupleP [Wildcard,
				   Wildcard,
				   UnitP,
				   Wildcard,
				   Variable "qwerty",
				   Wildcard]

val pat2 = TupleP [ConstP 12,
				   Variable "var1",
				   ConstructorP("constr1", Variable "hello"),
				   ConstructorP("constr2", Wildcard)]

val pat3 = TupleP [Variable "var",
				   Wildcard,
				   TupleP([Variable "var",
						   Wildcard,
						   TupleP([Variable "var",
								   Wildcard])])]
val pat4 = TupleP [Variable "var1",
				   Wildcard,
				   TupleP([Variable "var2",
						   Wildcard,
						   TupleP([Variable "var3",
								   Wildcard])])]

val test_9a_1 = count_wildcards pat1 = 4
val test_9a_2 = count_wildcards pat2 = 1
val test_9a_3 = count_wildcards pat3 = 3
val test_9a_4 = count_wildcards UnitP = 0


val test_9b_1 = count_wild_and_variable_lengths pat1 = 10
val test_9b_2 = count_wild_and_variable_lengths pat2 = 10;
val test_9b_3 = count_wild_and_variable_lengths pat3 = 12;
val test_9b_4 = count_wild_and_variable_lengths UnitP = 0;

val test_9c_1 = count_some_var ("qwerty",  pat1)  = 1
val test_9c_2 = count_some_var ("querty",  pat1)  = 0
val test_9c_3 = count_some_var ("var",     UnitP) = 0
val test_9c_4 = count_some_var ("var",     pat3)  = 3
val test_9c_5 = count_some_var ("constr1", pat2)  = 0 (* 1 ???*)


(********************************************************************)
(* problems 10 *)

val test_10_1 = check_pat UnitP = true
val test_10_2 = check_pat pat3  = false
val test_10_3 = check_pat pat4  = true

(******************************************************************)
(* problems 11 *)


(********************************************************************)
(* problems 12 *)


val list = [(4,19), (1,20), (74,75)]
val (a,b)::(c,d)::(e,f)::g = list

