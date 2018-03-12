(* this is a comment. This is our first program. *)
val x = 34;
(* static enviroment: x : int *)
(* dynamic enviroment: x --> 34 *)

val y = 17;
(* static enviroment: x : int *, y : int *)
(* dynamic enviroment: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2);
(* static enviroment: x : int *, y : int *, z: int *)
(* dynamic enviroment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1
(* static enviroment: x : int *, y : int *, z: int *, q: int *)
(* dynamic enviroment: x --> 34, y --> 17, z --> 70, w -> 71*)
		
val abs_of_z = if z < 0 then 0 - z else z; (* bool *) (* int *)
(* abs_of_z : int *)
(* dynamic enviroment: x --> 34, y --> 17, z --> 70, w -> 71, abs_of_z --> 71 *)

val abs_of_z_simpler = abs z

fun max (xs : int list) =
    if null xs then 0
    else if (null (tl xs))  then hd xs
    else
	let
	    val max = hd xs
			 
	    fun inner_max (max : int, xs : int list) =
		if null xs then max
		else if (hd xs > max) then inner_max(hd xs, tl xs)
		else inner_max(max, tl xs)		 
	in
	    inner_max(max, xs)
	end

			   
    
