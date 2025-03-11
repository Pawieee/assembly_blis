.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

include helper\set_courses.inc
include helper\enlist_courses.inc

.data
    file_handle HANDLE ?
    file_contents db 100000 dup(?)
    bytes_read  DWORD ?

    _name db "Enter your name: ",0
    _id db "Enter your ID: ",0

    _menu1 db 10,"[1] View Prospectus", 10,0
    _menu2 db "[2] Enroll Courses", 10,0
    _menu3 db "[3] View My Course", 10,0
    _menu4 db "[4] Exit", 10,0

    _msg1 db "Choose Year: ", 0
    _first_year db 10,"[1] 1st Year", 10,0
    _second_year db "[2] 2nd Year", 10,0
    _third_year db "[3] 3rd Year", 10,0
    _fourth_year db "[4] 4th Year", 10,0

    _msg2 db "Choose Semester: ", 0
    _first_sem db 10,"[1] 1st Semester", 10,0
    _second_sem db "[2] 2nd Semester", 10,0

    prospec db "base\\prospectus.txt", 0
    
    _prompt db 10, "Enlist another course? [Y/N] ", 0
    _enlist db 10, "Enlist course: ", 0
    first_sem1_arr DWORD 8 DUP(0)
    first_sem2_arr DWORD 8 DUP(0)
    second_sem1_arr DWORD 8 DUP(0)
    second_sem2_arr DWORD 8 DUP(0)
    third_sem1_arr DWORD 7 DUP(0)
    third_sem2_arr DWORD 6 DUP(0)
    fourth_sem1_arr DWORD 5 DUP(0)
    fourth_sem2_arr DWORD 2 DUP(0)

    first_sem1_total db 0
    first_sem2_total db 0
    second_sem1_total db 0
    second_sem2_total db 0
    third_sem1_total db 0
    third_sem2_total db 0
    fourth_sem1_total db 0
    fourth_sem2_total db 0
    
.data?
    fname db 100 dup(?)
    id db 100 dup(?)
    menu db 3 dup(?)
    year  db 4 dup(?)
    sem db 4 dup(?)
    _course db 4 dup(?)
    _input db 4 dup(?)
    year_num db ?
    sem_num db ?
    course_num db ?
    array_ptr dd ?
.code
start:    
    invoke ClearScreen

    invoke StdOut, addr _name
    invoke StdIn, addr fname, 100
    invoke StdOut, addr _id
    invoke StdIn, addr id, 100
main_menu:
    invoke StdOut, addr _menu1
    invoke StdOut, addr _menu2
    invoke StdOut, addr _menu3
    invoke StdOut, addr _menu4
    invoke StdIn, addr menu, 3

.if menu == '1'
    invoke ReadFileProc, addr prospec
.elseif menu == '2'
enlist:
    invoke StdOut, addr _first_year
    invoke StdOut, addr _second_year
    invoke StdOut, addr _third_year
    invoke StdOut, addr _fourth_year
    invoke StdOut, addr _msg1

    invoke RtlZeroMemory, addr year, 4
    invoke StdIn, addr year, 4

    invoke StdOut, addr _first_sem
    invoke StdOut, addr _second_sem
    invoke StdOut, addr _msg2

    invoke RtlZeroMemory, addr sem, 4
    invoke StdIn, addr sem, 4

    invoke SetCourses, sem, year
    invoke StdOut, addr _enlist
    invoke StdIn, addr _course, 4
    
    .if _course == '0'
        jmp main_menu
    .endif

    mov al, [year]
    sub al, '0'
    mov year_num, al

    ; Convert sem input to integer
    mov al, [sem]
    sub al, '0'
    mov sem_num, al

    ; Determine the correct array based on year and sem
    movzx eax, year_num
    movzx ebx, sem_num
    lea edi, first_sem1_arr
    Lea esi, first_sem1_total
    .if eax == 1
        .if ebx == 1
            lea edi, first_sem1_arr
            Lea esi, first_sem1_total
        .elseif ebx == 2
            lea edi, first_sem2_arr
            Lea esi, first_sem2_total
        .endif
    .elseif eax == 2
        .if ebx == 1
            lea edi, second_sem1_arr
            Lea esi, second_sem1_total
        .elseif ebx == 2
            lea edi, second_sem2_arr
            Lea esi, second_sem2_total
        .endif
    .elseif eax == 3
        .if ebx == 1
            lea edi, third_sem1_arr
            Lea esi, third_sem1_total
        .elseif ebx == 2
            lea edi, third_sem2_arr
            Lea esi, third_sem2_total
        .endif
    .elseif eax == 4
        .if ebx == 1
            lea edi, fourth_sem1_arr
            Lea esi, fourth_sem1_total
        .elseif ebx == 2
            lea edi, fourth_sem2_arr
            Lea esi, fourth_sem2_total
        .endif
    .endif
    mov array_ptr, edi
    ; Read course number and convert to integer
    mov al, [_course]
    sub al, '0'
    mov course_num, al

    ; Enlist the course
    invoke EnlistCourse, year_num, sem_num, course_num, array_ptr, esi

    invoke StdOut, addr _prompt
    invoke RtlZeroMemory,addr _input, SIZEOF _input
    invoke StdIn, addr _input, 4

    .if _input == 'Y' || _input == 'y'
        jmp enlist
    .elseif _input == 'N' || _input == 'n'
        jmp main_menu
    .endif
        
.elseif menu =='3'
    invoke StdOut, addr _first_year
    invoke StdOut, addr _second_year
    invoke StdOut, addr _third_year
    invoke StdOut, addr _fourth_year
    invoke StdOut, addr _msg1
    invoke StdIn, addr year, 4

    ; Get semester input
    invoke StdOut, addr _first_sem
    invoke StdOut, addr _second_sem
    invoke StdOut, addr _msg2
    invoke StdIn, addr sem, 4

    ; Convert to numbers
    mov al, [year]
    sub al, '0'
    mov year_num, al
    mov al, [sem]
    sub al, '0'
    mov sem_num, al

    ; Determine array and size
    movzx eax, year_num
    movzx ebx, sem_num
    lea edi, first_sem1_arr
    Lea esi, first_sem1_total
    mov ecx, 8  ; Default size

    .if eax == 1
        .if ebx == 1
            lea edi, first_sem1_arr
            Lea esi, first_sem1_total
            mov ecx, 8
        .elseif ebx == 2
            lea edi, first_sem2_arr
            Lea esi, first_sem2_total
            mov ecx, 8
        .endif
    .elseif eax == 2
        .if ebx == 1
            lea edi, second_sem1_arr
            Lea esi, second_sem1_total
            mov ecx, 8
        .elseif ebx == 2
            lea edi, second_sem2_arr
            Lea esi, second_sem2_total
            mov ecx, 8
        .endif
    .elseif eax == 3
        .if ebx == 1
            lea edi, third_sem1_arr
            Lea esi, third_sem1_total
            mov ecx, 7
        .elseif ebx == 2
            lea edi, third_sem2_arr
            Lea esi, third_sem2_total
            mov ecx, 6
        .endif
    .elseif eax == 4
        .if ebx == 1
            lea edi, fourth_sem1_arr
            Lea esi, fourth_sem1_total
            mov ecx, 5
        .elseif ebx == 2
            lea edi, fourth_sem2_arr
            Lea esi, fourth_sem2_total
            mov ecx, 2
        .endif
    .endif

    ; Show courses
    invoke DisplayCourses, edi, ecx, esi, year_num, sem_num
    jmp main_menu
.elseif menu == '4'
    invoke ExitProcess, 0
.endif
    jmp main_menu
    invoke ExitProcess, 0


end start