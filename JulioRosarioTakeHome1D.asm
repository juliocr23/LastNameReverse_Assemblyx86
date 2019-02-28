TITLE Question 1 part D  
  
INCLUDE Irvine32.inc
.data  
array1 byte 2," ",6,"*",4," ",1,"*",1," ",1,"*",1," ",1,"*",1," "
array2 byte 1,"*",8," ",1,"*",1," ",1,"*",3," ",2,"*",1," "
array3 byte 1,"*",8," ",1,"*",6," ",1,"*",1," "
array4 byte 1,"*",8," ",1,"*",6," ",1,"*",1," "
array5 byte 2," ",6,"*",8," ",1,"*",1," "
 
COMMENT&
		   ******    * * *    
		 *        * *   **    
		 *        *      *     
		 *        *      *    
		   ******        *    
&COMMENT


 delta dword ?
 l dword ?
 lenarray1 = lengthof array1
 lenarray2 = lengthof array2
 lenarray3 = lengthof array3
 lenarray4 = lengthof array4
 lenarray5 = lengthof array5

 grandarray dword 12 dup(?) 
 ; grandarray contains the the three offsets and the 3 lengths of the arrays
 .code
main proc
 call clrscr
  
mov DH,10
mov DL,20   
;call gotoxy   ;line will start at 10 down 5 across
  
;---------------------------
; fill grandarray using the procedure fill
 call fill

;---------------------------

   MOV EAX,green
   call setTextColor
  
  MOV ECX,15
  call gotoxy
  MOV EAX,50
  L1:
	PUSH EDX
	call printPict	
	POP EDX
	sub DL,1
	call gotoXY
	call delay
  LOOP L1

  MOV DL,0
  MOV DH,20
  call gotoXY


   exit  
     
main ENDP
drawline proc
     
    lineloop:    
       call writechar
    loop lineloop
    ret
 drawline endp
 
fill proc 
; dword array will be of the form 
; off len off len off len
  mov esi,offset grandarray

  mov [esi],offset array1
  add esi,4
  mov ebx, lenarray1/2
  mov [esi],ebx

  add esi,4
  mov [esi],  offset array2
  add esi,4
  mov ebx, lenarray2/2
  mov [esi],ebx

  add esi,4
  mov [esi],  offset array3
  add esi,4
  mov ebx, lenarray3/2
  mov [esi],ebx

  ADD ESI,4
  MOV [ESI], offset array4
  add ESI,4
  MOV EBX, lenarray4/2
  MOV[ESI],EBX
  add ESI,4

  MOV [ESI],offset array5
  add ESI,4
  MOV EBX,lenarray5/2
  MOV[ESI],EBX

  ret
fill endp

printPict PROC  USES ECX EDI EAX

; loop around 5 times to print each line with drawline
 mov esi,offset grandarray
 sub esi,4   ; we start a dword back
 mov ecx,5
 outer:
   push ecx
   ; get each array from grandarry data
   add esi,4
   mov edi, [esi]
   add esi, 4
   mov ecx, [esi]
   mov l,ecx
   mov ecx, l
   
   inner:
     push ecx     ;use data from eachg line to det up  
     mov ecx,0
     mov   cl, [edi]
      
     inc edi
     mov al,[edi]
     call drawline
     inc edi
      
     pop ecx
   loop inner
   inc dh
    
   pop ecx
   call gotoxy
  loop outer

ret
printPict ENDP
 END main