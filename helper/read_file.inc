.DATA
    error_msg db "Error opening file", 0
    buffer db 512*3 dup(?)
    bytesRead dd ?
    wordBuffer db 512 dup(?)
    comma db ",", 0
    newline db 13, 10, 0

.CODE
ReadFileProc PROC filename:DWORD
    ; fileHandle: holds the actual contents of the file
    LOCAL fileHandle:DWORD

    ; Opens the file, storing the file in the eax register
    invoke CreateFile, filename, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    ; moving the contents of eax to fileHandle variable
    mov fileHandle, eax

    ; if fileHandle is invalid, jump to error_exit
    .if fileHandle == INVALID_HANDLE_VALUE
        je error_exit
    .endif

    invoke RtlZeroMemory, ADDR buffer, SIZEOF buffer
    ; Reads the file and stores the contents in the buffer
    invoke ReadFile, fileHandle, ADDR buffer, SIZEOF buffer, ADDR bytesRead, NULL

    ; Prints the contents of the buffer to the console
    invoke StdOut, ADDR buffer
    invoke StdOut, ADDR newline
    
    ; Closes the file
    invoke CloseHandle, fileHandle
    ; Jumps to end_proc to end the program
    jmp end_proc

error_exit:
    invoke StdOut, ADDR error_msg

end_proc:
    ret
ReadFileProc ENDP