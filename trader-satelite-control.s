define SDish HASH("StructureSatelliteDish")
define SatAngleDisplay HASH("StructureConsoleLED5")
define AngleDial HASH("StructureLogicDial")

alias SatDishHorizontal r15
alias SatDishVertical r14
alias VertAngleSetting r13
alias HoriAngleSetting r12

start:
sleep 1
lbn r15 SDish HASH("MainSatDish") Horizontal Maximum
lbn r14 SDish HASH("MainSatDish") Vertical Maximum
trunc r14 r14
trunc r15 r15
sbn SatAngleDisplay HASH("SatHoriDisplay") Setting r15
sbn SatAngleDisplay HASH("SatVertDisplay") Setting r14

lbn r13 AngleDial HASH("HorizontalAngleDial") Setting Maximum
lbn r12 AngleDial HASH("VerticalAngleDial") Setting Maximum

add r13 r13 1
mul r13 r13 10
add r12 r12 1
mul r12 r12 10
sbn SDish HASH("MainSatDish") Horizontal r13
sbn SDish HASH("MainSatDish") Vertical r12

j start