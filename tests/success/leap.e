global function leap(integer year) 
    return rmdr(year,4)=0 and (rmdr(year,100)!=0 or rmdr(year,400)=0)
end function

