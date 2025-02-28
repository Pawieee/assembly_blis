include save_courses.inc

.data
    course111 db "GE 15", 0
    course112 db "LIS 121", 0
    course113 db "GE 2", 0
    course114 db "GE 3", 0
    course115 db "LIS 111", 0
    course116 db "LIS 112", 0
    course117 db "PAHF 1", 0
    course118 db "NSTP 1", 0
    course121 db "UGE 1", 0
    course122 db "GE 4", 0
    course123 db "GE 1", 0
    course124 db "LIS 122", 0
    course125 db "LIS 123", 0
    course126 db "LIS 124", 0
    course127 db "PAHF 2", 0
    course128 db "NSTP 2", 0
    course211 db "GE 8", 0
    course212 db "GE 7", 0
    course213 db "LIS 221", 0
    course214 db "LIS 218", 0
    course215 db "LIS 219", 0
    course216 db "LIS 217", 0
    course217 db "LIS 220", 0
    course218 db "PAHF 3", 0
    course221 db "GE 6", 0
    course222 db "l 2", 0
    course223 db "GE 5", 0
    course224 db "LIS 223", 0
    course225 db "LIS 224", 0
    course226 db "LIS 225/L", 0
    course227 db "LIS 229", 0
    course228 db "PAHF 4", 0
    course311 db "LIS 300", 0
    course312 db "LIS 228", 0
    course313 db "MTH 119", 0
    course314 db "LIS 311", 0
    course315 db "LIS 312", 0
    course316 db "LIS 313/L", 0
    course317 db "LIS 314", 0
    course321 db "GE 9", 0
    course322 db "LIS 226", 0
    course323 db "GE 20", 0
    course324 db "LIS 321/L", 0
    course325 db "LIS 322/L", 0
    course326 db "LIS 301", 0
    course411 db "FL 111", 0
    course412 db "GE 11", 0
    course413 db "CAED 500c", 0
    course414 db "LIS 411", 0
    course415 db "LIS 412", 0
    course421 db "LIS 421", 0
    course422 db "LIS 422", 0

.code
EnlistCourses PROC sem:BYTE, year:BYTE, course BYTE, arr:DWORD
    Lea eax, course
    mov arr[0], eax

    ret
EnlistCourses ENDP