.data
    ge15 db "GE 15", 0
    lis121 db "LIS 121", 0
    ge2 db "GE 2", 0
    ge3 db "GE 3", 0
    lis111 db "LIS 111", 0
    lis112 db "LIS 112", 0
    pahf1 db "PAHF 1", 0
    nstp1 db "NSTP 1", 0
    fl111 db "FL 111", 0
    ge11 db "GE 11", 0
    caed500c db "CAED 500c", 0
    lis411 db "LIS 411", 0
    lis412 db "LIS 412", 0
    lis421 db "LIS 421", 0
    lis422 db "LIS 422", 0
    ge8 db "GE 8", 0
    ge7 db "GE 7", 0
    lis221 db "LIS 221", 0
    lis218 db "LIS 218", 0
    lis219 db "LIS 219", 0
    lis217 db "LIS 217", 0
    lis220 db "LIS 220", 0
    pahf3 db "PAHF 3", 0
    ge6 db "GE 6", 0
    uge2 db "UGE 2", 0
    ge5 db "GE 5", 0
    lis223 db "LIS 223", 0
    lis224 db "LIS 224", 0
    lis225l db "LIS 225/L", 0
    lis229 db "LIS 229", 0
    pahf4 db "PAHF 4", 0
    lis300 db "LIS 300", 0
    lis228 db "LIS 228", 0
    mth119 db "MTH 119", 0
    lis311 db "LIS 311", 0
    lis312 db "LIS 312", 0
    lis313l db "LIS 313/L", 0
    lis314 db "LIS 314", 0
    ge9 db "GE 9", 0
    lis226 db "LIS 226", 0
    ge20 db "GE 20", 0
    lis321l db "LIS 321/L", 0
    lis322l db "LIS 322/L", 0
    lis301 db "LIS 301", 0



    ;and so on... thanks

.code
EnlistCourses PROC sem:BYTE, year:BYTE, course BYTE

    ; Ask for year input (1st to 4th year)
    cmp year, 1          ; Check if the year is 1
    je first_year         ; Jump to first_year if year is 1
    cmp year, 2          ; Check if the year is 2
    je second_year        ; Jump to second_year if year is 2
    cmp year, 3          ; Check if the year is 3
    je third_year         ; Jump to third_year if year is 3
    cmp year, 4          ; Check if the year is 4
    je fourth_year        ; Jump to fourth_year if year is 4
    jmp invalid_year      ; Jump to invalid_year if the year is not between 1 and 4

first_year:
    ; Year 1 - Check for semester
    cmp sem, 1           ; Check if the semester is 1
    je first_sem_1        ; Jump to first_sem_1 if it's first semester
    cmp sem, 2           ; Check if the semester is 2
    je first_sem_2        ; Jump to first_sem_2 if it's second semester
    jmp invalid_sem       ; Jump to invalid_sem if it's not semester 1 or 2

second_year:
    ; Year 2 - Check for semester
    cmp sem, 1           ; Check if the semester is 1
    je second_sem_1       ; Jump to second_sem_1 if it's first semester
    cmp sem, 2           ; Check if the semester is 2
    je second_sem_2       ; Jump to second_sem_2 if it's second semester
    jmp invalid_sem

third_year:
    ; Year 3 - Check for semester
    cmp sem, 1
    je third_sem_1
    cmp sem, 2
    je third_sem_2
    jmp invalid_sem

fourth_year:
    ; Year 4 - Check for semester
    cmp sem, 1
    je fourth_sem_1
    cmp sem, 2
    je fourth_sem_2
    jmp invalid_sem

invalid_year:
    ; Handle invalid year input
    ; Add your code here to notify the user about invalid year
    ret

invalid_sem:
    ; Handle invalid semester input
    ; Add your code here to notify the user about invalid semester
    ret

first_sem_1:
    ; Year 1, Semester 1 - Load courses
    ; Example: GE 15, LIS 111, PAHF 1, NSTP 1
    ; Add conditions to select courses for first semester of first year
    ret

first_sem_2:
    ; Year 1, Semester 2 - Load courses
    ; Example: GE 2, GE 3, LIS 121, LIS 122
    ; Add conditions to select courses for second semester of first year
    ret

second_sem_1:
    ; Year 2, Semester 1 - Load courses
    ; Add courses for year 2, semester 1
    ret

second_sem_2:
    ; Year 2, Semester 2 - Load courses
    ; Add courses for year 2, semester 2
    ret

third_sem_1:
    ; Year 3, Semester 1 - Load courses
    ; Add courses for year 3, semester 1
    ret

third_sem_2:
    ; Year 3, Semester 2 - Load courses
    ; Add courses for year 3, semester 2
    ret

fourth_sem_1:
    ; Year 4, Semester 1 - Load courses
    ; Add courses for year 4, semester 1
    ret

fourth_sem_2:
    ; Year 4, Semester 2 - Load courses
    ; Add courses for year 4, semester 2
    ret

EnlistCourses ENDP

