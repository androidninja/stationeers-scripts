define TempSensor HASH("StructureGasSensor")
define WaterHeater HASH("StructureLiquidPipeHeater")
define WaterPipeAnal HASH("StructureLiquidPipeAnalyzer")
define WaterTempDisplay HASH("StructureConsoleLED5")
define WallVent HASH("StructureActiveVent")

alias WaterTemp r15
alias AirTemp r14
alias InVentPress r13

sb WallVent Lock 1
sbn WallVent HASH("Cooler-Vent-Out") Mode 1
sbn WallVent HASH("Cooler-Vent-In") Mode 0

start:
sleep 1
move r13 200
sbn WallVent HASH("Cooler-Vent-In") PressureExternal r13
s db Setting r13
lbn WaterTemp WaterPipeAnal HASH("WaterPipeAnal") Temperature Maximum
sub r15 r15 273.15
lbn AirTemp TempSensor HASH("HydroponicsTempSens") Temperature Maximum
sub r14 r14 273.15
sbn WaterTempDisplay HASH("WaterTempDisplay") Setting r15
blt WaterTemp 19 on
bgt WaterTemp 21 off
bgt AirTemp 24 CoolerOn
blt AirTemp 22 CoolerOff
j start

on:
sb WaterHeater On 1
j start

off:
sb WaterHeater On 0
j start

CoolerOn:

sbn WallVent HASH("Cooler-Vent-In") On 1
sleep 1
sbn WallVent HASH("Cooler-Vent-Out") On 1
j start



CoolerOff:
sbn WallVent HASH("Cooler-Vent-Out") On 0
sleep 10
sbn WallVent HASH("Cooler-Vent-In") On 0
j start