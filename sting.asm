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
    filename db "D:\acads\3rd Year\2nd SEM\1st Term\CS 11\masm files\assembly_blis", 0
    file_contents db 100000 dup(?)
    bytes_read DWORD ?

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
    
    file_loc db 1000 dup(?)
    
.data?
    year db 3 dup(?)
    sem db 3 dup(?)



.code
start:
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

    .if year == "1"
        .if sem == "1"
            push offset filename
            push offset sem1
            push offset yr1
            push offset file_loc
            call create_dest
        .endif
    .endif

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
create_dest proc param1:DWORD, param2:DWORD, param3:DWORD, param4:DWORD
    push param1
    push param4
    call szCatStr

    push param3
    push param4
    call szCatStr

    push param2
    push param4
    call szCatStr


    push param4
    call StdOut
create_dest endp
    invoke ExitProcess, 0
end start
