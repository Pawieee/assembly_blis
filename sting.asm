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

    _msg0 db 10,"Enter menu option: ", 10,0
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
    _invalid_course_msg db 10, "Invalid input. Please try again.", 10,0

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
menu_input:
    invoke ClearScreen
    invoke StdOut, addr _menu1
    invoke StdOut, addr _menu2
    invoke StdOut, addr _menu3
    invoke StdOut, addr _menu4
    invoke StdOut, addr _msg0
    invoke StdIn, addr menu, 3
    
    mov al, [menu]
    cmp al, '1'
    jb menu_input
    cmp al, '4'
    ja menu_input

.if menu == '1'
    invoke ClearScreen
    invoke ReadFileProc, addr prospec
    invoke StdOut, addr return_prompt
    invoke StdIn, addr _input, 4
.elseif menu == '2'
enlist:
year_input:
    invoke ClearScreen
    invoke StdOut, addr _first_year
    invoke StdOut, addr _second_year
    invoke StdOut, addr _third_year
    invoke StdOut, addr _fourth_year
    invoke StdOut, addr _msg1

    invoke RtlZeroMemory, addr year, 4
    invoke StdIn, addr year, 4

    mov al, [year]
    cmp al, '1'
    jb year_input
    cmp al, '4'
    ja year_input

sem_input:
    invoke StdOut, addr _first_sem
    invoke StdOut, addr _second_sem
    invoke StdOut, addr _msg2

    invoke RtlZeroMemory, addr sem, 4
    invoke StdIn, addr sem, 4

    mov al, [sem]
    cmp al, '1'
    jb sem_input
    cmp al, '2'
    ja sem_input

course_input:
    invoke SetCourses, sem, year
    invoke StdOut, addr _enlist
    invoke StdIn, addr _course, 4
    
    mov al, [_course]
    cmp al, '0'
    je main_menu

    sub al, '0'         ; now AL contains the numeric value
    mov cl, al  

    mov al, [year]
    sub al, '0'
    mov year_num, al  
    
    mov al, [sem]
    sub al, '0'
    mov sem_num, al    ; EBX now holds the numeric semester

    movzx eax, byte ptr [year_num]  ; EAX = numeric year
    movzx ebx, byte ptr [sem_num]   ; EBX = numeric semester

    cmp eax, 1
    je year1
    cmp eax, 2
    je year2
    cmp eax, 3
    je year3
    cmp eax, 4
    je year4


year1:
    cmp ebx, 1
    je set_max_8
    cmp ebx, 2
    je set_max_8


year2:
    cmp ebx, 1
    je set_max_8
    cmp ebx, 2
    je set_max_8


year3:
    cmp ebx, 1
    je set_max_7
    cmp ebx, 2
    je set_max_6

year4:
    cmp ebx, 1
    je set_max_5
    cmp ebx, 2
    je set_max_2


set_max_8:
    mov ecx, 8
    jmp set_done

set_max_7:
    mov ecx, 7
    jmp set_done

set_max_6:
    mov ecx, 6
    jmp set_done

set_max_5:
    mov ecx, 5
    jmp set_done

set_max_2:
    mov ecx, 2
    jmp set_done

set_done:
    ; Now ECX contains the maximum allowed course number.
    ; (For example, if year 1 and sem 1, then ECX = 8)

    ; Convert _course input from ASCII to numeric:
    mov al, [_course]
    cmp al, '0'
    je main_menu            ; If the user entered '0', return to menu.
    sub al, '0'
    movzx edx, al           ; EDX = numeric course input

    cmp edx, 1
    jl invalid_course_input  ; if input < 1, it's invalid
    cmp edx, ecx
    ja invalid_course_input  ; if input > maximum, it's invalid

    ; Otherwise, valid input. Save it:
    mov course_num, al

    jmp proceed_enlist

invalid_course_input:
    invoke StdOut, addr _invalid_course_msg

    invoke StdOut, addr return_prompt
    invoke StdIn, addr _inputs, 4
    jmp course_input

proceed_enlist:
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
    invoke ClearScreen
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
    invoke ClearScreen
    mov year_num, 1  ; Start from 1st Year

year_loop:
    mov sem_num, 1  ; Start from 1st Semester

sem_loop:
    ; Set corresponding array and size
    movzx eax, year_num
    movzx ebx, sem_num

    .if eax == 1
        .if ebx == 1
            lea edi, first_sem1_arr
            lea esi, first_sem1_total
            mov ecx, 8
        .elseif ebx == 2
            lea edi, first_sem2_arr
            lea esi, first_sem2_total
            mov ecx, 8
        .endif
    .elseif eax == 2
        .if ebx == 1
            lea edi, second_sem1_arr
            lea esi, second_sem1_total
            mov ecx, 8
        .elseif ebx == 2
            lea edi, second_sem2_arr
            lea esi, second_sem2_total
            mov ecx, 8
        .endif
    .elseif eax == 3
        .if ebx == 1
            lea edi, third_sem1_arr
            lea esi, third_sem1_total
            mov ecx, 7
        .elseif ebx == 2
            lea edi, third_sem2_arr
            lea esi, third_sem2_total
            mov ecx, 6
        .endif
    .elseif eax == 4
        .if ebx == 1
            lea edi, fourth_sem1_arr
            lea esi, fourth_sem1_total
            mov ecx, 5
        .elseif ebx == 2
            lea edi, fourth_sem2_arr
            lea esi, fourth_sem2_total
            mov ecx, 2
        .endif
    .endif

    ; Show courses for this semester
    invoke DisplayCourses, edi, ecx, esi, year_num, sem_num, addr fname, addr id
    invoke ClearScreen

    ; Increment semester
    inc sem_num
    cmp sem_num, 3
    jl sem_loop  ; Loop until sem_num < 3 (i.e., 1st and 2nd sem)

    ; Increment year
    inc year_num
    cmp year_num, 5
    jl year_loop  ; Loop until year_num < 5 (i.e., 1st to 4th year)
    jmp main_menu
.elseif menu == '4'
    invoke ExitProcess, 0
.endif
    jmp main_menu
    invoke ExitProcess, 0


end start