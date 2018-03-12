fun countdown (x : int) =
    if x = 0 then []
    else x :: countdown(x - 1)

		       
fun append (xs : int list, ys :int list) =
    if null xs then ys
    else hd xs :: append(tl xs, ys)			
