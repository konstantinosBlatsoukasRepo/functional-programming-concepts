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

fun number_in_month (dates: (int * int * int) list, month: int) =
    let
	fun countMonths(monthCounter: int, dates: (int * int * int) list, month: int) =
	    if null dates then monthCounter else
	    if #2 (hd dates) = month then countMonths(monthCounter + 1, tl dates, month) else
	    countMonths(monthCounter, tl dates, month)
    in
	countMonths(0, dates, month)
    end 
    
fun number_in_months (dates: (int * int * int) list, months: int list) =
    let
	fun countMonthsInList(dates: (int * int * int) list, months: int list, counter: int) =
	    if null months then counter
	    else countMonthsInList(dates, tl months, counter + number_in_month(dates, hd months))
    in
	countMonthsInList(dates, months, 0)
    end

fun dates_in_month (dates: (int * int * int) list, month: int) =
    let
	fun countDates(dates: (int * int * int) list, month: int, accDates: (int * int * int) list) = 
            if null dates then accDates
	    else if #2 (hd dates) = month then countDates(tl dates, month, hd dates :: accDates)
            else countDates(tl dates, month, accDates)							   
    in
	countDates(dates, month, [])		
    end 

fun append_dates (firstDateList: (int * int * int) list, secondDateList: (int * int * int) list) =
    if null firstDateList andalso not (null secondDateList) then secondDateList else
    if null secondDateList andalso not (null firstDateList) then firstDateList else
    if not (null secondDateList) andalso not (null firstDateList)
    then hd firstDateList :: append_dates(tl firstDateList, secondDateList)
    else []					     

fun dates_in_months (dates: (int * int * int) list, months: int list) =
    let
	fun countMonthsInList(dates: (int * int * int) list, months: int list, accDates: (int * int * int) list) =
	    if null months then accDates
	    else countMonthsInList(dates, tl months, append_dates(accDates, dates_in_month(dates, hd months)))
    in
	countMonthsInList(dates, months, [])
    end 
		 

   
