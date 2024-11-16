define GlassDoor HASH("StructureGlassDoor")
define GasSensor HASH("StructureGasSensor")
define ActiveVent HASH("StructureActiveVent")
define Lever HASH("StructureLogicSwitch")
define Speaker HASH("StructureKlaxon")

define Speaker1 HASH("AL1-KLAXON")
define Speaker2 HASH("AL2-KLAXON")

alias al1State r15
alias al2State r14
alias lever r13
alias pressure r12

lbn al1State GlassDoor HASH("AL1-DOOR-IN") Open Maximum
add al2State al1State 1
mod al2State al2State 2
sb GlassDoor Mode 1
sb Speaker Volume 100

start:
sleep 1
lb lever Lever Open Maximum
beq lever 1 toggle
j start

toggle:
sb Lever Lock 1
sb Lever Open 1
sb GlassDoor Open 0
add al1State al1State 1
mod al1State al1State 2
add al2State al2State 1
mod al2State al2State 2
beq al2State 1 AL2inside
AL1inside:
sbn ActiveVent HASH("AL1-VENT-OUT") Mode 1
sbn ActiveVent HASH("AL1-VENT-OUT") On 1
sbn ActiveVent HASH("AL2-VENT-IN") Mode 1
sbn ActiveVent HASH("AL2-VENT-IN") On 1
jal speaker
jal waitBothEmpty
sbn ActiveVent HASH("AL1-VENT-OUT") On 0
sbn ActiveVent HASH("AL2-VENT-IN") On 0
sbn GlassDoor HASH("AL1-DOOR-IN") Open 1
sbn GlassDoor HASH("AL2-DOOR-OUT") Open 1
sleep 1
sbn Speaker Speaker1 Mode 25 #welcome
j unlock
AL2inside:
sbn ActiveVent HASH("AL2-VENT-OUT") Mode 1
sbn ActiveVent HASH("AL2-VENT-OUT") On 1
sbn ActiveVent HASH("AL1-VENT-IN") Mode 1
sbn ActiveVent HASH("AL1-VENT-IN") On 1
jal speaker
jal waitBothEmpty
sbn ActiveVent HASH("AL2-VENT-OUT") On 0
sbn ActiveVent HASH("AL1-VENT-IN") On 0
sbn GlassDoor HASH("AL1-DOOR-OUT") Open 1
sbn GlassDoor HASH("AL2-DOOR-IN") Open 1
sleep 1
sbn Speaker Speaker2 Mode 25 #welcome
j unlock

speaker:
sb Speaker Mode 22 #airlock
sb Speaker On 1
sleep 0.4
sb Speaker Mode 20 #depressure
sleep 1
sb Speaker Mode 9
j ra
waitBothEmpty:
sleep 1
lbn pressure GasSensor HASH("AL-GAS") Pressure Maximum
bgt pressure 0 waitBothEmpty
j ra
unlock:
sb Lever Open 0
sleep 2
sb Lever Lock 0
sb Speaker On 0
j start