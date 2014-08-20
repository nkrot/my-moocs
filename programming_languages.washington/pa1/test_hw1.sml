(* tests for homework 1
   all tests should evaluate to true *)

use "hw1.sml";

(** test input data **)

(* d6 < d1 < d5 < d2 < d3 < d4 *)
val d1 = (1900,1,1)
val d2 = (2000,1,1)
val d3 = (2000,1,31)
val d4 = (2000,2,31)
val d5 = (1976,2,24)
val d6 = (1271,5,1)

val ldates = [d1,d4,d3,d6,d2,d5]

(* tests for is_older  *)

val test1_1 = is_older(d2, d1) = false

val test1_2 = is_older(d1, d2) = true
val test1_3 = is_older(d2, d2) = false

val test1_4 = is_older(d2, d3) = true

val test1_5 = is_older(d2, d4) = true
val test1_6 = is_older(d3, d4) = true

val test1_7 = is_older(d4, d3) = false

(**  tests for number_in_month **)

val test2_1 = number_in_month(ldates, 1) = 3
val test2_2 = number_in_month(ldates, 2) = 2
val test2_3 = number_in_month(ldates, 10) = 0
val test2_4 = number_in_month([], 10) = 0

(** tests for number_in_months **)

val test3_1 = number_in_months(ldates, [10,2]) = 2
val test3_2 = number_in_months(ldates, [1,2]) = 5
val test3_3 = number_in_months(ldates, [10,11,12,13]) = 0
val test3_4 = number_in_months(ldates, []) = 0

(** tests for dates_in_month **)

val test4_1 = dates_in_month(ldates, 1) = [d1,d3,d2]
val test4_2 = dates_in_month(ldates, 2) = [d4,d5]
val test4_3 = dates_in_month(ldates, 12) = []
val test4_4 = dates_in_month([], 1) = []
val test4_5 = dates_in_month([], 12) = []

(** tests for dates_in_months **)

val test5_1 = dates_in_months(ldates, [1,10]) = [d1,d3,d2]
val test5_2 = dates_in_months(ldates, [2,1]) = [d4,d5,d1,d3,d2]
val test5_3 = dates_in_months(ldates, [1,10,2]) = [d1,d3,d2,d4,d5]
val test5_4 = dates_in_months(ldates, [12,10]) = []
val test5_5 = dates_in_months([], [1,12]) = []

(** tests for gen_nth **)

val words = ["uno", "dos", "tres", "cuatro", "cinco", "seis"]

val test6_1 = get_nth(words, 1) = "uno"
val test6_2 = get_nth(words, 2) = "dos"
val test6_3 = get_nth(words, 6) = "seis"
(* val test6_4 = get_nth(words, 600) = "" let it crash *)

(** tests for date_to_string **)

val test7_1 = date_to_string((2013,1,20)) = "January 20, 2013"
val test7_2 = date_to_string((1976,2,24)) = "February 24, 1976"
val test7_3 = date_to_string((2012,12,22)) = "December 22, 2012"

(** tests for number_before_reaching_sum **)

val test8_1 = number_before_reaching_sum(10, [1,3,4,1,5]) = 4
val test8_2 = number_before_reaching_sum(10, [1,3,4,2,1]) = 3
val test8_3 = number_before_reaching_sum(1,  [1,3,4,2,1]) = 0
(* val test8_4 = number_before_reaching_sum(100,  [1,3,4,2,1]) = ? *)

(** tests for what_month **)

val test9_1 = what_month(31) = 1
val test9_2 = what_month(32) = 2
val test9_3 = what_month(256) = 9
val test9_4 = what_month(365) = 12

(** tests for month_range **)

val test10_1 = month_range(20, 29) = [1,1,1,1,1,1,1,1,1,1]
val test10_2 = month_range(3, 3) = [1]
val test10_3 = month_range(31 (*jan 31*), 31+2 (*feb 2*)) = [1,2,2]
val test10_4 = month_range(2, 1) = []

(** tests for oldest **)

val test11_1 = oldest([])      = NONE
val test11_2 = oldest(ldates)  = SOME d6
val test11_3 = oldest([d3])    = SOME d3
val test11_4 = oldest([d1,d6]) = SOME d6
val test11_5 = oldest([d6,d1]) = SOME d6
val test11_6 = oldest([d1,d1]) = SOME d1

(** time to go to bed **)
