
fun lprepend (src_list, res_list) =
	case src_list of
		[] => res_list
	  | hd::tl => hd::lprepend(tl, res_list)

val test1 = lprepend([1,2,3], [11,12,13])
