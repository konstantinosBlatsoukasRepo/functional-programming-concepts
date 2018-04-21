fun power (x: int, y: int) =
    if y = 0 then 1 else x * power(x, y - 1)

				  
fun sum (x: int, y: int) = x + y

fun voidEx () = 5 + 6;				   
				  
fun find_minimum (aList: int list) =
    if null aList
    then NONE
    else	
	let
	    fun inner_min (bList: int list, innerMin: int) =
		if null bList
		then SOME innerMin
		else if hd bList < innerMin
		then inner_min (tl bList, hd bList)
		else inner_min (tl bList, innerMin) 		   
	in
	    inner_min (aList, 1000)
	end
				  
