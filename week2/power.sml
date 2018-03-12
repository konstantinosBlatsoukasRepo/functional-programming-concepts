fun power (x: int, y: int) =
    if y = 0 then 1 else x * power(x, y - 1) 
				  
