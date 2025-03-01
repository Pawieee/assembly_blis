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
    file_contents db          100000 dup(?)
                  bytes_read  DWORD ?

    _name         db          "Enter your name: ",0
    _id           db          "Enter your ID: ",0

    _menu1        db          10,"[1] View Prospectus", 10,0
    _menu2        db          "[2] Enroll Courses", 10,0
    _menu3        db          "[3] View My Course", 10,0
    _menu4        db          "[4] Exit", 10,0

    _msg1         db          "Choose Year: ", 0
    _first_year   db          "[1] 1st Year", 10,0
    _second_year  db          "[2] 2nd Year", 10,0
    _third_year   db          "[3] 3rd Year", 10,0
    _fourth_year  db          "[4] 4th Year", 10,0

    _msg2         db          "Choose Semester: ", 0
    _first_sem    db          "[1] 1st Semester", 10,0
    _second_sem   db          "[2] 2nd Semester", 10,0

    prospec       db          "base\\prospectus.txt", 0
    

    
.data?
    fname         db          100 dup(?)
    id            db          100 dup(?)
    menu          db          3 dup(?)
    year          db          4 dup(?)
    sem           db          4 dup(?)
    _course       db          20 dup(?)
    _input        db          4 dup(?)

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
              invoke lstrcat, addr file_loc, addr prospec
              invoke ReadFileProc, addr file_loc
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


          jmp    main_menu
          invoke ExitProcess, 0
end start