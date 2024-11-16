push HASH("D0")
push 1
push HASH("D1")
push 2
push HASH("D2")
push 3
push HASH("D3")
push 4
push HASH("D4")
push 5
push HASH("D5")
push 6
push HASH("D6")
push 7
push HASH("D7")
push 8


alias dArm d0

alias rNameHash r0
alias rTargetIndex r1
alias rArmIdle r2
alias rTakeFromIndex r3
alias rPutAtIndex r4
alias rStackEnd r5

alias rTemp1 r6
alias rTemp2 r7
alias rTemp3 r8

define trayHash HASH("StructureHydroponicsTrayData")
define ChuteImport HASH("StructureChuteBin")
define pickupIndex 9
# define pickupFertilizerIndex 5
define dropIndex 0
define stackStart 0
define stackEnd 15

add sp stackStart 1
add rStackEnd stackEnd 2

s db Setting -2

loop:
sleep 1
jal VendingImport
peek rNameHash
add sp sp 1
peek rTargetIndex
add sp sp 1
brle sp rStackEnd 3
move sp 1
j loop
lbns rTemp1 trayHash rNameHash 0 Occupied 1
beq rTemp1 0 plant
lbns rTemp1 trayHash rNameHash 0 Mature 1
lbns rTemp2 trayHash rNameHash 0 Seeding 1
add rTemp3 rTemp1 rTemp2
bgt rTemp3 0 harvest
# lbns rTemp1 trayHash rNameHash 1 Occupied 1
# beq rTemp1 0 fertilize
j loop

#fertilize:
#move rTakeFromIndex pickupFertilizerIndex
#move rPutAtIndex rTargetIndex
#j takeAndPut

harvest:
move rTakeFromIndex rTargetIndex
move rPutAtIndex dropIndex
j takeAndPut

plant:
move rTakeFromIndex pickupIndex
move rPutAtIndex rTargetIndex
j takeAndPut

takeAndPut:
s dArm Setting rTakeFromIndex
jal wait
s dArm Activate 1
jal wait
s dArm Setting rPutAtIndex
jal wait
s dArm Activate 1
jal wait
j loop

wait:
sleep 3
l rArmIdle dArm Idle
breq rArmIdle 0 -2
j ra

VendingImport:
lbns r15 ChuteImport HASH("Chute-Vending-Input") 0 Occupied Maximum
bnez r15 OpenChute
j ra

OpenChute:
sbn ChuteImport HASH("Chute-Vending-Input") Open 0
j ra