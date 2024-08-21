.global validation
.type   validation, @function
validation:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rbx
	pushq %rsi

	xor  %rax, %rax
	movq %rdi, %rsi

	lodsb
	cmpb $0, %al
	je   exit_invalid
	cmpb $'-', %al
	je   .LPV0
	cmpb $'.', %al
	jne  .+11
	movq $1, %rbx
	je   .LPV0
	cmpb $'0', %al
	jb   exit_invalid
	cmpb $'9', %al
	ja   exit_invalid

	jmp .LPV0

sectionV0:
	cmpq $1, %rbx
	je   exit_invalid
	movq $1, %rbx

.LPV0:
	lodsb
	cmpb $0, %al
	je   exit_valid

	cmpb $'-', %al
	je   exit_invalid
	cmpb $'.', %al
	je   sectionV0
	cmpb $'0', %al
	jb   exit_invalid
	cmpb $'9', %al
	ja   exit_invalid

	jmp .LPV0

exit_valid:
	movq $0, %rax
	popq %rsi
	popq %rbx
	leave
	ret

exit_invalid:
	movq $-1, %rax
	popq %rsi
	popq %rbx
	leave
	ret
