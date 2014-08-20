(* Dan Grossman, Coursera PL, HW2 Provided Tests *)

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)

use "hw2provided.sml";

(********************************************************************)
(* problem 1a *)

(*
 this is valid: tail=[]
val (head::tail) = ["b"]
*)

val test_1a_1 = all_except_option ("a", [])         = NONE
val test_1a_2 = all_except_option ("a", ["b"])      = NONE
val test_1a_3 = all_except_option ("a", ["b", "c"]) = NONE

val test_1a_4 = all_except_option ("a", ["a"])           = SOME []
val test_1a_5 = all_except_option ("a", ["a", "b", "c"]) = SOME ["b", "c"]
val test_1a_6 = all_except_option ("a", ["b", "a", "c"]) = SOME ["b", "c"]
val test_1a_7 = all_except_option ("a", ["b", "c", "a"]) = SOME ["b", "c"]

val test_1a_8 = all_except_option ("a", ["b", "a", "c", "a"]) = SOME ["b", "c", "a"]
(* Quote: You may assume the string is in the list at most once 
   But... may <> must, so I delete all occurrences *)
val test_1a_9 = all_except_option2 ("a", ["b", "a", "c", "a"]) = SOME ["b", "c"]


(********************************************************************)
(* problems 1b and 1c *)

val names1 = [["Fred","Fredrick"], ["Elizabeth","Betty"], ["Freddie","Fred","F"]]
val names2 = [["Fred","Fredrick"], ["Jeff","Jeffrey"], ["Geoff","Jeff","Jeffrey"]]
val names3 = [["Fred","Fredrick"]]

val test_1b_1 = get_substitutions1 (names1, "Fred")  = ["Fredrick","Freddie","F"]
val test_1b_2 = get_substitutions1 (names2, "Jeff")  = ["Jeffrey","Geoff","Jeffrey"]
val test_1b_3 = get_substitutions1 (names2, "Vasya") = []

val test_1b_4 = get_substitutions1 ([],     "Fred")  = []
val test_1b_5 = get_substitutions1 (names3, "Fred")  = ["Fredrick"]
val test_1b_6 = get_substitutions1 (names3, "Vasya") = []


val test_1c_1 = get_substitutions2 (names1, "Fred")  = ["Fredrick","Freddie","F"]
val test_1c_2 = get_substitutions2 (names2, "Jeff")  = ["Jeffrey","Geoff","Jeffrey"]
val test_1c_3 = get_substitutions2 (names2, "Vasya") = []

val test_1c_4 = get_substitutions2 ([],     "Fred")  = []
val test_1c_5 = get_substitutions2 (names3, "Fred")  = ["Fredrick"]
val test_1c_6 = get_substitutions2 (names3, "Vasya") = []

(********************************************************************)
(* problem 1d *)

val test_1d_1 = similar_names(names1, {first="Fred", middle="W", last="Smith"} ) =
				[{first="Fred",     last="Smith", middle="W"},
				 {first="Fredrick", last="Smith", middle="W"},
				 {first="Freddie",  last="Smith", middle="W"},
				 {first="F",        last="Smith", middle="W"}]

val test_1d_2 = similar_names(names2, {first="Jeff", middle="W", last="Smith"} ) = 
				[{first="Jeff",    last="Smith", middle="W"},
				 {first="Jeffrey", last="Smith", middle="W"},
				 {first="Geoff",   last="Smith", middle="W"},
				 {first="Jeffrey", last="Smith", middle="W"}]

val test_1d_3 = similar_names([], {first="Fred", middle="W", last="Smith"} ) =
				[{first="Fred",     last="Smith", middle="W"}]

(********************************************************************)
(* problem 2a *)

val ClubsJack   = (Clubs,Jack)
val ClubsQueen  = (Clubs,Queen)
val ClubsAce    = (Clubs,Ace)

val Diamonds7    = (Diamonds,Num(7))
val DiamondsKing = (Diamonds,King)
val DiamondsAce  = (Diamonds,Ace)

val Hearts8   = (Hearts,Num(8))
val HeartsAce = (Hearts,Ace)

val Spades8   = (Spades,Num(8))
val SpadesAce = (Spades,Ace)


val test_2a_1 = card_color ClubsJack  = Black
val test_2a_2 = card_color SpadesAce  = Black
val test_2a_3 = card_color Diamonds7  = Red
val test_2a_4 = card_color Hearts8    = Red

(********************************************************************)
(* problem 2b *)

val test_2b_1 = card_value ClubsJack  = 10
val test_2b_2 = card_value SpadesAce  = 11
val test_2b_3 = card_value Diamonds7  = 7
val test_2b_4 = card_value Hearts8    = 8

(********************************************************************)
(* problem 2c *)

val cards1 = [ClubsJack, Spades8]
val cards2 = [ClubsAce, SpadesAce, ClubsAce, SpadesAce]
val cards3 = [ClubsAce, DiamondsKing]
val cards4 = [DiamondsKing, Hearts8]

val test_2c_1 = remove_card (cards1, ClubsJack, IllegalMove) = [Spades8]
val test_2c_2 = remove_card (cards1, Spades8,   IllegalMove) = [ClubsJack]
val test_2c_3 = remove_card (cards2, SpadesAce, IllegalMove) = [ClubsAce, ClubsAce, SpadesAce]
val test_2c_4 = remove_card (cards2, ClubsAce,  IllegalMove) = [SpadesAce, ClubsAce, SpadesAce]
val test_2c_5 = (remove_card (cards2, Spades8, IllegalMove) handle IllegalMove => []) = []

(********************************************************************)
(* problem 2d *)

val test_2d_1 = all_same_color cards2 = true
val test_2d_2 = all_same_color cards4 = true
val test_2d_3 = all_same_color cards3 = false
val test_2d_4 = all_same_color [ClubsAce] = true
val test_2d_5 = all_same_color [DiamondsKing] = true

val test_2d_6 = all_same_color [] = true

(********************************************************************)
(* problem 2e *)

val test_2e_1 = sum_cards cards2 = 44
val test_2e_2 = sum_cards cards3 = 21
val test_2e_3 = sum_cards cards4 = 18
val test_2e_4 = sum_cards (cards3@cards4) = 39
val test_2e_5 = sum_cards [Hearts8] = 8
val test_2e_6 = sum_cards [] = 0

(********************************************************************)
(* problem 2f *)

val test_2f_1 = score(cards3, 21) = 0
val test_2f_2 = score(cards3, 25) = 4
val test_2f_3 = score(cards3, 17) = 12
val test_2f_4 = score([],20) = 10

(*val test_2f_5 = score([HeartsAce],20) = 10*)

(********************************************************************)
(* problem 2g *)

val test_2g_1 = officiate(cards2, [Draw,Draw,Draw,Draw,Draw], 42) = 3

val test_2g_2 = officiate(cards2, [Draw,Draw,Draw,Draw,Draw], 30) = 4
val test_2g_3 = officiate(cards2, [Draw,Draw,Draw,Draw,Draw], 22) = 16
val test_2g_4 = officiate(cards2, [Draw,Draw,Draw,Draw,Draw], 100) = 28
val test_2g_5 = officiate(cards2, [Draw,Draw,Draw,Draw,Draw], 44) = 0


val test_2g_6 = officiate([ClubsQueen,DiamondsAce,HeartsAce,DiamondsAce],
                       [Draw,Discard(Clubs,Queen),Draw,Draw], 11) = 16

val test_2g_7 = officiate([ClubsQueen,DiamondsAce,ClubsAce,HeartsAce], 
						  [Draw,Discard(Clubs,Queen),Draw,Draw], 22) = 0


fun provided_test1 () = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
		val moves = [Draw,Discard(Hearts,Jack)]
    in
		officiate(cards,moves,42)
    end

fun provided_test2 () = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
		val moves = [Draw,Draw,Draw,Draw,Draw]
    in
 		officiate(cards,moves,42)
    end
