
fun number_before_reaching_sum (sum : int, lst : int list) =
    if null lst orelse sum <= hd lst
    then 0
    else 1 + number_before_reaching_sum(sum - hd lst, tl lst)

val res1 = number_before_reaching_sum (10, [5,4,2,3]) = 2
val res2 = number_before_reaching_sum (10, []) = 0


