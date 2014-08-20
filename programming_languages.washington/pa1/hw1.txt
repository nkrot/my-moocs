(*
 homework 1 by Nikolai Krot (skype:krot_nik)

 code intendation is the courtesy of Emacs SML mode ;-)
*)

fun is_older (date1 : int*int*int, date2 : int*int*int) =
	let
		val equal_year  = (#1 date1) = (#1 date2)
		val equal_month = (#2 date1) = (#2 date2)
		val older_year  = (#1 date1) < (#1 date2)
		val older_month = (#2 date1) < (#2 date2)
		val older_day   = (#3 date1) < (#3 date2)
	in
		older_year orelse
		equal_year andalso older_month orelse
		equal_year andalso equal_month andalso older_day
	end

fun number_in_month (ldates : (int*int*int) list, month : int) =
	if null ldates
	then 0
	else
		let
			val found = if (#2 (hd ldates)) = month then 1 else 0
		in
			found  + number_in_month(tl(ldates), month)
		end

fun number_in_months (ldates : (int*int*int) list, months : int list) =
	if null months
	then 0
	else number_in_month(ldates, (hd months)) (* count dates containing the 1st month from <months> *)
		 + number_in_months(ldates, (tl months))

fun dates_in_month (ldates : (int*int*int) list, month : int) =
	if null ldates
	then ldates
	else
		let
			val first_date = hd ldates
			val found_dates = dates_in_month((tl ldates), month)
		in
			if (#2 first_date) = month
			then first_date::found_dates
			else found_dates
		end

fun dates_in_months (ldates : (int*int*int) list, months : int list) =
	if null months
	then []
	else dates_in_month(ldates, (hd months)) @ dates_in_months(ldates, (tl months))

fun get_nth (strings : string list, num : int) =
	if num = 1
	then hd(strings)
	else get_nth((tl strings), num-1)

fun date_to_string (date : (int*int*int)) =
	let
		val months = ["January",   "February",
					  "March",     "April",   "May",
					  "June",      "July",    "August",
					  "September", "October", "November",
					  "December"]
	in
		get_nth(months, (#2 date))  ^ " "  (* month name *)
			^ Int.toString(#3 date) ^ ", " (* day *)
			^ Int.toString(#1 date)        (* year *)
	end

fun number_before_reaching_sum (sum : int, numbers : int list) =
	if null numbers
	then 0
	else
		let
			val diff = sum - (hd numbers)
		in
			if diff > 0
			then (* still less than <sum>. keep scanning the tail of the list *)
				1 + number_before_reaching_sum(diff, (tl numbers))
			else (* desired sum has been reached or surpassed *)
				0
		end

fun what_month (day_number : int) =
	let
		(* the number of days in each month, starting from January. *)
		val numdays_in_month = [31,28, 31,30,31, 30,31,31, 30,31,30, 31]
	in
		1 + number_before_reaching_sum(day_number, numdays_in_month)
	end

(* Goal: for each day between day1 and day2 (endpoints inclusive) find out
   the month the day belongs to and return a complete non-uniqued list of
   such months *)
fun month_range (day1 : int, day2 : int) =
	if day1 > day2
	then []
	else what_month(day1)::(month_range(day1+1, day2))

fun oldest (dates : (int*int*int) list) =
	if null dates
	then NONE
	else
		let
			(*******************************************************************
			 Algo: compare the 1st and the 2nd items of the list and build a new
			 list that contains the older of the two items (the 1st or the 2nd),
			 and the rest of the list (items 3 through the last one).
			 Recurse with the newly constructed list until only one item remains
			 in the list, which is the oldest date.
			 *******************************************************************)
			fun find_oldest_date (dates : (int*int*int) list) =
				let
					val first = hd dates
					val other = tl dates
				in
					if null other
					then [first] (* the only remaining item is the one we want *)
					else if is_older(first, (hd other))
					then find_oldest_date(first::(tl other)) (* a list w/o the 2nd item *)
					else find_oldest_date(other) (* a list w/o the 1st item *)
				end
		in
			SOME (hd (find_oldest_date dates))
		end
