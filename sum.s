.include "lib/readNumber.s"
.include "lib/printNumber.s"
.include "lib/validation.s"
.include "lib/sys_write.s"
.include "lib/sys_exit.s"

.section .data
errormsg: .string "error: invalid input\nthe provided arguments should only contain positive or negative numbers, other characters are not allowed\n"
errormsg_len: .quad . - errormsg

.section .text
.global  _start
_start:
	movq %rsp, %rbp

	movq (%rbp), %rbx
	addq $8, %rbp

	cmpq $1, %rbx
	je   exit_success

section0:
.LP0:
	addq $8, %rbp
	movq (%rbp), %rdi
	call validation
	cmpq $0, %rax
	jne  exit_error

	movq (%rbp), %rdi
	call  readNumber  # the result is in xmm0
	addsd %xmm0, %xmm4

	decq %rbx
	cmpq $1, %rbx
	jg   .LP0

section1:
	movsd %xmm4, %xmm0
	movq  $-1, %rdi
	call  printNumber

	writeln $1
exit_success:
	exit $0

exit_error:
	write $1, errormsg(%rip), errormsg_len(%rip)
	exit $-1
