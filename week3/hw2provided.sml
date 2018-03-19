(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) = s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (name, names) =
    let
	fun help_all_except_option (name, names, acc) =
	    case names of
		[] => (case acc of
			  [] => NONE
			 | _ => SOME acc) 			    
	      | hd::[] => if same_string(name, hd) then			      
		            (case acc of
			       [] => NONE
			     | _  => SOME acc)				
   			  else SOME (hd :: acc)
	      | hd::tl => if same_string(name, hd) then help_all_except_option (name, tl, acc)
			  else help_all_except_option (name, tl, hd :: acc)			     	     				    
    in
	help_all_except_option(name, names, [])
    end
    					   
fun get_substitutions1 (substitutionStringListList, str) = 
    case substitutionStringListList of
	[] => []
      | x :: x' => case all_except_option (str, x) of 
		       NONE => get_substitutions1 (x', str)
		     | SOME i => i @ get_substitutions1 (x', str)

fun get_substitutions2 (substitutionStringListList, str) =     
	let
	    fun aux (substitutionStringListList, str, acc) =
		case substitutionStringListList of
		    [] => acc
		  | x :: x' => case all_except_option (str, x) of
				   NONE => aux(x', str, acc)
				 | SOME i => aux(x', str, i @ acc)
        in
	    aux (substitutionStringListList, str, [])
	end

fun similar_names (substitutionStringListList, {first, middle, last}) =
    let
	val subs = get_substitutions1(substitutionStringListList, first)
	fun aux_similar_names (subs, aux_first, aux_middle, aux_last, acc) =
	    case acc of
		[] => aux_similar_names (subs, first, middle, last, {first = aux_first, middle = aux_middle, last = last}::acc)
	     | _ => case subs of
			[] => acc
		      | x :: xs  => aux_similar_names (xs, first, middle, last, {first = x, middle = aux_middle, last = last}::acc)	    
    in
	 aux_similar_names(subs, first, middle, last, [])	      
    end	
     
    
	    
(*case all_except_option (str, x) of 
		       NONE => get_substitutions2 (x', str)
		     | SOME i => i @ get_substitutions2 (x', str)*) 							
   
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
