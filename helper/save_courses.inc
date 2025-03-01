.data
    first_sem1_arr DWORD 8 DUP(0)
    first_sem2_arr DWORD 8 DUP(0)
    second_sem1_arr DWORD 8 DUP(0)
    second_sem2_arr DWORD 8 DUP(0)
    third_sem1_arr DWORD 7 DUP(0)
    third_sem2_arr DWORD 6 DUP(0)
    fourth_Sem1_arr DWORD 5 DUP(0)
    fourth_sem2_arr DWORD 2 DUP(0)

    ; Fixed-size array of pointers (addresses)
    courseArray DWORD 4 DUP(0)  ; Array of 4 pointers (initialized to 0)

.code
main PROC
    ; Store addresses of courses in the array
    lea eax, course1
    mov courseArray[0], eax

    lea eax, course2
    mov courseArray[4], eax

    lea eax, course3
    mov courseArray[8], eax

    lea eax, course4
    mov courseArray[12], eax

    ; Access and print the courses
    mov ecx, 4          ; Number of courses
    xor ebx, ebx        ; Index for the array
printLoop:
    mov eax, courseArray[ebx]  ; Get the address from the array
    invoke StdOut, eax         ; Print the string at that address
    add ebx, 4                 ; Move to the next pointer
    loop printLoop

    ret
main ENDP