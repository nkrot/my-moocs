
signature COUNTER =
sig
    type t
    val newCounter : int -> int
    val increment : t -> t
    val first_larger : t * t -> bool
end

structure NoNegativeCounter :> COUNTER = 
struct

exception InvariantViolated

type t = int

fun newCounter i = if i <= 0 then 1 else i

fun increment i = i + 1

fun first_larger (i1,i2) =
    if i1 <= 0 orelse i2 <= 0
    then raise InvariantViolated
    else (i1 - i2) > 0

end

(**)

val i3 = NoNegativeCounter.t 3

val i1 = NoNegativeCounter.newCounter ~5;
val i2 = NoNegativeCounter.newCounter ~1;

(* 13 *)
(* val _ = NoNegativeCounter.first_larger(i2, i1); *)

