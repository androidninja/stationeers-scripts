#TempControl for Greenhouse air supply
#Incomplete, need to pull the finished script from in game. Pressure check is incomplete

define TempSensor HASH("StructureGasSensor")
define WallHeater HASH("StructureWallHeater")
define TempDisplay HASH("StructureConsoleLED5")
define WallVent HASH("StructureActiveVent")

alias GHTemp r15
alias CoolerPipePress r14

sb WallVent Lock 1
sb WallHeater Lock 1
sbn WallVent HASH("Cooler-Vent-Out") Mode 1
sbn WallVent HASH("Cooler-Vent-In") Mode 0

start:
sleep 5
lbn GHTemp TempSensor HASH("Sensor-GH-Temp") Temperature Maximum
sub r15 r15 273.15
s db Setting r15
blt GHTemp 20 HeaterOn
bgt GHTemp 22 HeaterOff
bgt GHTemp 25 CoolerOn
blt GHTemp 23 CoolerOff

j start

HeaterOn:
sbn WallHeater HASH("Heater-GH") On 1
j start

HeaterOff:
sbn WallHeater HASH("Heater-GH") On 0
j start

CoolerOn:
sbn WallVent HASH("Cooler-Vent-In") On 1
sleep 0.5
sbn WallVent HASH("Cooler-Vent-Out") On 1
j start

CoolerOff:
sbn WallVent HASH("Cooler-Vent-Out") On 0
sleep 5
sbn WallVent HASH("Cooler-Vent-In") On 0g
j start

PressureCheck:
lbn CoolerPipePress WallVent HASH("Cooler-Vent-In") PressureInternal Maximum