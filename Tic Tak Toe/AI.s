.text
start:
  mov r3,#-1
	mov r4,#-2
	mov r5,#-3
	mov r6,#-4
	mov r7,#-5
	mov r8,#-6
	mov r9,#-7
	mov r10,#-8
	mov r11,#-9
	mov r14,#1
	mov r0,#0
	mov r1,#0
	ldr r2,=msg1
	swi 0x204
sel1:  ;select x or 0
	swi 0x202
	cmp r0,#0
	beq sel1
	
	mov r13,r0
	mov r12,#1
	mov r0,#2
	mov r1,#3
	ldr r2,=lv

lnv:	swi 0x204   ;verticle |
	add r12,r12,#1
	add r0,r0,#2
	cmp r12,#3
	bne lnv
	addeq r1,r1,#2
	mov r0,#2
	mov r12,#1
	cmp r1,#9
	bne lnv
	
	mov r12,#1
	mov r0,#1
	mov r1,#4
	ldr r2,=lh
lnh:	swi 0x204 ;horizontal ---
	add r12,r12,#1
	add r0,r0,#2
	cmp r12,#4
	bne lnh
	addeq r1,r1,#2
	mov r0,#1
	mov r12,#1
	cmp r1,#8
	beq play
	bne lnh

ai:;AI MODE
cmp r14,#2
cmpeq r12,#5
movne r12,#5
bne chk1
cmp r14,#2
cmpeq r12,#5
moveq r12,#1
beq chk1

ai2:
cmp r5,#-3
cmpeq r3,r4
moveq r12,#3
beq chk1
cmp r4,#-2
cmpeq r3,r5
moveq r12,#2
beq chk1
cmp r9,#-7
cmpeq r3,r6
moveq r12,#7
beq chk1
cmp r6,#-4
cmpeq r3,r9
moveq r12,#4
beq chk1
cmp r11,#-9
cmpeq r3,r7
moveq r12,#9
beq chk1
cmp r10,#-8
cmpeq r4,r7
moveq r12,#8
beq chk1
cmp r5,#-3
cmpeq r4,r3
moveq r12,#3
beq chk1
cmp r3,#-1
cmpeq r4,r5
moveq r12,#1
beq chk1
cmp r9,#-7
cmpeq r5,r7
moveq r12,#7
beq chk1
cmp r3,#-1
cmpeq r5,r4
moveq r12,#1
beq chk1
cmp r4,#-2
cmpeq r5,r3
moveq r12,#2
beq chk1
cmp r11,#-9
cmpeq r5,r8
moveq r12,#9
beq chk1
cmp r8,#-6
cmpeq r5,r11
moveq r12,#6
beq chk1
cmp r8,#-6
cmpeq r6,r7
moveq r12,#6
beq chk1
cmp r9,#-7
cmpeq r6,r3
moveq r12,#7
beq chk1
cmp r3,#-1
cmpeq r6,r9
moveq r12,#1
beq chk1
cmp r6,#-4
cmpeq r8,r7
moveq r12,#4
beq chk1
cmp r11,#-9
cmpeq r8,r5
moveq r12,#9
beq chk1
cmp r5,#-3
cmpeq r8,r11
moveq r12,#3
beq chk1
cmp r5,#-3
cmpeq r9,r7
moveq r12,#3
beq chk1
cmp r3,#-1
cmpeq r9,r6
moveq r12,#1
beq chk1
cmp r6,#-4
cmpeq r9,r3
moveq r12,#4
beq chk1
cmp r11,#-9
cmpeq r9,r10
moveq r12,#9
beq chk1
cmp r10,#-8
cmpeq r9,r11
moveq r12,#8
beq chk1
cmp r4,#-2
cmpeq r10,r7
moveq r12,#2
beq chk1
cmp r11,#-9
cmpeq r10,r9
moveq r12,#9
beq chk1
cmp r9,#-7
cmpeq r10,r11
moveq r12,#7
beq chk1
cmp r3,#-1
cmpeq r11,r7
moveq r12,#1
beq chk1
cmp r9,#-7
cmpeq r11,r10
moveq r12,#7
beq chk1
cmp r10,#-8
cmpeq r11,r9
moveq r12,#8
beq chk1
cmp r5,#-3
cmpeq r11,r8
moveq r12,#3
beq chk1
cmp r8,#-6
cmpeq r11,r5
moveq r12,#6
beq chk1

ai3:
cmp r3,#-1
moveq r12,#1
beq chk1
cmp r5,#-3
moveq r12,#3
beq chk1
cmp r9,#-7
moveq r12,#7
beq chk1
cmp r11,#-9
moveq r12,#9
beq chk1
cmp r4,#-2
moveq r12,#2
beq chk1
cmp r6,#-4
moveq r12,#4
beq chk1
cmp r8,#-6
moveq r12,#6
beq chk1
cmp r11,#-8
moveq r12,#8
beq chk1


play:   ;entering the game
	mov r0,#0
	mov r1,#0
	cmp r13,#1
	ldreq r2,=p1 
	ldrne r2,=p2
	swi 0x208
	swi 0x204
	mov r0,#0
	mov r1,#1
	ldr r2,=msg2
	swi 0x204
   




sel2:   ;enter the position
	swi 0x203
	cmp r0,#0
	beq sel2
	
	clz r0,r0
	sub r0,r0,#31
	mvn r0,r0
	add r0,r0,#1
	cmp r0,#1
	blt error
	cmp r0,#9
	bgt error
	mov r12,r0
	b chk
	
error:   ;invalid position
	mov r0,#0
	mov r1,#0
	ldr r2,=err
	swi 0x208
	swi 0x204
	b sel2
error2: ;position checked
	mov r0,#0
	mov r1,#0
	ldr r2,=err2
	swi 0x208
	swi 0x204
	b sel2




chk:    ;overriding
	cmp r12,#1
	beq emt1
	cmpne r12,#2
	beq emt2
	cmpne r12,#3
	beq emt3
	cmpne r12,#4
	beq emt4
	cmpne r12,#5
	beq emt5
	cmpne r12,#6
	beq emt6
	cmpne r12,#7
	beq emt7
	cmpne r12,#8
	beq emt8
	cmpne r12,#9
	beq emt9

emt1:	cmp r3,#0
	blt chk1
	bne error2
emt2:	cmp r4,#0
	blt chk1
	bne error2
emt3:	cmp r5,#0
	blt chk1
	bne error2
emt4:	cmp r6,#0
	blt chk1
	bne error2
emt5:	cmp r7,#0
	blt chk1
	bne error2
emt6:	cmp r8,#0
	blt chk1
	bne error2
emt7:	cmp r9,#0
	blt chk1
	bne error2
emt8:	cmp r10,#0
	blt chk1
	bne error2
emt9:	cmp r11,#0
	blt chk1
	bne error2




chk1:  ;store x=1 or 0=2 in appropriate register 
	cmp r12,#1
	cmpeq r13,#1
	moveq r3,#2
	cmp r12,#1
	cmpeq r13,#2
	moveq r3,#1
	
	cmp r12,#2
	cmpeq r13,#1 
	moveq r4,#2
	cmp r12,#2
	cmpeq r13,#2
	moveq r4,#1

	cmp r12,#3
	cmpeq r13,#1
	moveq r5,#2
	cmp r12,#3
	cmpeq r13,#2
	moveq r5,#1
	
	cmp r12,#4
	cmpeq r13,#1
	moveq r6,#2
	cmp r12,#4
	cmpeq r13,#2
	moveq r6,#1

	cmp r12,#5
	cmpeq r13,#1
	moveq r7,#2
	cmp r12,#5
	cmpeq r13,#2
	moveq r7,#1
	
	cmp r12,#6
	cmpeq r13,#1
	moveq r8,#2
	cmp r12,#6
	cmpeq r13,#2
	moveq r8,#1

	cmp r12,#7
	cmpeq r13,#1
	moveq r9,#2
	cmp r12,#7
	cmpeq r13,#2
	moveq r9,#1

	cmp r12,#8
	cmpeq r13,#1
	moveq r10,#2
	cmp r12,#8
	cmpeq r13,#2
	moveq r10,#1
	
	cmp r12,#9
	cmpeq r13,#1
	moveq r11,#2
	cmp r12,#9
	cmpeq r13,#2
	moveq r11,#1

	b disp1


chk2:   ;winning comp
	cmp r4,r3
	cmpeq r5,r4
	beq win
	cmpne r7,r6
	cmpeq r8,r7
	beq win
	cmpne r10,r9
	cmpeq r11,r10
	beq win
	cmpne r6,r3
	cmpeq r9,r6
	beq win
	cmpne r7,r4
	cmpeq r10,r7
	beq win
	cmpne r8,r5
	cmpeq r11,r8
	beq win
	cmpne r7,r5
	cmpeq r9,r7
	beq win
	cmpne r7,r3
	cmpeq r11,r7
	beq win
	bne prnt1


disp1:  ;check position of r0 nd r1
	mov r0,r12
	mov r1,#3
	cmp r0,#3
	movgt r1,#5
	cmp r0,#6
	movgt r1,#7
	
	cmp r1,#3
	beq sr1
	cmp r1,#5
	beq sr2
	cmp r1,#7
	beq sr3
sr1:
	cmp r0,#3
	addeq r0,r0,#2
	cmp r0,#2
	addeq r0,r0,#1	
	b prnt
sr2:	
	cmp r0,#4
	subeq r0,r0,#3
	cmp r0,#5
	subeq r0,r0,#2
	cmp r0,#6
	subeq r0,r0,#1
	b prnt
sr3:
	cmp r0,#7
	subeq r0,r0,#6
	cmp r0,#8
	subeq r0,r0,#5
	cmp r0,#9
	subeq r0,r0,#4
	b prnt
prnt: ;display x and 0 
	cmp r13,#1
	ldreq r2,=dp0
	cmp r13,#2
	ldreq r2,=dp1
	swi 0x204
	b chk2 ;check 4 winning
	
prnt1:   ;r14++ and r13 to change x->o or o->x nd if no draw no win go to play
	cmp r14,#9
	beq draw
	addne r14,r14,#1
	
	cmp r13,#1
	moveq r13,#2
	movne r13,#1
	

cmp r14,#3
beq play
cmp r14,#5
beq play
cmp r14,#7
beq play
cmp r14,#9
beq play	
cmp r14,#2
beq ai
cmp r14,#4
beq ai2
cmp r14,#6
beq ai2
cmp r14,#8
beq ai2




draw:  ;print draw nd exit
	mov r0,#0
	mov r1,#0
	ldr r2,=drw
	swi 0x208
	swi 0x204
	swi 0x11

win:  ;print win nd exit
	cmp r13,#1
	ldreq r2,=win0
	ldrne r2,=winx
	mov r0,#0
	mov r1,#0
	swi 0x208
	swi 0x204
	swi 0x11

win0:.asciz "Player 0 wins :)"
winx:.asciz "Player X wins :)"
msg1:.asciz "Press LBB to choose x or RBB to choose 0"
msg2:.asciz "Enter the box no u want to tick(1-9)"
dp0:.asciz "0"
dp1:.asciz "X"
err:.asciz "Invalid Pos. Try Again"
err2:.asciz "Position Checked. Choose diff. Pos."
lv:.asciz "|"
lh:.asciz "-"
p1:.asciz "Player 0"
p2:.asciz "Player X"
drw:.asciz"Draw!!! No Win No Lose!!!"
.end
