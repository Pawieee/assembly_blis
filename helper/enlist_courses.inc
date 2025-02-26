.data ;First_Year ;First Semester ge15 db "GE 15", 0 lis121 db "LIS 121", 0 ge2
db "GE 2", 0 ge3 db "GE 3", 0 lis111 db "LIS 111", 0 lis112 db "LIS 112", 0
pahf1 db "PAHF 1", 0 nstp1 db "NSTP 1", 0 ;Second Semester uge1 db "UGE 1", 0
ge4 db "GE 4", 0 ge1 db "GE 1", 0 lis122 db "LIS 122", 0 lis123 db "LIS 123", 0
lis124 db "LIS 124", 0 pahf2 db "PAHF 2", 0 nstp2 db "NSTP 2", 0 ;Second_Year
;First Semester ge8 db "GE 8", 0 ge7 db "GE 7", 0 lis221 db "LIS 221", 0 lis218
db "LIS 218", 0 lis219 db "LIS 219", 0 lis217 db "LIS 217", 0 lis220 db "LIS
220", 0 pahf3 db "PAHF 3", 0 ;Second Semester ge6 db "GE 6", 0 uge2 db "UGE 2",
0 ge5 db "GE 5", 0 lis223 db "LIS 223", 0 lis224 db "LIS 224", 0 lis225 db "LIS
225/L", 0 lis229 db "LIS 229", 0 pahf4 db "PAHF 4", 0 ;Third_Year ;First
Semester lis300 db "LIS 300", 0 lis228 db "LIS 228", 0 mth119 db "MTH 119", 0
lis311 db "LIS 311", 0 lis312 db "LIS 312", 0 lis313 db "LIS 313/L", 0 lis314 db
"LIS 314", 0 ;Second Semester ge9 db "GE 9", 0 lis226 db "LIS 226", 0 ge20 db
"GE 20", 0 lis321 db "LIS 321", 0 lis322 db "LIS 322", 0 lis301 db "LIS 301", 0
;Fourth_Year ;First Semester FL111 db "FL 111", 0 ge11 db "GE 11", 0 caed500c db
"CAED 500c", 0 lis411 db "LIS 411", 0 lis412 db "LIS 412", 0 ;Second Semester
lis421 db "LIS 421", 0 lis422 db "LIS 422", 0 ;and so on... thanks .code
EnlistCourses PROC sem:BYTE, year:BYTE, course BYTE ;ADD DRI CONDITIONS NA IYA
I-SELECT TUNG COURSES ABOVE, BASED ON YEAR AND SEM ret EnlistCourses ENDP
