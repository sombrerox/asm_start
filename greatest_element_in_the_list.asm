# Find largest element in the list
# Written in ASM for x86 Linux

.section .data

# 0 (zero) denotes the end of the list
list_elements:
    .long 7,19,1,23,45,78,112,25,10,7,0
	
    .section .text
	
    .globl _start
_start:
    movl $0, %edi #we set index of the highest element to 0
    movl list_elements(,%edi,4), %eax #set first element in eax
    movl %eax, %ebx #initially set value loaded in eax to be the largest (load it in ebx)
    
start_check:
    cmpl $0, %eax #compare current value in eax with 0 (so we know if we reached end)
    je end_check #if current value is equal to 0 we have reached the end of the list, end the loop
    incl %edi #increment index
    movl list_elements(,%edi,4), %eax #set eax to next number
    cmpl %ebx, %eax #compare current number with greatest we have found so far 
    jle start_check #if current number is less than or equal to the greatest we have found until now, go back to start of the loop
    movl %eax, %ebx #otherwise if it's greater move it to ebx
    jmp start_check #unconditionally jump to start of the loop
    
end_check:
    movl $1, %eax #move 1 to eax (1 representing exit code, it is read from eax register when system exit call is made,
    	          #value of ebx is return status code, which will in our case be value of the greatest number in the list)
    int $0x80 #make a system call
