; md5_encoder.asm
; This program takes a string input, computes its MD5 hash using OpenSSL's `md5` command, and prints the hash.

section .data
    input db 'Hello, World!', 0    ; Input string to hash
    md5_cmd db 'echo -n "', 0      ; Start of the md5 shell command
    end_quote db '" | md5sum', 0   ; Ending part of the md5 command
    buffer db 256                  ; Buffer to store command output

section .bss
    hash resb 33                   ; 32 characters + null terminator for the hash

section .text
    global _start

_start:
    ; Combine the command string
    mov rdi, md5_cmd
    call strcat                    ; Append the input string
    mov rdi, input
    call strcat                    ; Append the ending command
    mov rdi, end_quote
    call strcat

    ; Execute the command and store output in the buffer
    mov rdi, buffer
    call execute_command

    ; Extract only the hash (first 32 characters)
    mov rdi, hash
    mov rsi, buffer
    mov ecx, 32                    ; Copy first 32 characters
hash_copy:
    mov al, byte [rsi]
    mov byte [rdi], al
    inc rsi
    inc rdi
    loop hash_copy

    ; Print the hash
    mov rdi, hash
    call print_string

    ; Exit the program
    mov rax, 60                    ; Syscall for exit
    xor rdi, rdi                   ; Exit code 0
    syscall

; Function: strcat
; Appends src to dst (null-terminated strings)
strcat:
    ; RDI = dst, RSI = src
    push rsi
    push rdi
strcat_find_end:
    mov al, byte [rdi]
    test al, al
    jz strcat_append
    inc rdi
    jmp strcat_find_end
strcat_append:
    pop rdi
strcat_copy:
    mov al, byte [rsi]
    mov byte [rdi], al
    test al, al
    jz strcat_done
    inc rdi
    inc rsi
    jmp strcat_copy
strcat_done:
    pop rsi
    ret

; Function: execute_command
; Executes a shell command and stores output in the buffer
execute_command:
    ; RDI = buffer
    mov rsi, rdi
    mov rdi, md5_cmd               ; Command to execute
    mov rax, 59                    ; Syscall for execve
    syscall
    ret

; Function: print_string
; Prints a null-terminated string
print_string:
    ; RDI = string to print
    mov rsi, rdi
    mov rdx, 0
print_len:
    cmp byte [rsi + rdx], 0
    je print_done
    inc rdx
    jmp print_len
print_done:
    mov rax, 1                     ; Syscall for write
    mov rdi, 1                     ; File descriptor (stdout)
    syscall
    ret
