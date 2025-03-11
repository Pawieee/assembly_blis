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
    
    newLine         db 10, 0
    return_prompt   db "Press 'Enter' key to continue...", 10, 0
    totalMsg   db "Total Units", 0

    success_msg   db "Course enlisted successfully!", 13, 10, 0
    duplicate_msg db "Error: Course already enlisted!", 13, 10, 0

    course_bar1 db 124,9,0
    course_bar1a db 9,32,32,32,124,32,32,32,32, 0
    course_bar1b db 9,32,32,32,124,9,32,32,0
    course_bar2 db 9,9,124,9,32,32,0
    course_bar2a db 32,32,32,124,9,32,32,32,32,0
    course_bar3 db 9,32,32,32,124,0

    
    headLine db 9,32,32,32,"+---------------------------------+",10, 0
    gridLine db 9,32,32,32,"+------------------+--------------+", 10,0
    first_sem1 db 9,32,32,32,"|     1ST YEAR - 1ST SEMESTER     |", 10,0
    first_sem2 db 9,32,32,32,"|     1ST YEAR - 2ND SEMESTER     |", 10,0
    second_sem1 db 9,32,32,32,"|     2ND YEAR - 1ST SEMESTER     |", 10,0
    second_sem2 db 9,32,32,32,"|     2ND YEAR - 2ND SEMESTER     |", 10,0 
    third_sem1 db 9,32,32,32,"|     3RD YEAR - 1ST SEMESTER     |", 10,0
    third_sem2 db 9,32,32,32,"|     3RD YEAR - 2ND SEMESTER     |", 10,0
    fourth_sem1 db 9,32,32,32,"|     4TH YEAR - 1ST SEMESTER     |", 10,0
    fourth_sem2 db 9,32,32,32,"|     4TH YEAR - 2ND SEMESTER     |", 10,0

    column_headers db 9,32,32,32,"|    Subj Code     |     Units    |", 10,0

    base_gridlines db "+----------------------------------------------------------+", 10,0
    college db 9,"COLLEGE OF COMPUTING EDUCATION",9,0
    program db "BACHELOR OF LIBRARY AND INFORMATION SCIENCE",0
    enrolled_txt db 9,32,32,32,"Enrolled Courses",9,9,0


    courseTable DWORD OFFSET course111, OFFSET course112, OFFSET course113, OFFSET course114, OFFSET course115, OFFSET course116, OFFSET course117, OFFSET course118
                DWORD OFFSET course121, OFFSET course122, OFFSET course123, OFFSET course124, OFFSET course125, OFFSET course126, OFFSET course127, OFFSET course128
                DWORD OFFSET course211, OFFSET course212, OFFSET course213, OFFSET course214, OFFSET course215, OFFSET course216, OFFSET course217, OFFSET course218
                DWORD OFFSET course221, OFFSET course222, OFFSET course223, OFFSET course224, OFFSET course225, OFFSET course226, OFFSET course227, OFFSET course228
                DWORD OFFSET course311, OFFSET course312, OFFSET course313, OFFSET course314, OFFSET course315, OFFSET course316, OFFSET course317
                DWORD OFFSET course321, OFFSET course322, OFFSET course323, OFFSET course324, OFFSET course325, OFFSET course326
                DWORD OFFSET course411, OFFSET course412, OFFSET course413, OFFSET course414, OFFSET course415
                DWORD OFFSET course421, OFFSET course422

    unitTable   BYTE 3, 3, 6, 3, 3, 3, 2, 3
                BYTE 6, 3, 3, 3, 3, 3, 2, 3
                BYTE 3, 3, 3, 3, 3, 3, 3, 2
                BYTE 3, 3, 3, 3, 3, 3, 3, 2
                BYTE 3, 3, 3, 3, 3, 3, 3
                BYTE 3, 3, 3, 3, 3, 3
                BYTE 3, 3, 3, 3, 3
                BYTE 5, 5

.data?
    _inputs db 4 dup(?)
    tempBuffer db 16 dup(?)
    tempCourseBuffer db 32 dup(?)

.code
EnlistCourse proc year_num:BYTE, sem_num:BYTE, course_num:BYTE, arr:DWORD, total_ptr:DWORD
    LOCAL start_index:DWORD
    mov start_index, 0
    movzx eax, year_num
    movzx ebx, sem_num

    .if eax == 1
        .if ebx == 1
            mov start_index, 0
        .else
            mov start_index, 8
        .endif
    .elseif eax == 2
        .if ebx == 1
            mov start_index, 16
        .else
            mov start_index, 24
        .endif
    .elseif eax == 3
        .if ebx == 1
            mov start_index, 32
        .else
            mov start_index, 39
        .endif
    .elseif eax == 4
        .if ebx == 1
            mov start_index, 45
        .else
            mov start_index, 50
        .endif
    .endif

    movzx ecx, course_num
    dec ecx
    add start_index, ecx

    mov eax, start_index
    shl eax, 2
    mov esi, offset courseTable
    add esi, eax
    mov edx, [esi]

    movzx ecx, course_num
    dec ecx
    shl ecx, 2
    mov edi, arr
    add edi, ecx

    ;Handle already enlisted courses
    cmp dword ptr [edi], 0
    jne already_enlisted 

    mov [edi], edx

    mov esi, offset unitTable
    mov eax, start_index
    mov al, [esi + eax]  ; AL = course unit

    ; Update total units
    mov edi, total_ptr
    add byte ptr [edi], al  ; Add unit to total
    invoke StdOut, addr success_msg
    jmp done

already_enlisted:
    ; Print error message
    invoke StdOut, addr duplicate_msg

done:
    ret
EnlistCourse endp

DisplayCourses proc array_ptr:DWORD, element_count:DWORD, total_ptr:DWORD, year:BYTE, sem:BYTE
    LOCAL start_index:DWORD 
    invoke StdOut, addr newLine
    invoke StdOut, addr base_gridlines
    invoke StdOut, addr course_bar1
    invoke StdOut, addr college
    invoke StdOut, addr course_bar3
    invoke StdOut, addr newLine
    invoke StdOut, addr base_gridlines
    invoke StdOut, addr course_bar1
    invoke StdOut, addr program
    invoke StdOut, addr course_bar3
    invoke StdOut, addr newLine
    invoke StdOut, addr base_gridlines
    invoke StdOut, addr course_bar1
    invoke StdOut, addr enrolled_txt
    invoke StdOut, addr course_bar3
    invoke StdOut, addr newLine
    invoke StdOut, addr base_gridlines
    invoke StdOut, addr newLine

    invoke StdOut, addr headLine

    .if year == 1 && sem == 1
        invoke StdOut, addr first_sem1
    .elseif year == 1 && sem == 2
        invoke StdOut, addr first_sem2
    .elseif year == 2 && sem == 1
        invoke StdOut, addr second_sem1
    .elseif year == 2 && sem == 2
        invoke StdOut, addr second_sem2
    .elseif year == 3 && sem == 1
        invoke StdOut, addr third_sem1
    .elseif year == 3 && sem == 2
        invoke StdOut, addr third_sem2
    .elseif year == 4 && sem == 1
        invoke StdOut, addr fourth_sem1
    .elseif year == 4 && sem == 2
        invoke StdOut, addr fourth_sem2
    .endif



    invoke StdOut, addr gridLine
    invoke StdOut, addr column_headers
    invoke StdOut, addr gridLine 

    pushad              ; Save all registers
    mov esi, array_ptr  ; Array pointer
    mov ecx, element_count ; Total number of courses
    xor edx, edx        ; Index counter
    xor eax, eax        ; Reset register

    ; 🔹 Check if there is at least one non-zero entry in the array
    mov ebx, 0          ; Flag to track if a course exists

check_array_loop:
    cmp edx, ecx        ; If edx >= ecx, we're done checking
    jge check_done

    mov eax, [esi + edx*4]  ; Load array value
    test eax, eax           ; Check if it's non-zero
    jnz course_found        ; If we find a valid course, skip to normal printing

    inc edx                 ; Move to next index
    jmp check_array_loop    ; Continue checking

course_found:
    mov ebx, 1              ; Set flag to indicate at least one course exists

check_done:
    cmp ebx, 0              ; If flag is still 0, no courses were found
    je end_print        ; Skip printing if the array is empty

    ; Reset index for actual printing
    xor edx, edx

print_loop:
    cmp edx, ecx        ; Check if index >= count
    jge done_printing

    ; Get current element
    mov eax, [esi + edx*4]
    test eax, eax       ; Check if element is 0
    jz skip_print
    
    ; Print course name and unit
    push edx            ; Preserve index
    push ecx            ; Preserve counter
    push eax            ; Preserve course pointer
    mov ebx, eax
    invoke lstrcpyn, addr tempCourseBuffer, ebx, sizeof tempCourseBuffer
    pop eax             ; Restore course pointer
    
    ; Find course index in courseTable
    mov edi, offset courseTable
    mov ecx, 52         ; Total courses

find_course_loop:
    cmp [edi], eax
    je found_course
    add edi, 4
    loop find_course_loop
    jmp skip_restore    ; Shouldn't happen if data is consistent

found_course:
    sub edi, offset courseTable ; EDI now holds byte offset
    shr edi, 2          ; Convert to index (EDI = index in courseTable)
    
    ; Get unit value
    movzx eax, byte ptr [unitTable + edi]
    invoke dwtoa, eax, addr tempBuffer

    ; Print formatted line
    invoke StdOut, addr course_bar1b
    invoke StdOut, addr tempCourseBuffer
    invoke StdOut, addr course_bar2
    invoke StdOut, addr tempBuffer
    invoke StdOut, addr course_bar3
    invoke StdOut, addr newLine
    invoke StdOut, addr gridLine

skip_restore:
    pop ecx             ; Restore counter
    pop edx             ; Restore index

skip_print:
    inc edx             ; Next index
    jmp print_loop

done_printing:
    ; Print total units
    invoke StdOut, addr course_bar1a
    invoke StdOut, addr totalMsg
    invoke StdOut, addr course_bar2a
    
    mov edi, total_ptr
    movzx eax, byte ptr [edi]
    invoke dwtoa, eax, addr tempBuffer
    invoke StdOut, addr tempBuffer
    invoke StdOut, addr course_bar3
    invoke StdOut, addr newLine
    invoke StdOut, addr gridLine
    invoke StdOut, addr newLine

    ; Return to menu prompt
    invoke StdOut, addr return_prompt
    invoke StdIn, addr _inputs, 4

    popad               ; Restore registers
end_print:
    ret
DisplayCourses endp
