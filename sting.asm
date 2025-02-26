.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

include helper\set_courses.inc
.data
    file_handle HANDLE ?
    file_contents db 100000 dup(?)
    bytes_read DWORD ?

    _name db "Enter your name: ",0
    _id db "Enter your ID: ",0

    _menu1 db 10,"[1] View Prospectus", 10,0
    _menu2 db "[2] Enroll Courses", 10,0
    _menu3 db "[3] View My Course", 10,0
    _menu4 db "[4] Exit", 10,0

    _msg1 db "Choose Year: ", 0
    _first_year db "[1] 1st Year", 10,0
    _second_year db "[2] 2nd Year", 10,0
    _third_year db "[3] 3rd Year", 10,0
    _fourth_year db "[4] 4th Year", 10,0

    _msg2 db "Choose Semester: ", 0
    _first_sem db "[1] 1st Semester", 10,0
    _second_sem db "[2] 2nd Semester", 10,0



    sem1 db "\sem1", 0
    sem2 db "\sem2", 0

    prospec db "\sem\prospectus.txt", 0
    

    
.data?
    fname db 100 dup(?)
    id db 100 dup(?)
    menu db 3 dup(?)
    year db 4 dup(?)
    sem db 4 dup(?)
    _course db 20 dup(?)
    _input db 4 dup(?)

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

   ; get current directory
    invoke RtlZeroMemory, addr file_loc, 1000
    invoke GetCurrentDirectory, 1000, addr file_loc

    .if menu == '1'
        invoke lstrcat, addr file_loc, addr prospec
        ;jmp create_file
    .elseif menu == '2'
        invoke StdOut, addr _first_year
        invoke StdOut, addr _second_year
        invoke StdOut, addr _third_year
        invoke StdOut, addr _fourth_year
        invoke StdOut, addr _msg1

        invoke StdIn, addr year, 4


        invoke StdOut, addr _first_sem
        invoke StdOut, addr _second_sem
        invoke StdOut, addr _msg2

        invoke StdIn, addr sem, 4

        invoke SetCourses, sem, year 
    .elseif menu =='3'
        invoke ExitProcess, 0
    .elseif menu == '4'
        invoke ExitProcess, 0
    .endif

    create_file:
        invoke CreateFileA, addr file_loc, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
        mov file_handle, eax
        .if eax == INVALID_HANDLE_VALUE
            ;invoke StdOut, addr error_file_msg
            jmp main_menu
        .endif
        jmp read_file

    read_file:
        ; Read the file contents
        invoke RtlZeroMemory, addr file_contents, 100000
        invoke ReadFile, file_handle, addr file_contents, 100000, addr bytes_read, NULL
        invoke CloseHandle, file_handle
        invoke ClearScreen
        invoke StdOut, offset file_contents
        ;invoke StdOut, addr press_enter_msg
        ;invoke StdIn, addr buffer, 256  ; Wait for user to press Enter
        jmp main_menu


    jmp main_menu
    invoke ExitProcess, 0
end start