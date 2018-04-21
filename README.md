# Basic Functional concetps (ML)
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
