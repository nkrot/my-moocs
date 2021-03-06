(* initial version by: Dan Grossman, Coursera PL, HW2 Provided Code

   The initial version was improved by Emacs and me ;-)
   Crappy indentation is "courtesy" of Emacs sml-mode.
 *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(*********************************************************************
  1. This problem involves using first-name substitutions to come up
  with alternate names. For example, Fredrick William Smith could also
  be Fred William Smith or Freddie William Smith. Only part (d) is
  specifically about this, but the other problems are helpful.
 *********************************************************************)

(*
  1a. Write a function all_except_option, which takes a string and a string list.
  Return NONE if the string is not in the list, else return SOME lst where
  lst is identical to the argument list except the string is not in it.
  You may assume the string is in the list at most once. Use same_string,
  provided to you, to compare strings. Sample solution is around 8 lines.
*)

(* this implementation deletes only the 1st occurrence of <option> *)
fun all_except_option (option : string, strings : string list) =
	let fun remove_from_list (option, strings, acc) =
			case strings of
			    [] => NONE
			  | str::tail => if same_string (option, str)
						     then SOME (acc@tail)
						     else remove_from_list(option, tail, acc @ [str])
	in
	    remove_from_list (option, strings, [])
	end
 
(* this implementation deletes all occurrences of <option>. *)
fun all_except_option2 (option : string, strings : string list) =
	let fun remove_from_list (item, list, acc, found) =
			case list of
				[] => if found
					  then SOME(acc)
					  else NONE
			  | str::tail => if same_string (item, str)
							 then remove_from_list(item, tail, acc, true)
							 else remove_from_list(item, tail, acc @ [str], found)
                                  
	in
		remove_from_list (option, strings, [], false)
	end
    

(*
 1b. Write a function get_substitutions1, which takes a string list list
     (a list of list of strings, the substitutions) and a string s and
     returns a string list. The result has all the strings that are in
     some list in substitutions that also has s, but s itself should not
     be in the result. Example:
     get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
						"Fred")
      answer: ["Fredrick","Freddie","F"]

    Assume each list in substitutions has no repeats. The result will have
    repeats if s and another string are both in more than one list in substitutions.
    Example:
      get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
                               "Jeff")
      answer: ["Jeffrey","Geoff","Jeffrey"]
    Use part (a) and ML’s list-append (@) but no other helper functions.
    Sample solution is around 6 lines.
*)

fun get_substitutions1 (substitutions : string list list, str : string) =
	case substitutions of
		[] => []
	  | head::tail => case (all_except_option(str, head), get_substitutions1(tail, str)) of
						  (NONE,   lst) => lst
	  					| (SOME l, lst) => l @ lst

(*
 1c. Write a function get_substitutions2, which is like get_substitutions1
     except it uses a tail-recursive local helper function.
*)

(* this is not tail recursive!*)
fun get_substitutions2 (substitutions : string list list, str : string) =
	let fun lprepend (src_list, res_list) =
			case src_list of
				[] => res_list
			  | hd::tl => hd::lprepend(tl, res_list)
	in
		case substitutions of
			[] => []
		  | hd::tl => case (all_except_option(str, hd), get_substitutions2(tl, str)) of
						  (NONE,   lst) => lst
	  					| (SOME l, lst) => lprepend(l, lst)
	end

(* this function should have been written like this:
fun get_substitutions2 (substitutions,str) =
    let fun loop (acc,substs_left) =
	    case substs_left of
		[] => acc
	      | x::xs => case all_except_option(str,x) of
                         NONE => loop(acc,xs)
                       | SOME y => loop(acc @ y,xs)
    in 
	loop ([],substitutions)
    end
*)

(*
 1d. Write a function similar_names, which takes a string list list of
     substitutions (as in parts (b) and (c)) and a full name of type
    {first:string,middle:string,last:string} and returns a list of full
    names (type {first:string,middle:string,last:string} list).
    The result is all the full names you can produce by substituting for
    the first name (and only the first name) using substitutions and
    parts (b) or (c). The answer should begin with the original name
    (then have 0 or more other names).
    Example: 
       similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
                       {first="Fred", middle="W", last="Smith"})
    answer: [{first="Fred",     last="Smith", middle="W"},
             {first="Fredrick", last="Smith", middle="W"},
             {first="Freddie",  last="Smith", middle="W"},
             {first="F",        last="Smith", middle="W"}]
    Hint: Use a local helper function. Sample solution is around 10 lines.
*)

fun similar_names (substitutions : string list list,
				   full_name : {first:string,middle:string,last:string}) =
	let fun build_full_names (synonyms, middle, last, acc) =
			case synonyms of
				[] => acc
			  | name::names' => build_full_names(names', middle, last, acc @ [{first=name,middle=middle,last=last}])
		val {first,middle,last} = full_name
	in
		full_name :: build_full_names (get_substitutions1 (substitutions, first),
									   middle, last, [])
	end

(* should have been written like this: vars are visible in the scope function is defined, hence
   no need to pass middle and last as args
fun similar_names (substitutions,name) =
    let 
        val {first=f, middle=m, last=l} = name
	fun make_names xs =
	    case xs of
		[] => []
	      | x::xs' => {first=x, middle=m, last=l}::(make_names(xs'))
    in
	name::make_names(get_substitutions2(substitutions,f))
    end
*)

(********************************************************************
  Problem 2: Solitaire Game
 ********************************************************************)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(*
 2a. Write a function card_color, which takes a card and returns its color
     (spades and clubs are black, diamonds and hearts are red).
     Note: One case-expression is enough.
*)

fun card_color (card: card) =
	case card of
		(Spades,_) => Black
	  | (Clubs,_)  => Black
	  | _          => Red


(*
 2b. Write a function card_value, which takes a card and returns
    its value (numbered cards have their number as the value, aces are 11,
    everything else is 10). Note: One case-expression is enough.
*)

fun card_value (card: card) =
	case card of
		(_,Num v) => v
	  | (_,Ace)   => 11
	  | _         => 10

(*
 2c. Write a function remove_card, which takes a list of cards cs,
	a card c, and an exception e.
	It returns a list that has all the elements of cs except c.
    If c is in the list more than once, remove only the first one.
    If c is not in the list, raise the exception e.
	You can compare cards with =
*)

fun remove_card (cards: card list, card: card, e: exn) =
	let fun remove (cards, card, kept) =
			case cards of
				[] => raise e
			  |	c::cs' => if card = c
						  then kept @ cs'
						  else remove (cs', card, c::kept)
	in
		remove (cards, card, [])
	end

(*
 2d. Write a function all_same_color, which takes a list of cards and
     returns true if all the cards in the list are the same color.
     Hint: An elegant solution is very similar to one of the functions
     using nested pattern-matching in the lectures.
*)

(*
  Algorithm:
  Take the color of the first card and go check if the next card is of
  the same color. Recurse until the first mismatch found, then false,
  otherwise true
*)
fun all_same_color (cards: card list) =
	let fun color_should_be (cards, color) =
			case cards of
			    []     => true
			  | c::cs' => if card_color(c) = color
						  then color_should_be(cs', color)
						  else false
	in
	    case cards of
		    []     => true (* oops, kinda surprising *)
	      | c::cs' => color_should_be (cs', card_color(c))
	end

(* should have been written like this:
fun all_same_color cs = 
    case cs of
      | head::neck::tail => card_color head = card_color neck 
			    andalso all_same_color(neck::tail)
      | _ => true
*)

(*
  Algorithm 2:
  Count all cards, count red cards;
  If both counts are equal or the count of red cards equal 0 -> true
  This algorithm is inefficient as it scans the *whole* list, meanwhile 
  it suffices to find the first mismatch to say 'false'.
*)
fun all_same_color2 (cards: card list) =
	let fun incr_if_red (card, count) =
			if card_color(card) = Red
			then count+1
			else count
	    fun count_red (cards, numall, numred) =
		    case cards of
			    []     => numall = numred orelse numred = 0
		      | c::cs' => count_red (cs', numall+1, incr_if_red(c,numred))
	in
	    count_red (cards, 0, 0)
	end

(*
 2e. Write a function sum_cards, which takes a list of cards and returns
     the sum of their values. 
	 Use a locally defined helper function that is tail recursive.
*)

fun sum_cards (cards: card list) =
	let fun sum (cards, total) =
			case cards of
			    []     => total
			  | c::cs' => sum(cs', total+card_value(c))
	in
	    sum (cards, 0)
	end

(*
  2f. Write a function score, which takes a card list (the held-cards)
      and an int (the goal) and computes the score as described above.

 Scoring rules:
 Let <sum> be the sum of the values of the held-cards.
 If <sum> is greater than <goal>, the preliminary score is three times (<sum> − <goal>),
 else the preliminary score is <goal> − <sum>.
 The score is the preliminary score unless all the held-cards are the
 same color, in which case the score is the preliminary score divided by 2
 (and rounded down as usual with integer division; use ML’s div operator).
*)

fun score (cards: card list, goal: int) =
    let fun pre_score (cards, goal) =
		    let val sum = sum_cards(cards)
		    in
			    if sum > goal
			    then 3 * (sum-goal)
			    else goal-sum
		    end										 
	in
		if all_same_color(cards)
		then pre_score(cards, goal) div 2
		else pre_score(cards, goal)
	end

(*
 2g. Write a function officiate, which 'runs a game.'
	It takes a card list (the card-list) and a move list (what the player 'does' at each point), 
    and an int (the goal) and returns the score at the end of the game after processing
    (some or all of) the moves in the move list in order.
    Use a locally defined recursive helper function that takes several arguments that
    together represent the current state of the game. As described above:
      * The game starts with the held-cards being the empty list.
      * The game ends if there are no more moves. (The player chose to stop since the move list
        is empty.)
      * If the player discards some card c, play continues (i.e., make a recursive call) 
        with the held-cards not having c and the card-list unchanged.
        If c is not in the held-cards, raise the IllegalMove exception.
      * If the player draws and the card-list is empty, the game is over. Else if drawing
        causes the sum of the held-cards to exceed the goal, the game is over.
        Else play continues with a larger held-cards and a smaller card-list.
*)

fun officiate (deck: card list, moves: move list, goal: int) =
    let fun play (deck, moves, goal, player_cards: card list) =
            case moves of
                []   => score (player_cards, goal) (* game over *)
              | (Discard c)::moves' => play(deck, moves', goal, remove_card(player_cards, c, IllegalMove))
              | Draw::moves' => case deck of
                                    [] => score (player_cards, goal) (* game over *)
                                  | c::deck' => let val player_cards = c::player_cards
                                                in
                                                    if sum_cards(player_cards) > goal
                                                    then score (player_cards, goal) (* game over *)
                                                    else play(deck', moves', goal, player_cards)
                                                end
    in
        play (deck, moves, goal, [])
    end

