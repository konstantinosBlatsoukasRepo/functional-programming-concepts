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
   
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove
	      
(* put your solutions for problem 2 here *)
	      
fun card_color (suit, rank) =
    case suit of
	Clubs => Black
      | Spades => Black
      | Hearts => Red
      | Diamons => Red

fun card_value (suit, rank) =
    case rank of 
       Num 1 => 1
     | Num 2 => 2
     | Num 3 => 3
     | Num 4 => 4
     | Num 5 => 5
     | Num 6 => 6
     | Num 7 => 7
     | Num 8 => 8
     | Num 9 => 9
     | Ace => 11
     | _ => 10 		   

fun remove_card (cs, c, e) =
    let
	fun aux_remove_card (cs, c, e, acc, count) =
	    case cs of
		[] => if count = 0 then raise e else acc
	  | hd::[] => if (c = hd andalso count = 0) then aux_remove_card ([], c, e, acc, count + 1)
		      else aux_remove_card ([], c, e, hd::acc, count)	 							 
	  | hd::tl => if (c = hd andalso count = 0) then aux_remove_card (tl, c, e, acc, count + 1)
		      else aux_remove_card (tl, c, e, hd::acc, count)	
    in
	aux_remove_card (cs, c, e, [], 0)
    end

fun all_same_color (cs : card list) =
    case cs of 
        [] => true
      | _::[] => true
      | head::(neck::rest) => (card_color(head)=card_color(neck) andalso 
all_same_color(neck::rest))
	
		 			       
fun sum_cards cs =
    let
	fun aux (cs, score) =
            case cs of
		[] => score
	  | hd::[] => aux([], score + card_value(hd))
	  | hd::tl => aux(tl, score + card_value(hd))
    in
	aux(cs, 0)
    end 

fun score (cs, goal) =
    let
	val sum = sum_cards cs
	val preliminary = if sum > goal then 3 * (sum - goal) else (goal - sum)   		    
    in
	if all_same_color(cs) then
	    preliminary div 2
	else
	    preliminary
    end	 

fun officiate (cardList, moves, goal) =
    let
	fun aux (heldCards, cardList, moves, goal) =
	    if sum_cards(heldCards) > goal
	    then score (heldCards, goal) 				  
	    else 
 		case moves of
		    [] => score (heldCards, goal)
		  | x::xs => case x of
				 Discard c => aux (remove_card (heldCards, c, IllegalMove), cardList, xs, goal)
			       | Draw => case cardList of
					     [] =>  score (heldCards, goal)
					   | y::ys => aux (y::heldCards, ys, xs, goal) 		 
    in
	aux([], cardList, moves, goal)
    end 	

	
