fun is_older (firstDate: int * int * int, secondDate: int * int * int) =
    let
	val firstYear = #1 firstDate;
	val firstMonth = #2 firstDate;
	val firstDay = #3 firstDate;
	val secondYear = #1 secondDate;
	val secondMonth = #2 secondDate;
	val secondDay = #3 secondDate;
    in
	if firstYear < secondYear then true else false;
	if firstMonth < secondMonth then true else false;
	if firstDay < secondDay then true else false
    end

fun number_in_month(dates: (int * int * int) list, month: int) =
    let
	fun countMonths(monthCounter: int, dates: (int * int * int) list, month: int) =
	    if null dates then monthCounter else
	    if #2 (hd dates) = month then countMonths(monthCounter + 1, tl dates, month) else
	    countMonths(monthCounter, tl dates, month)
    in
	countMonths(0, dates, month)
    end 
    
    
    		  
		   
   
