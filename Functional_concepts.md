# Basic Functional concepts (ML)
## First part (Shadowing, Function, Tuples, Lists, Option)

### Shadowing
When in an already defined varaible you assign again a different value/binding
```sml
- val a = 2;
val a = 2 : int (*a here is bound to 2*)
- val a = 3; (*now a is bound to 3, in this case a "shadows" the previous binding*)
val a = 3 : int
```
### Function
A piece of code that takes some arguments (might not) and returns a value (might not)
```sml
fun sum (x: int, y: int) = x + y
```
The above function named sum, takes two arguments x and y, and returns 
the sum of x and y
```sml
- sum(1, 2);
val it = 3 : int
```

The following example demonstrates that a function might not have any arguments
but can return a value
```sml
fun voidEx () = 5 + 6;	
```
if you call the above function you will get 11 (see the empty brackets, this means no arguments)
```sml
- voidEx();
val it = 11 : int
```
### Tuples (data structure)
A data structure that is able to hold diffrent type values, for example
```sml
- val firstTuple = (34, "giovanni")
val firstTuple = (34,"giovanni") : int * string
```
in the above example firstTuple holds a integer (34) and a string ("giovanni").
 - How to access the tuple values
by adding a hash tag with a number and the name of the tuple, see bellow
```sml
- #1 firstTuple;
val it = 34 : int
- #2 firstTuple;
val it = "giovanni" : string
```
### List (data structure)
A data structure that is able to hold values of the same type, for example you can have a list of ints or a list of strings but a mix
```sml
- val listAlpha = ["apple", "orange", "banana"];
val listAlpha = ["apple","orange","banana"] : string list

- val listBeta = [1, 2, 3, 4, 5];
val listBeta = [1,2,3,4,5] : int list
```
In the previous snippet there are two lists, one that holds three strings (listAlpha) and another one that holds five integers (listBeta).
Let's try to create a mix list
```sml
- val badList = [1, 2, "kostas"];
stdIn:14.15-14.31 Error: operator and operand don't agree [overload conflict]
  operator domain: [int ty] * [int ty] list
  operand:         [int ty] * string list
  in expression:
    2 :: "kostas" :: nil11
```
As expected we are getting an error

 - how to access the list values
Every list (a non empty) is composed by two parts the head and the tail.
Head is the first value in the list and the tail is the remaining list,
for exapmle 
```sml
- val listAlpha = ["apple", "orange", "banana"];
val listAlpha = ["apple","orange","banana"] : string list
```
listAlpha has as a head the value "apple" and as a tail the remaining list ["orange", "banana"] 
 - how you can get the head and the tail
 - in ML you can take the head by writting the keyword hd and the list
 ```sml
 - hd listAlpha;
val it = "apple" : string
 ```
 - similarly you can take the tail, but in this case you are getting a list
and not a value
```sml
- tl listAlpha;
val it = ["orange","banana"] : string list
```
### Option 
Is a much more elegant way to say that the output of my function might return nothing (much better than returning a null or nil)
for example, let's say that you have a function that returns the minimum integer in list of integers, if the list is empty? what are you going to return? an elegant solution is an option 
```sml
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
```
In the above example I assume that in the list all the integers are smaller than 1000. The above solution is much more elegant than ,for example, return nil or a default value. Moreover, you can access the result by using isSome and valOf, for example
```sml
- val result = find_minimum ([20, 31, 42, 5]);
val result = SOME 5 : int option
- valOf result;
val it = 5 : int
```
## Second part (Pattern matching, tail recursion)

### Pattern matching
It's like a switch statement but not necessarily for some kind of enumeration only.
Let me give you an example, the code bellow uses if then statements to decide what action is going to take (in this case checks whether a list is empty or not)
```sml
fun print_head (aList: string list) =
    if null aList
    then "the list is empty, I couldn't find any head"
    else hd aList
```
You can accomplish the same result in an much more elegant way by using pattern matching (see next snippet)
```sml
fun print_head_pattern_matching (aList: string list) =
    case aList of
	[] => "the list is empty, I couldn't find any head"
	| x::xs => x
```
The above code fragment is equivalent to the previous program, the first case statement checks whether a list is empty by using the [] and after the arrow says what is about to execute if the list is empty.
if not, continues and checks the second case (in an non empty list, x is the head and xs is the tail of the list)

here a few reasons why you will wnat to use pattern matching:
1. you are getting a compiler warning if you miss a case. Let's say for some reason we forgot to test the empty list case, compiler has some to say about it
```sml
- fun print_head_pm_non_exhaustive (aList: string list) =
    case aList of
	x::xs => x;
= stdIn:49.5-50.12 Warning: match nonexhaustive
          x :: xs => ...
```
2. you can't duplicate a case, you will have an error at compile time

When in an already defined variable you assign again a different value/binding
```sml
- val a = 2;
val a = 2 : int (*a here is bound to 2*)
- val a = 3; (*now a is bound to 3, in this case a "shadows" the previous binding*)
val a = 3 : int
```
### Tail Recursion
I will start to explain this concept by an example.
Let's say that we want to compute the factorial of a number, one solution
could be the following:
```sml
fun factorial (n: int) =
    if n = 0 then 1 else n * factorial(n - 1)
```
It's seems a good one, it calculates properly the factorial (at least the small ones)
But there is problem, each time that factorial(n - 1) is called is also pushed in an stack. In a case that the n is really big the stack explodes (stack overflow). Tail recursion to the rescue! the bellow code gives a solution that avoids the stack explosion

```sml
fun factorial n =
    let
	    fun inner (k, acc) =
	        if k = 0 then
		    acc
	        else
		    inner(k - 1, k * acc)
    in
	    inner(n, 1)
    end
```
The above code uses an inner function (helper function) that accumulates the result of each multiplication and decreases the input number, finally calls itself. This call is called a tail call, all functional languages can understand this call and each time this kind of a call happens the function doesn't pushed to the stack.


## Third part (Higher order functions)

Usually a function takes as arguments some values (e.g. data) ,but there are some special kind of
functions that can take as arguments other functions, those functions are called higher order functions
(or they can return functions)

For example, the bellow function sum is a higher order function, the first
argument is function that takes an int and returns an int, the second one
is the range of numbers that the function is applied (i.e. if n = 3 then the function is going to return
the following result g(3) + g(2) + g(1) +g(0))

```sml
fun sum (g: int -> int, n: int) =
    if n = 0 then g(0) else g(n) + sum(g, n - 1)

fun square_of(x: int) = x * x;
```

So, if you pass the square_of function in sum you are going to get the summation
of squared numbers from n to 0 (i.e. 3^2 + 2^2 + 1^2 + 0^2)
If you have any function that takes as an argument an int and returns a int you
can pass it to sum (for example, you may want to calculate the sum of cube numbers, you
just implement a function that calculates the cube of a number and you pass it in the sum)
