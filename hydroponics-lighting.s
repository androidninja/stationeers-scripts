define GrowLight HASH("StructureGrowLight")
define DaylightSensor HASH("StructureDaylightSensor")
define HydroponicsStation HASH("StructureHydroponicsStation")

alias solarAngle r0

start:
sleep 1
lb solarAngle DaylightSensor Vertical Maximum
bgt solarAngle 200 off
blt solarAngle 70 off
on:
sb HydroponicsStation On 1
j start
off:
sb HydroponicsStation On 0
j start