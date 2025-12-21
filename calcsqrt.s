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

    flush_newline:
    movq $0, %rax
    movq $0, %rdi
    lea tmp(%rip), %rsi
    movq $1, %rdx
    syscall
    cmpb $0x0A, tmp(%rip)
    je done_flush
    jmp flush_newline

    done_flush:
    cmpb $'0', number(%rip)
    jl error
    cmpb $'9', number(%rip)
    jg error
    xorq %rax, %rax
    movq number(%rip), %rax
    subq $0x30, %rax

    cvtsi2ss %rax, %xmm0

    sqrtss %xmm0, %xmm0
    xorq %rax, %rax
    cvttss2si %xmm0, %rax
    movb %al, buffer(%rip)
    addb $0x30, buffer(%rip)

    movq $1, %rax
    movq $1, %rdi
    lea m2_start(%rip), %rsi
    movq $(m2_end-m2_start), %rdx
    syscall

    movq $1, %rax
    movq $1, %rdi
    lea buffer(%rip), %rsi
    movq $1, %rdx
    syscall

    movq $1, %rax
    movq $1, %rdi
    lea dot(%rip), %rsi
    movq $1, %rdx
    syscall

    subb $0x30, buffer(%rip)
    xorq %rax, %rax
    movb buffer(%rip), %al

    cvtsi2ss %rax, %xmm1
    subss %xmm1, %xmm0

    movq $7, %rbx
    printdp:
    movss ten(%rip), %xmm1
    mulss %xmm1, %xmm0
    xorq %rax, %rax
    cvttss2si %xmm0, %rax
    movb %al, buffer(%rip)
    addb $0x30, buffer(%rip)
    movq $1, %rax
    movq $1, %rdi
    lea buffer(%rip), %rsi
    movq $1, %rdx
    syscall
    subb $0x30, buffer(%rip)
    xorq %rax, %rax
    movb buffer(%rip), %al
    cvtsi2ss %rax, %xmm1
    subss %xmm1, %xmm0
    dec %rbx
    cmp $0, %rbx
    je end
    jmp printdp

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

dot:
    .ascii "."

.section .bss
tmp:
    .skip 1
buffer:
    .skip 1
number:
    .skip 1

.section .rodata
ten:
    .float 10
