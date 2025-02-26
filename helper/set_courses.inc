INCLUDE read_file.inc

.data
    _base db ".txt", 0
    yr1 db "base\\first_year", 0
    yr2 db "base\\second_year", 0
    yr3 db "base\\third_year", 0
    yr4 db "base\\fourth_year", 0
    file_loc db 256 dup(?)

.code
SetCourses PROC sem:BYTE, year:BYTE

    invoke RtlZeroMemory, ADDR file_loc, SIZEOF file_loc
    ;Concatenates the year and semester to the filename
    .if year == '1'
        invoke lstrcat, addr file_loc, addr yr1
    .elseif year == '2'
        invoke lstrcat, addr file_loc, addr yr2
    .elseif year == '3'
        invoke lstrcat, addr file_loc, addr yr3
    .elseif year == '4'
        invoke lstrcat, addr file_loc, addr yr4
    .endif
    invoke lstrcat, addr file_loc, addr sem
    invoke lstrcat, addr file_loc, addr _base
    invoke ReadFileProc, addr file_loc

    ret
SetCourses ENDP