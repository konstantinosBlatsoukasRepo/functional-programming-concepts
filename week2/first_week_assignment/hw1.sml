fun is_older (firstDate: int * int * int, secondDate: int * int * int) =
    let
	val isFirstYearOlder = (#1 firstDate < #1 secondDate)
	val isFirstYearMoreRecent = (#1 firstDate > #1 secondDate)
	val isFirstMonthOlder = (#2 firstDate < #2 secondDate)
	val isFirstMonthMoreRecent = (#2 firstDate > #2 secondDate)
	val isFirstDayOlder = (#3 firstDate < #3 secondDate)
	val isFirstDayMoreRecent = (#3 firstDate > #3 secondDate)	   			 
    in
	if isFirstYearOlder then true else
	if isFirstYearMoreRecent then false else
	if isFirstMonthOlder then true else
	if isFirstMonthMoreRecent then false else
	if isFirstDayOlder then true else
	if isFirstDayMoreRecent then false else
	false
    end 	
    
fun number_in_month (dates: (int * int * int) list, month: int) =
    let
	fun countMonths (monthCounter: int, dates: (int * int * int) list, month: int) =
	    if null dates then monthCounter else
	    if #2 (hd dates) = month then countMonths(monthCounter + 1, tl dates, month) else
	    countMonths(monthCounter, tl dates, month)
    in
	countMonths(0, dates, month)
    end 
    
fun number_in_months (dates: (int * int * int) list, months: int list) =
    let
	fun countMonthsInList (dates: (int * int * int) list, months: int list, counter: int) =
	    if null months then counter
	    else countMonthsInList(dates, tl months, counter + number_in_month(dates, hd months))
    in
	countMonthsInList(dates, months, 0)
    end

fun dates_in_month (dates: (int * int * int) list, month: int) =
    let
	fun countDates (dates: (int * int * int) list, month: int, accDates: (int * int * int) list) = 
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
	fun countMonthsInList (dates: (int * int * int) list, months: int list, accDates: (int * int * int) list) =
	    if null months then accDates
	    else countMonthsInList(dates, tl months, append_dates(accDates, dates_in_month(dates, hd months)))
    in
	countMonthsInList(dates, months, [])
    end 
		 
fun get_nth (strings: string list, index: int) =
    if null strings
        then " "
    else
	let
	    fun inner_get_nth (strings: string list, index: int, counter: int) =
		if index = counter then hd strings
		else inner_get_nth (tl strings, index, counter + 1)			   
	in
	    inner_get_nth (strings, index, 1)
	end 

fun date_to_string (year: int, month: int, day: int) =
    let 
	val monthString = get_nth (["January", "February", "March", "April",
				    "May", "June", "July", "August", "September", "October", "November", "December"], month)
        val yearString = Int.toString year
        val dayString = Int.toString day				             				   
    in
	monthString ^ " " ^ dayString ^ ", " ^ yearString
    end	
    			      
fun number_before_reaching_sum (sum: int, nums: int list) =
    let
	fun acc_sum (sum: int, nums: int list, iterativeSum: int, index: int) =
	    if iterativeSum >= sum andalso index = 1 then index else
	    if iterativeSum >= sum then index - 1
            else acc_sum(sum, tl nums, hd nums + iterativeSum, index + 1) 					    					    	
    in
	acc_sum (sum, tl nums, hd nums, 1)
    end    
			       
fun what_month (day: int) =
    if day >= 1 andalso day <= 31 then 1 else
    if day >= 32 andalso day <= 59 then 2 else
    if day >= 60 andalso day <= 90 then 3 else
    if day >= 91 andalso day <= 120 then 4 else
    if day >= 121 andalso day <= 151 then 5 else
    if day >= 152 andalso day <= 181 then 6 else
    if day >= 182 andalso day <= 212 then 7 else
    if day >= 213 andalso day <= 243 then 8 else
    if day >= 244 andalso day <= 273 then 9 else
    if day >= 274 andalso day <= 304 then 10 else
    if day >= 305 andalso day <= 334 then 11
    else 12
	     
fun month_range (day1: int, day2: int) =
    if day1 > day2 then []
    else
	let
	    val arrayLength = day2 - day1 + 1
	    fun months_in_range (day1: int, day2: int, accMonths: int list) =
		if day2 < day1 then accMonths
		else months_in_range(day1, day2 - 1, what_month(day2) :: accMonths)			
	in
	    months_in_range (day1, day2, [])
	end

	    
fun oldest (dates: (int * int * int) list) =
    if null dates then
	NONE
    else
	let
	    fun inner_oldest(dates: (int * int * int) list, oldest: int * int * int) =
		if null dates then SOME oldest else
		if is_older(hd dates, oldest) then inner_oldest(tl dates, hd dates)
 		else inner_oldest(tl dates, oldest)
	in
	    inner_oldest(dates, hd dates)
	end 
