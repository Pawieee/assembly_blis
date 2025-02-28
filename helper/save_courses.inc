.data


    ; Fixed-size array of pointers (addresses)
    courseArray DWORD 4 DUP(0)  ; Array of 4 pointers (initialized to 0)

.code
SaveCourse PROC arr:DWORD, course:BYTE
    ; Store addresses of courses in the array
    lea eax, course1
    mov courseArray[0], eax

    lea eax, course2
    mov courseArray[4], eax

    lea eax, course3
    mov courseArray[8], eax

    lea eax, course4
    mov courseArray[12], eax

    ret
SaveCourse ENDP

ViewCourses PROC
    ; Access and print the courses
    mov ecx, 4          ; Number of courses
    xor ebx, ebx        ; Index for the array
printLoop:
    mov eax, courseArray[ebx]  ; Get the address from the array
    invoke StdOut, eax         ; Print the string at that address
    add ebx, 4                 ; Move to the next pointer
    loop printLoop

    ret
ViewCourses ENDP