#Activates power transformer when a Tony gets to the right altitude
define TonyTracker HASH("StructureLogicTransmitter")
define Transformer HASH("StructureTransformerSmall")

alias PositionTSquared r12
alias TSquaredX r13
alias TSquaredY r14
alias TSquaredZ r15
alias HashName r11

start:
sleep 1
move HashName HASH("TrackerTSquared")
jal checktony

move HashName HASH("TrackerDoubleT")
jal checktony

sbn Transformer HASH("Optimus") On 0
j start

checktony:
lbn TSquaredY TonyTracker HashName PositionY Maximum
floor TSquaredY TSquaredY
bge TSquaredY 25 PowerOn
j ra

j start

PowerOn:

sbn Transformer HASH("Optimus") On 1
j start