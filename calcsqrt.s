; Square Root Program - x64 Linux Assembly
; Copyright (C) 2025 Ahmed Hamdi Elsoudi
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; See LICENSE file for full details.
.section .text
.globl _start

_start:
    movq $1, %rax
    movq $1, %rdi
    lea m1_start(%rip), %rsi
    movq $(m1_end-m1_start), %rdx
    syscall

    movq $0, %rax
    movq $0, %rdi
    lea number(%rip), %rsi
    movq $1, %rdx
    syscall

    flush_buffer:
    movq $0, %rax
    movq $0, %rdi
    lea tmp(%rip), %rsi
    movq $1, %rdx
    syscall
    cmpb $0x0A, tmp(%rip)
    je done_flush
    jmp flush_buffer

    done_flush:
    cmpb $'0', number(%rip)
    jl error
    cmpb $'9', number(%rip)
    jg error
    xorq %rax, %rax
    movb number(%rip), %al
    subb $0x30, %al

    cvtsi2ss %rax, %xmm0

    sqrtss %xmm0, %xmm0
    xorq %rax, %rax
    cvttss2si %xmm0, %rax

    movb %al, buffer+0(%rip)
    addb $0x30, buffer+0(%rip)

    movb dot(%rip), %al
    movb %al, buffer+1(%rip)

    xorq %rax, %rax
    movb buffer+0(%rip), %al
    subb $0x30, %al

    cvtsi2ss %rax, %xmm1
    subss %xmm1, %xmm0

    movq $2, %rbx
    storedp:
    movss ten(%rip), %xmm1
    mulss %xmm1, %xmm0
    xorq %rax, %rax
    cvttss2si %xmm0, %rax
    lea buffer(%rip), %rdi
    movb %al, (%rdi,%rbx,1)
    addb $0x30, (%rdi, %rbx, 1)
    xorq %rax, %rax
    movb (%rdi, %rbx, 1), %al
    subb $0x30, %al
    cvtsi2ss %rax, %xmm1
    subss %xmm1, %xmm0
    inc %rbx
    cmp $9, %rbx
    je print
    jmp storedp

    print:
    movq $1, %rax
    movq $1, %rdi
    lea m2_start(%rip), %rsi
    movq $(m2_end-m2_start), %rdx
    syscall

    movq $1, %rax
    movq $1, %rdi
    lea buffer(%rip), %rsi
    movq $9, %rdx
    syscall
    end:
    movq $60, %rax
    xorq %rdi, %rdi
    syscall


    error:
    movq $1, %rax
    movq $1, %rdi
    lea error_start(%rip), %rsi
    movq $(error_end-error_start), %rdx
    syscall
    jmp _start




.section .data
m1_start:
    .ascii "Enter a 1 digit number: "
m1_end:

m2_start:
    .ascii "The square root of the number you entered: "
m2_end:

error_start:
    .ascii "Invalid input!\n\r"
error_end:


.section .bss
tmp:
    .skip 1
buffer:
    .skip 9
number:
    .skip 1

.section .rodata
ten:
    .float 10

dot:
    .ascii "."
