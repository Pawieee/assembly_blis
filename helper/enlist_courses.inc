.data
    ge15 db "GE 15", 0
    lis121 db "LIS 121", 0
    ;and so on... thanks

.code
EnlistCourses PROC sem:BYTE, year:BYTE, course BYTE
    ;ADD DRI CONDITIONS NA IYA I-SELECT TUNG COURSES ABOVE, BASED ON YEAR AND SEM
    ret
EnlistCourses ENDP