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
    filename db "D:\acads\3rd Year\2nd SEM\1st Term\CS 11\masm files\assembly_blis\sem\prospectus.txt", 0
    file_contents db 100000 dup(?)
    bytes_read DWORD ?

.code
start:

create_file:
    push 0
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING
    push 0
    push 0
    push FILE_READ_DATA
    push offset filename
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
