.data
	Space : .asciiz  " "
	newline: .asciiz "\n"
	Size : .asciiz "Please enter size of array"
	temp: .word 0 : 100
	array: .space 100
	msg1: .asciiz "Choose sort algorithm by entering its number"
	msg2: .asciiz "1-Bubble sort"
	msg3: .asciiz "2-Selection sort"
	msg4: .asciiz "3-Merge sort"
	msg5:.asciiz "Enter valid number"
	message_search: .asciiz "Enter a number to find index in sorted array "
	message: .asciiz "the number is not found"
	message2: .asciiz "the number is found in index "
.text
#######################################################
 Main:
        #print Size messgae
 	la   $a0, Size	      # load address of size to a0	
	li   $v0, 4	      # load 4 to v0 to print string
	syscall               # call the operating system to excute
	      
	#print new line 
	la   $a0, newline    # load address of newline to a0	
	li   $v0, 4	     # load 4 to v0 to print string
	syscall              # call the operating system to excute
	
	#sacn size from user
        li $v0, 5	    # load 5 to v0 to print intger
    	syscall             # call the operating system to excute
    	
    	move $t0, $v0    	#size of array user entered moved to $t0
	addi, $sp, $sp, -4       #prepare stack to push
	sw, $t0, 0($sp)  	#store size in memory for later use
   	add $t1,$zero,0	 	# i = 0 for array indexing
   	la $t5,array     	# load array address 
   	
for_Scan_Array:        # for loop to scan element of array
   	bge $t1,$t0, while_switch_case       # branch if i > size
   	sll $t4,$t1,2		             # multiply $t1 by 4 and store it in $t4
	addu $t4,$t4,$t5	             # here we get array[index] to scan from user 
	
	li $v0, 5		#scan element from user
    	syscall                # call the operating system to excute
    		
        move $t6, $v0		#move it to $t6
		
	sw $t6,0($t4)		#and store it in array with current index
	addi $t1,$t1,1		#index ++ and i++
	j for_Scan_Array		#loop
	
while_switch_case:
	#print message
	la   $a0, msg1		#next lines prints some messgaes which guide user
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	#print newline
	la   $a0, newline		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                  # call the operating system to excute
	#print message
	la   $a0, msg2		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                  # call the operating system to excute
	#print newline
	la   $a0, newline		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	#print message
	la   $a0, msg3		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	#print newline
	la   $a0, newline		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	#print message
	la   $a0, msg4		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	#print newline
	la   $a0, newline		
	li   $v0, 4		# load 4 to v0 to print string
	syscall                 # call the operating system to excute
	# scan integer from user
	li $v0, 5               # load 5 to v0 to print intger
    	syscall                 # call the operating system to excute
    	
	move $t1, $v0    #algorithm number the entered by user
	
       li $t9,0          #flag =0
       bnez $t9, End_while_switch    # branch if flag !=0
      
#case1_condition
       bne $t1,1, case2_condition    # branch if t1 != 1
       j case1_body                  # jump uncondition to case1_body 
       
case2_condition:                    # case 2con
       bne $t1,2, case3_condition   # branch if t1 != 2
       j case2_body                 # jump uncondition to case2_body 
       
case3_condition:                    # case 3_con          
        bne $t1,3, default         # branch if t1 != 3
         j case3_body              # jump uncondition to case3_body
       
       
case1_body:                               # case1_body
        #prepare argumeny of fun
        la $a0,array                      #load the address of array to reg $a0  ($a0=address)
        add $a1,$t0,0			  #load word in effictive address of label(length) a1= 10
        jal bubblesort                    #sotre pC in $ra  and jump to bubblesort function
	lw, $t3, 0($sp)		       	  #get size from memory to use it in print
 	subi $t3,$t3,1                    # size =size -1 to print 
	jal print		       	  #call print and save pc to ra register
        j breakk                          # jump uncondition to break
         
case2_body:                               # case2_body
	#prepare argumeny of fun
	la $a0,array                      #load the address of array to reg $a0  ($a0=address)
        add $a1,$t0,0		          #load word in effictive address of label(length) a1= 10
	jal selectionsort                 #sotre pC in $ra  and jump to selectionsort function
	lw, $t3, 0($sp)			  #get size from memory to use it in print 
 	subi $t3,$t3,1                    # size =size -1 to print 
	jal print	                  #call print and save pc to ra register
	j breakk                          # jump uncondition to break
			
case3_body:                               # case1_body
	#prepare argumeny of fun
	la $t5,array                      #load address of array in $t5
	la $t6,temp	                  #load address of temp in $t6 
 	addi $a1,$zero,0                  #left
 	subi $t0,$t0,1                    #decrease size by 1 to refer to the last element
 	add $a2,$t0,0                     #right
 	jal MergeSort                     #calling mergesort function
 	lw, $t3, 0($sp)                   #get size from memory to use it in print 
 	subi $t3,$t3,1                    # size =size -1 to print 
 	jal print                         #call print and save pc to ra register 
	j breakk                          # jump uncondition to break
	
default:
	#print message
	la   $a0, msg5		         #if invalid number this massage will be displayed 
	li   $v0, 4		
	syscall
	#print newline
	la   $a0, newline		
	li   $v0, 4		
	syscall
	
	j  while_switch_case 	         #jump to while to scan number from user agian
	
	
End_while_switch:
breakk:
 	#print newline
 	la   $a0, newline		
	li   $v0, 4		
	syscall
	#print message
 	li $v0,4                          # load 4 to $v0 to print string  
	la $a0,message_search             # load address of string which we need to print
	syscall                           # call the operating system to excute
        #print newline
	la   $a0, newline		
	li   $v0, 4		
	syscall
	# scan intger from user
	li $v0,5                          #load 5 to v0 to scan intger
	syscall                           # call the operating system to excute

	# arrgument of binary_search
	lw, $t3, 0($sp)			 #array size
	la $a0,array                     # load address of array to a0             
	add $a1,$t3,0                    # load the value of length to a1
	move $a2,$v0                     # a2 = v0 = the number we scan from user to searh it                 
	jal Binary_search                #sotre pC in $ra  and jump to Binary_search

if_main:                                # if condition to check the number is found or not
	bne   $t7,-1 end_program        # branch to end program if t7!= -1   (the number we want to search is found  )
	#print string
	li $v0,4                        # load 4 to $v0 to print string  
	la $a0,message                  # load address of string which we need to print
	syscall                         # call the operating system to excute

	# print newline
	li $v0,4                        # load 4 to $v0 to print string
	la $a0,newline                  # load address of string which we need to print
	syscall                         # call the operating system to excute

end_program:                   
 	li $v0,10                       # load 10 to v0 to end program
 	syscall                         # call the operating system to excute
 	
 	 	
############################################################
#function1
bubblesort:                         # function_name
     li $t0,1                            # t0 = 1   =>  swap = true
     move $t2,$a1                        #t2 = 3   length of array

while_bubblesort:                   # while loop
    bne $t0,1,exitbubblesort            #go to exit_bubble_sort if $t0 != 1  (swap = 0) 
    li $t0,0                            #swap=false
    li $t1,0                            #i=0  counter
    addi $t2,$t2,-1                     #t2= length-1     use in condition in for loop  
    move $t3,$a0                        #$t3=$a0= address of array   
for_bubblesort:                     #for loop
    bge $t1,$t2, exitfor_bubblesort     #go to exit_for if $t1 >= $t2
if_bubblesort:                      #if condition
    lw $s0, 0($t3)                      #put content of effiective memory word address in reg $s0         
    lw $s1, 4($t3)                      #put content of effiective memory word address in reg $s1    
    ble $s0,$s1,updatefor_bubblesort    #go to update_for  if $s0 <= $s1
    li $t0,1                            # put 1 in $t0   swap = true
    addi $sp,$sp,-4                     # prepare pointer stack to push element
    sw $ra, 0($sp)                      # push content of $ra to stack   because there is nested precuder
    jal Swap_bubblesort                 #sotre pC in $ra  and jump to Swap function 
 
updatefor_bubblesort:               #update to go next for loop   
   add $t1,$t1,1                       #add counter by 1 i=i+1
   sll $t3,$t1,2                       # two shift lift  means *2*2 =>  $t3= i*2*2
   add $t3,$a0,$t3                     # update address to hold the next element in array  
   j for_bubblesort                    # go to for  uncondition

exitfor_bubblesort:                 # if we here mean $t1 >= $t2  (i >= length-1)
   addi $a1,$a1,-1                     # $a1=$a1-1 (length-1) => $t2=length-2 in pass number 2 
   j while_bubblesort                  # go to while  uncondition 

exitbubblesort:                     # if we here mean $t0 != 1  (swap = 0) 
   lw $ra, 0($sp)                      # load return address from stack to return to main (pop)
   addi $sp,$sp,4                      # make pointer of stack point the element will be push 
   jr $ra                              # return to address when bubble_sort fun cal
# end bubblesort_function 	 	 	 	 		 	 	 	
#####################################################################

#function2
selectionsort:                        #function name
   li $t0,0                              # i=0 
   addi $t1,$a1,-1                       # t1 = length-1
   move $s0,$a0                          # s0 =a0 = address of array
for1_selectionsort:                                # for loop 
   bge $t0,$t1 Exit_selectionsort        # if t0 >= t1 go to label  (Exit_selectionsort)
   add $t2,$0,$t0                        # min = i (t2=0+t0) 
   addi $t3,$t0,1                        # j=i+1   (t3=t0+1)
   move $t4,$a1                          #  t4 =a1
for2_selectionsort:                   #for loop
   bgt $t3,$t4, updatefor1_selectionsort             # if t3> t4 go to updatefor11 
   sll $t5,$t3,2                         # 2 shift logic lift j mean j*2*2   t5=j*2*2    
   add $t5,$t5,$s0                       # add address of array to result of shift set to t5
   lw $t6,0($t5)                         # load in t6 the content of addrees t5 in 0 from memory 
   sll $t7,$t2,2                         # two shift life (min) means min*2*2 set to t7
   add $t7,$t7,$s0                       # t7 = t7(after siht *4) + address of array
   lw $t8,0($t7)  			      # load in t8 the content of addrees t7 in 0 from memory                         
if1_selectionsort:                    # if condition
   bge $t6,$t8, updatefor2_selectionsort	      # if t6 >= t8 go to updatefor22  (condition)
   add $t2,$0,$t3                        # min =j
   j updatefor2_selectionsort            #jump uncondition to updatefor22

updatefor2_selectionsort:             #label                      
   addi $t3,$t3,1                        # j=j+1     
   j for2_selectionsort                  # jump uncondition for22

updatefor1_selectionsort: 	      #label
   addi $sp,$sp,-4                       # prepare stack to push 
   sw $ra,0($sp)                         # push to stak address  

   jal swapselection_sort                # jump to swap fun and save pc to $ra 
   addi $t0,$t0,1                        # i=i+1
   j for1_selectionsort                  # jump uncondition to for11

Exit_selectionsort:                  #label 
   lw $ra ,0($sp)                       # load in ra the content in address sp           
   addi $sp,$sp,4                       # add potinter 4
   jr $ra                               # jump to address when he call the fun                                
#end function  	 	 	 	
####################################################################
 	 	 	 	 	 	
#function 3
MergeSort:
	slt $t0, $a1, $a2 	#if(l<r) in c code ..if right > left $t0=true 
	beq $t0, $zero, exitMergeSort #if right <= left $t0=0 and the function exits
	
	       #when we recurse we want the pervious values not the new ones so we store them in memory
	       #we will save four values 1-left 2-right 3-mid 4-the return address
	addi, $sp, $sp, -16 	#take enough space in memory for left,right,mid and the address we are going to return to  
	sw, $ra, 12($sp)	# save return address
	sw, $a1, 8($sp)	       	#save left in memory for later use
	sw, $a2, 4($sp)        	#save right in memory for later use

				#m = (l+r)/2 :
	add $s0, $a1, $a2       #$s0=l+r
	sra $s0,$s0,1	        #(l+r)/2
	sw $s0, 0($sp) 		# save value of m in stack for later use
				
        # now first call     mergeSort(arr, l, m);
	add $a2, $s0, $zero 	#right = mid
	jal MergeSort		#call mergesort with values l still same , r = m
	
	lw $s0, 0($sp)		#get back the value of m that we stored in memory 
	addi $s1, $s0, 1	#m+1
	add $a1, $s1, $zero 	#left = m + 1
	lw $a2, 4($sp) 		#get back right value that we saved in stack
	
	#now second call     mergeSort(arr, m + 1, r);
	jal MergeSort 		#call mergesort with values l=m+1 , r still the same
	
	lw, $a1, 8($sp) 	##get back left value that we saved in stack
	lw, $a2, 4($sp)  	##get back right value that we saved in stack
	lw, $a3, 0($sp) 	##get back mid value that we saved in stack and store it in $a3
	jal Merge		#call merge 	
				
	lw $ra, 12($sp)		# get $ra from stack
	addi $sp, $sp, 16 	# set stack pointer to its initial
	jr  $ra
exitMergeSort:
	jr $ra
#######################################################

#function 4
Merge:
	add $s0,$a1,$zero   #L1=low
	addi $s1,$a3,1      #L2=mid+1
	add $s2,$a1,$zero   #i=low
	
	
First_For:
        bgt $s0,$a3,ExistFirstFor #if l1>mid then exit #this line and the next one are the conditions of the loop
        bgt $s1,$a2,ExistFirstFor #if 12>right then exit #l1 <= mid && l2<=high
        	
        	#we will use temp to sort the array then get the values back to array
        	#we use here 3 indices so l1,l2,i so we get things prepared
        sll $t7,$s0,2  
        sll $t8,$s1,2	#these 3 lines multiply the values of l1,12,i by 4
        sll $t9,$s2,2
        	
        addu $t7,$t7,$t5  
        addu $t8,$t8,$t5 #and then we use the values we multiplied by 4 so we get a[l1],a[l2],b[i]
        addu $t9,$t9,$t6
        	
        lw $t3,0($t7)  #a[l1]
        lw $t4,0($t8)  #a[l2]
        	
        bgt $t3,$t4,else #check if a[l1]> a[l2] then else if not continue
        	 
        sw $t3,0($t9) #b[i] = a[l1]
        addi $s0,$s0,1 #l1++
        j end
        	
else:
        sw $t4,0($t9) #b[i]=a[l2]
        addi $s1,$s1,1 #l2++
end:
        addi $s2,$s2,1 #i++
        j First_For #loop
ExistFirstFor:  #exit
#after that we put in temp the remaining values that weren't compared
while_left:
        bgt $s0,$a3,Exit_while_Left #if l1 > mid then exit
        sll $t7,$s0,2
        sll $t9,$s2,2     #multiply l1,i by 4
        		
        addu $t7,$t7,$t5
        addu $t9,$t9,$t6  #get a[l1] , b[i]
        		
        lw $t3,0($t7)  
        sw $t3,0($t9) 	  #b[i]=a[l1]
        		
        addi $s0,$s0,1    #l1++
        addi $s2,$s2,1 #i++;
        		
        j while_left #loop
Exit_while_Left:  #exit
        	
while_right:
        bgt $s1,$a2,Exit_while_Right #if l2 > right then exit
        sll $t7,$s1,2
        sll $t9,$s2,2	#multiply l2,i by 4
        		
        addu $t7,$t7,$t5
        addu $t9,$t9,$t6    #get a[l2] , b[i]
        		
        lw $t3,0($t7)
        sw $t3,0($t9) #b[i]=a[l2]
        		
        addi $s1,$s1,1 #l2++
        addi $s2,$s2,1 #i++
        		
        j while_right #loop
Exit_while_Right: #exit
	add $s2,$a1,$zero #set i to the the begining of temp and array we started with "low"
		 #here we get values from temp to array
second_for:
	bgt $s2,$a2,exit_second_for #i>right then exit
		
	sll $t7,$s2,2 
	sll $t8,$s2,2 #multiply i by 4 
		
	addu $t7,$t7,$t5 
	addu $t8,$t8,$t6 #get a[i],b[i]
		
	lw $t3,0($t8)
	sw $t3,0($t7) #a[i]=b[i]
	addi $s2,$s2,1 #i++
	j second_for #loop
		
exit_second_for: #exit        	
sortEnd:
	jr $ra   #return
#end function		
#####################################################################


#function5
swapselection_sort:                   # fun name
   sll $t9 ,$t0,2                        # 2 shift left i*2*2  and store to t9
   add $t9,$t9,$s0                       #t9 = t9+s0 (base address)
   lw $s3,0($t9)                         # store content in address t9 to s3 
   sw $s3,0($t7)                         # store content of s3 to address in t7  
   sw $t8,0($t9)                         # store content of t8 to address in t9
   jr $ra                                # return to pc (when fun call) 
#end function
################################################################

#function6
Swap_bubblesort:                   # function_name
#sll $t7,$t4,2
#add $t7,$t1,$t7                   #the four instruciont not efficted if its found but repeat 
#lw $a0, 0($t7)
#lw $a1, 4($t7)
   sw $s1, 0($t3)                     #put content of  reg $s1 in effiective memory word address 0+$t7    
   sw $s0, 4($t3)                     #put content of  reg $s0 in effiective memory word address 4+$t7 
   jr $ra                             #go to return address  uncondition
#end function
#####################################################################

#function7
Binary_search:                              #fun name
   li $t1,0                                    #low=0 ($t2)
   addi $t2,$a1,-1                             #high=length-1  
while_Binary_search:                        #while loop
   bgt $t1,$t2, End_while_Binary_search        # go to End_while2 if low > high
   add $t3,$t1,$t2                             # mid ($t3)= $t1+$t2   0+9=9
   div $t3,$t3,2                               #mid =mid/2 =4 
   sll $t4,$t3,2                               # t4=4*2*2 =16
   add $t5,$a0,$t4                             #t5 = 0+16=16
   lw $t6,0($t5)                               #t6= mid element in array
if_Binary_search:                           # if condition
   bne $a2,$t6, else_if_Binary_search          # if number want to search != mid number in array
   #print messaage2
   li $v0,4                                    # load 4 to $v0 to print string                               
   la $a0,message2                             # load address of message2 to a0 
   syscall                                     # call the operating system to excute
   # ptint index
   li $v0,1                                    # load 1 to $v0 to print intger                       
   add $a0,$t3,$0                              # a0 = index +0  to print the number in a0
   syscall                                     # call the operating system to excute
   # print newline
   li $v0,4                                    # load 4 to $v0 to print string  
   la $a0,newline                              # load address of newline to a0  
   syscall                                     # call the operating system to excute

   #return to main
   jr $ra                                     # jump uncondition to place where its call
else_if_Binary_search:                     # else if
   bge $a2,$t6, else_Binary_search            # if number want ti search >= mid number in array 
   addi $t2,$t3,-1                            # high_index = mid_index-1
   j while_Binary_search                      # jump uncondition to while_Binary_search  
else_Binary_search:                        # else_Binary_search
   addi $t1,$t3,1                             # low_index = mid_index+1
   j while_Binary_search                      # jump uncondition to while_Binary_search
End_while_Binary_search:                   # End_while_Binary_search 
   li $t7,-1                                  # put -1 to t7  mean the number not found
   jr $ra                                     # # jump uncondition to place where its call
#end function
#####################################################################

#function8
print:
	add $t0,$zero,0 	# $t0 is the index of the first element in array
	add $t1, $t3, 0	        # $t1 is size-1
	la  $t4, array		# load the address of the array into $t4
	
Print_Array:
	blt  $t1, $t0, Exit	# if $t1 < $t0, go to exit
	sll  $t3, $t0, 2	# multiply $t0 by 4 and store it in $t3
	addu  $t3, $t3, $t4	# here we get array[index]
	lw   $t2, 0($t3)	#load vlaue of current element in $t2
	move $a0, $t2		#move it to $a0 to print it
	li   $v0, 1		
	syscall
	
	addi $t0, $t0, 1       # index ++
	la   $a0, Space	       #print space between elements
	li   $v0, 4	
	syscall
	j    Print_Array		# loop
	
Exit:
	jr $ra			# return to when it call
#end function

	
