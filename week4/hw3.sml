(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

			       (**** you can put all your code here ****)
fun only_capitals stringList = List.filter (fn s => Char.isUpper(String.sub(s, 0))) stringList;

fun longest_string1 stringList = foldl (fn (x, y) => if String.size y >= String.size x then y else x) "" stringList;

fun longest_string2 stringList = foldl (fn (x, y) => if String.size y > String.size x then y else x) "" stringList;

fun longest_string3 stringList = longest_string1 stringList;

fun longest_string4 stringList = longest_string2 stringList;

fun longest_string_helper inputFun stringList = foldl (fn (x, y) => if inputFun(String.size x, String.size y) then y else x) "" stringList;

fun longest_capitalized stringList =(longest_string1 o only_capitals) stringList;

fun rev_string inputString = implode (rev (String.explode inputString));

fun first_answer g aList =
    case aList of
	[] => raise NoAnswer
      | hd::tl =>  case g(hd) of
		     NONE => first_answer g tl
		   | SOME x => x 

fun all_answers g aList = 
    let
	fun fun_acc acc = 
	    case aList of
		[] => SOME acc
	      | hd::tl => case g(hd) of
			      NONE => NONE
			    | SOME x => fun_acc (x @ acc)
    in
	fun_acc []
    end

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end
	
fun count_wildcards p = g (fn x => 1) (fn y => 0) p

fun count_wild_and_variable_lengths p =
    g (fn () => 1) (fn y => String.size y) p

fun count_some_var (value, p) =
    g (fn () => 0) (fn y => if y = value then 1 else 0) p

(* 10. *)
fun check_pat p =
    let
	fun filterString pat acc = case pat of
				       Variable x => x :: acc
				     | ConstructorP (_, p) => filterString p acc
				     | TupleP ps =>
				       List.foldl
					   (fn (p, acc) => (filterString p []) @ acc) [] ps
				     | _ => []
    in
	let
	    val strList = filterString p []
	    fun checkDuplicate remList = 
		case remList of
		    [] => true
		  | x :: xs => if List.exists (fn item => item = x) xs
			       then false
			       else checkDuplicate xs
	in
	    checkDuplicate strList
	end
    end

(* 11. *)
fun match (v, p) =
    case p of
	Wildcard => SOME []
      | UnitP => (case v of Unit => SOME []
			  | _ => NONE)
      | Variable str => SOME [(str, v)]
      | ConstP i => (case v of Const j => if i = j then SOME [] else NONE
			     | _ => NONE)
      | TupleP plst => (case v of
			    Tuple vlst => if List.length plst = List.length vlst
					  then all_answers match (ListPair.zip (vlst, plst))
					  else NONE
			  | _ => NONE)
      | ConstructorP (str, pt) => (case v of
				       Constructor (vstr, vval) => if str = vstr
								   then match (vval, pt)
								   else NONE
				     | _ => NONE)

(* 12. *)
fun first_match v plst =
    SOME (first_answer (fn p => match (v, p)) plst)
handle NoAnswer => NONE

	
