.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    file_handle HANDLE ?
    file_contents db 100000 dup(?)
    bytes_read DWORD ?

    _menu1 db "[1] View Prospectus", 10,0
    _menu2 db "[2] Enroll Courses", 10,0
    _menu3 db "[3] Exit", 10,0

    _msg1 db "Choose Year: ", 0
    _first_year db "[1] 1st Year", 10,0
    _second_year db "[2] 2nd Year", 10,0
    _third_year db "[3] 3rd Year", 10,0
    _fourth_year db "[4] 4th Year", 10,0

    _msg2 db "Choose Semester: ", 0
    _first_sem db "[1] 1st Semester", 10,0
    _second_sem db "[2] 2nd Semester", 10,0

    yr1 db "\first_year.txt", 0
    yr2 db "\second_year.txt", 0
    yr3 db "\third_year.txt", 0
    yr4 db "\fourth_year.txt", 0

    sem1 db "\sem1", 0
    sem2 db "\sem2", 0

    prospec db "\sem\prospectus.txt", 0
    
    file_loc db 1000 dup(?)
    
.data?
    menu db 3 dup(?)
    year db 3 dup(?)
    sem db 3 dup(?)

.code
start:
    invoke ClearScreen

    invoke StdOut, addr _menu1
    invoke StdOut, addr _menu2
    invoke StdOut, addr _menu3
    invoke StdIn, addr menu, 3

   ; get current directory
    invoke GetCurrentDirectory, 1000, addr file_loc

    .if menu == '1'
        invoke lstrcat, addr file_loc, addr prospec
    .elseif menu == '2'
        invoke StdOut, addr _first_year
        invoke StdOut, addr _second_year
        invoke StdOut, addr _third_year
        invoke StdOut, addr _fourth_year
        invoke StdOut, addr _msg1
        invoke StdIn, addr year, 3

        invoke StdOut, addr _first_sem
        invoke StdOut, addr _second_sem
        invoke StdOut, addr _msg2
        invoke StdIn, addr sem, 3

        .if sem == '1'
            invoke lstrcat, addr file_loc, addr sem1
        .elseif sem == '2'
            invoke lstrcat, addr file_loc, addr sem2
        .endif
        .if year == '1'
            invoke lstrcat, addr file_loc, addr yr1
        .elseif year == '2'
            invoke lstrcat, addr file_loc, addr yr2
        .elseif year == '3'
            invoke lstrcat, addr file_loc, addr yr3
        .elseif year == '4'
            invoke lstrcat, addr file_loc, addr yr4
        .endif
    .elseif menu == '3'
        invoke ExitProcess, 0
    .endif

    invoke StdOut, addr file_loc
    create_file:
        push 0
        push FILE_ATTRIBUTE_NORMAL
        push OPEN_EXISTING
        push 0
        push 0
        push FILE_READ_DATA
        push offset file_loc
        call CreateFileA
        mov file_handle, eax

    read_file:
        push 0
        push offset bytes_read
        push 100000
        push offset file_contents
        push file_handle
        call ReadFile

    invoke ClearScreen
    invoke StdOut, offset file_contents
    invoke ExitProcess, 0
end start