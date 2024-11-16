define ActiveVent HASH("StructureActiveVent")
define GasSensor HASH("StructureGasSensor")
define PipeAnal HASH("StructurePipeAnalysizer")
define Display HASH("StructureConsoleLED5")

alias O2Content r15
alias CO2Content r14
alias NContent r13
alias PollutantContent r12
alias RoomPressure r11
alias RoomTemp r10

sb ActiveVent Lock 1

loop:
yield
lb O2Content GasSensor RatioOxygen Maximum
lb CO2Content GasSensor RatioCarbonDioxide Maximum
lb NContent GasSensor RatioNitrogen Maximum
lb PollutantContent GasSensor RatioPollutant Maximum
lb RoomPressure GasSensor Pressure Maximum
lb RoomTemp GasSensor Temperature Maximum
sub r10 r10 273.15 # Convert kelvin to celsius
mul r15 r15 100 # Convert gas readings to percentages
mul r14 r14 100
mul r13 r13 100
mul r12 r12 100
sbn Display HASH("O2-Display") Setting O2Content
sbn Display HASH("CO2-Display") Setting CO2Content
sbn Display HASH("N-Display") Setting NContent
sbn Display HASH("TempDisplay") Setting RoomTemp
sbn Display HASH("PressureDisplay") Setting RoomPressure
jal CheckPressure
jal CheckOxygen
jal CheckNitrogen
jal CheckCarbonDioxide
j loop

CheckPressure:
bgt RoomPressure 115 OpenOutput
blt RoomPressure 90 CloseOutput
j ra

OpenOutput:
sbn ActiveVent HASH("Atmos-Output-Vent") Mode 1
sbn ActiveVent HASH("Atmos-Output-Vent") On 1
j ra

CloseOutput:
sbn ActiveVent HASH("Atmos-Output-Vent") On 0
j ra

CheckOxygen:
bgt RoomPressure 115 CheckPressure
bgt O2Content 95 TurnOffO2
blt O2Content 70 AddO2
j ra

CheckNitrogen:
bgt RoomPressure 115 CheckPressure
bgt NContent 8 TurnOffN
blt NContent 2 AddN
j ra

CheckCarbonDioxide:
bgt RoomPressure 115 CheckPressure
bgt CO2Content 20 TurnOffCO2
blt CO2Content 5 AddCO2
j ra

AddO2:
sbn ActiveVent HASH("O2-Input-Vent") Mode 0
sbn ActiveVent HASH("O2-Input-Vent") On 1
j ra

TurnOffO2:
sbn ActiveVent HASH("O2-Input-Vent") On 0
j ra

TurnOffN:
sbn ActiveVent HASH("N-Input-Vent") On 0
j ra

AddN:
sbn ActiveVent HASH("N-Input-Vent") Mode 0
sbn ActiveVent HASH("N-Input-Vent") On 1
j ra

TurnOffCO2:
sbn ActiveVent HASH("CO2-Input-Vent") On 0
j ra

AddCO2:
sbn ActiveVent HASH("CO2-Input-Vent") Mode 0
sbn ActiveVent HASH("CO2-Input-Vent") On 1
j ra