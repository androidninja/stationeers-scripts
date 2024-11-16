define DoorLever HASH("StructureLogicSwitch")
define LrgHangarDoors HASH("StructureLargeHangerDoor")
define SmlHangarDoors HASH("StructureAirlockGate")

alias isOpen r15
alias isClosed r14

start:
sleep 1
lbn r15 DoorLever HASH("OpenHangarDoors") Open Maximum
s db Setting r15
sb LrgHangarDoors Open r15
sb SmlHangarDoors Open r15
j start