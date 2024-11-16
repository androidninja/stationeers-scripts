#TonyTracker to turn on Base Beacon
define LEDDisplay HASH("StructureConsoleLED5")
define TonyTracker HASH("StructureLogicTransmitter")
define BaseBeacon HASH("StructureBeacon")

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
sbn BaseBeacon HASH("Beacon Main Base") On 0
j start

checktony:
lbn TSquaredX TonyTracker HashName PositionX Maximum
lbn TSquaredY TonyTracker HashName PositionY Maximum
lbn TSquaredZ TonyTracker HashName PositionZ Maximum
floor TSquaredX TSquaredX
floor TSquaredY TSquaredY
floor TSquaredZ TSquaredZ

blt TSquaredX -54 BeaconOn
bgt TSquaredX 46 BeaconOn
blt TSquaredZ -61 BeaconOn
bgt TSquaredZ 39 BeaconOn
j ra

j start

BeaconOn:

sbn BaseBeacon HASH("Beacon Main Base") On 1
j start