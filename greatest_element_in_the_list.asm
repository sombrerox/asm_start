# Find largest element in the list
# Written in ASM for x86 Linux

.section .data

# 0 (zero) denotes the end of the list
list_elements:
    .long 7,19,1,23,45,78,112,25,10,7,0
	
    .section .text
	
    .globl _start
_start:
    movl $0, %edi # we set index of the highest element to 0
    movl list_elements(,%edi,4), %eax # set first element in eax
    movl %eax, %ebx # initially set value loaded in eax to be the largest (load it in ebx)
    
start_check:
    cmpl $0, %eax # compare current value in eax with 0 (so we know if we reached end)
    je end_check
    incl %edi
    movl list_elements(,%edi,4), %eax
    cmpl %ebx, %eax
    jle start_check
    movl %eax, %ebx
    jmp start_check
    
end_check:
    movl $1, %eax
    int $0x80
