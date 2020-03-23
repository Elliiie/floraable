EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 6900 7550 0    50   Input ~ 0
SOIL
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5E410F95
P 9400 4250
F 0 "J3" H 9480 4242 50  0000 L CNN
F 1 "water pump" H 9480 4151 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 9400 4250 50  0001 C CNN
F 3 "~" H 9400 4250 50  0001 C CNN
	1    9400 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 4800 8000 4800
Text GLabel 8000 4800 0    50   Output ~ 0
PUMP
Connection ~ 8200 4800
$Comp
L power:GND #PWR016
U 1 1 5E35021B
P 8200 5400
F 0 "#PWR016" H 8200 5150 50  0001 C CNN
F 1 "GND" H 8205 5227 50  0000 C CNN
F 2 "" H 8200 5400 50  0001 C CNN
F 3 "" H 8200 5400 50  0001 C CNN
	1    8200 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5300 8200 5400
Connection ~ 8200 5300
Wire Wire Line
	8200 5300 9150 5300
Connection ~ 9150 4550
Wire Wire Line
	9150 4350 9150 4550
Wire Wire Line
	9200 4350 9150 4350
Wire Wire Line
	9150 4050 9150 4250
Wire Wire Line
	9150 4250 9200 4250
Wire Wire Line
	9150 5300 9150 5000
Wire Wire Line
	9150 4550 9150 4600
$Comp
L Device:Q_NMOS_GDS Q1
U 1 1 5E406AA8
P 9050 4800
F 0 "Q1" H 9254 4846 50  0000 L CNN
F 1 "IRL1404Z" H 9254 4755 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 9250 4900 50  0001 C CNN
F 3 "~" H 9050 4800 50  0001 C CNN
	1    9050 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 4800 8600 4800
$Comp
L Device:R R7
U 1 1 5E35020B
P 8450 4800
F 0 "R7" V 8243 4800 50  0000 C CNN
F 1 "150R" V 8334 4800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8380 4800 50  0001 C CNN
F 3 "~" H 8450 4800 50  0001 C CNN
	1    8450 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	8300 4800 8200 4800
Wire Wire Line
	8200 4800 8200 4900
$Comp
L Device:R R6
U 1 1 5E350215
P 8200 5050
F 0 "R6" H 8270 5096 50  0000 L CNN
F 1 "15k" H 8270 5005 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8130 5050 50  0001 C CNN
F 3 "~" H 8200 5050 50  0001 C CNN
	1    8200 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 4550 8800 4550
Wire Wire Line
	8800 4550 8800 4450
$Comp
L Device:D D1
U 1 1 5E3515ED
P 8800 4300
F 0 "D1" V 8754 4379 50  0000 L CNN
F 1 "D1" V 8845 4379 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P7.62mm_Horizontal" H 8800 4300 50  0001 C CNN
F 3 "~" H 8800 4300 50  0001 C CNN
	1    8800 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	8800 4150 8800 4050
Wire Wire Line
	8200 5200 8200 5300
Wire Wire Line
	8800 4050 9150 4050
Connection ~ 9150 4050
Wire Wire Line
	9150 4050 9150 4000
$Comp
L power:+5V #PWR018
U 1 1 5E35022F
P 9150 4000
F 0 "#PWR018" H 9150 3850 50  0001 C CNN
F 1 "+5V" H 9165 4173 50  0000 C CNN
F 2 "" H 9150 4000 50  0001 C CNN
F 3 "" H 9150 4000 50  0001 C CNN
	1    9150 4000
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR019
U 1 1 5E34E0EA
P 9150 2300
F 0 "#PWR019" H 9150 2150 50  0001 C CNN
F 1 "+5V" H 9165 2473 50  0000 C CNN
F 2 "" H 9150 2300 50  0001 C CNN
F 3 "" H 9150 2300 50  0001 C CNN
	1    9150 2300
	1    0    0    -1  
$EndComp
Text GLabel 8000 3100 0    50   Output ~ 0
LEDSTRIP
$Comp
L power:+3.3V #PWR?
U 1 1 5E5E77A4
P 8500 800
F 0 "#PWR?" H 8500 650 50  0001 C CNN
F 1 "+3.3V" H 8515 973 50  0000 C CNN
F 2 "" H 8500 800 50  0001 C CNN
F 3 "" H 8500 800 50  0001 C CNN
	1    8500 800 
	1    0    0    -1  
$EndComp
Text GLabel 7850 1300 0    50   Output ~ 0
TEMPERATURE
$Comp
L Device:R R5
U 1 1 5E4AD63D
P 8250 900
F 0 "R5" V 8043 900 50  0000 C CNN
F 1 "4.7k" V 8134 900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8180 900 50  0001 C CNN
F 3 "~" H 8250 900 50  0001 C CNN
	1    8250 900 
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR015
U 1 1 5E4AD649
P 8500 1950
F 0 "#PWR015" H 8500 1700 50  0001 C CNN
F 1 "GND" H 8505 1777 50  0000 C CNN
F 2 "" H 8500 1950 50  0001 C CNN
F 3 "" H 8500 1950 50  0001 C CNN
	1    8500 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 900  8100 900 
Wire Wire Line
	8050 1300 8050 900 
Wire Wire Line
	8400 900  8500 900 
Wire Wire Line
	8500 800  8500 900 
Connection ~ 8500 900 
Wire Wire Line
	8050 1300 7850 1300
Connection ~ 8050 1300
Wire Wire Line
	8500 900  9150 900 
Wire Wire Line
	9150 1900 8500 1900
Connection ~ 8500 1900
Wire Wire Line
	8500 1900 8500 1950
$Comp
L Device:C C4
U 1 1 5E4AD65A
P 9150 1550
F 0 "C4" H 9265 1596 50  0000 L CNN
F 1 "100n" H 9265 1505 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 9188 1400 50  0001 C CNN
F 3 "~" H 9150 1550 50  0001 C CNN
	1    9150 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 1700 9150 1900
$Comp
L TEM-HUM-AM2302_4P-25.0X15.0MM_:TEM-HUM-AM2302(4P-25.0X15.0MM) U4
U 1 1 5E4AD666
P 8800 1350
F 0 "U4" H 8883 1715 50  0000 C CNN
F 1 "DHT22" H 8883 1624 50  0000 C CNN
F 2 "TEM-HUM-AM2302_4P-25.0X15.0MM_:SNR4-2.54-25.0X15.0X7.0MM" H 8800 1350 50  0001 L BNN
F 3 "None" H 8800 1350 50  0001 L BNN
F 4 "AM2302" H 8800 1350 50  0001 L BNN "Field4"
F 5 "AM2302 Humidity, Temperature Sensor Grove Platform Evaluation Expansion Board" H 8800 1350 50  0001 L BNN "Field5"
F 6 "Unavailable" H 8800 1350 50  0001 L BNN "Field6"
F 7 "Housed Sensor Seeed Technology" H 8800 1350 50  0001 L BNN "Field7"
F 8 "Seeed Technology" H 8800 1350 50  0001 L BNN "Field8"
	1    8800 1350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8500 900  8500 1200
Wire Wire Line
	9150 900  9150 1400
Wire Wire Line
	8500 1500 8500 1900
Wire Wire Line
	8050 1300 8500 1300
Wire Wire Line
	5500 5550 5500 5950
Wire Wire Line
	5650 5550 5500 5550
Wire Wire Line
	5600 4800 5600 5700
Wire Wire Line
	5650 5700 5600 5700
$Comp
L Analog_ADC:BH1750_module U2
U 1 1 5E46BF4D
P 6050 5400
F 0 "U2" H 6380 5446 50  0000 L CNN
F 1 "BH1750_module" H 6380 5355 50  0000 L CNN
F 2 "floraable:BH1750_module" H 6850 4950 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ina226.pdf" H 6400 5300 50  0001 C CNN
	1    6050 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 5250 5250 5250
Text GLabel 5250 5250 0    50   Output ~ 0
SDA
Wire Wire Line
	5650 5400 5250 5400
Text GLabel 5250 5400 0    50   Output ~ 0
SCL
$Comp
L power:GND #PWR07
U 1 1 5E36B50A
P 5500 5950
F 0 "#PWR07" H 5500 5700 50  0001 C CNN
F 1 "GND" H 5505 5777 50  0000 C CNN
F 2 "" H 5500 5950 50  0001 C CNN
F 3 "" H 5500 5950 50  0001 C CNN
	1    5500 5950
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR08
U 1 1 5E37152F
P 5600 4800
F 0 "#PWR08" H 5600 4650 50  0001 C CNN
F 1 "+3.3V" H 5615 4973 50  0000 C CNN
F 2 "" H 5600 4800 50  0001 C CNN
F 3 "" H 5600 4800 50  0001 C CNN
	1    5600 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 1450 4300 1850
$Comp
L power:GND #PWR0104
U 1 1 5E4EABA1
P 4300 1850
F 0 "#PWR0104" H 4300 1600 50  0001 C CNN
F 1 "GND" H 4305 1677 50  0000 C CNN
F 2 "" H 4300 1850 50  0001 C CNN
F 3 "" H 4300 1850 50  0001 C CNN
	1    4300 1850
	1    0    0    -1  
$EndComp
Connection ~ 4300 1050
Wire Wire Line
	4300 1050 4300 1150
$Comp
L Device:CP C5
U 1 1 5E4E145E
P 4300 1300
F 0 "C5" H 4418 1346 50  0000 L CNN
F 1 "100u" H 4418 1255 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 4338 1150 50  0001 C CNN
F 3 "~" H 4300 1300 50  0001 C CNN
	1    4300 1300
	1    0    0    -1  
$EndComp
$Comp
L Connector:USB_B J1
U 1 1 5E65D1DF
P 3800 1250
F 0 "J1" H 3857 1717 50  0000 C CNN
F 1 "USB_B" H 3857 1626 50  0000 C CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 3950 1200 50  0001 C CNN
F 3 " ~" H 3950 1200 50  0001 C CNN
	1    3800 1250
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR02
U 1 1 5E68A7CF
P 4300 900
F 0 "#PWR02" H 4300 750 50  0001 C CNN
F 1 "+5V" H 4315 1073 50  0000 C CNN
F 2 "" H 4300 900 50  0001 C CNN
F 3 "" H 4300 900 50  0001 C CNN
	1    4300 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 1050 4300 1050
Wire Wire Line
	4300 1050 4300 900 
$Comp
L power:GND #PWR01
U 1 1 5E68F5AD
P 3800 1850
F 0 "#PWR01" H 3800 1600 50  0001 C CNN
F 1 "GND" H 3805 1677 50  0000 C CNN
F 2 "" H 3800 1850 50  0001 C CNN
F 3 "" H 3800 1850 50  0001 C CNN
	1    3800 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 1650 3800 1750
Wire Wire Line
	3700 1650 3700 1750
Wire Wire Line
	3700 1750 3800 1750
Connection ~ 3800 1750
Wire Wire Line
	3800 1750 3800 1850
$Comp
L Regulator_Linear:MCP1700-3302E_TO92 U1
U 1 1 5E4C43CC
P 5800 1050
F 0 "U1" H 5800 808 50  0000 C CNN
F 1 "MCP1702-3302E/TO" H 5800 899 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 5800 850 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/20001826D.pdf" H 5800 1050 50  0001 C CNN
	1    5800 1050
	1    0    0    1   
$EndComp
Wire Wire Line
	6100 1050 6250 1050
Wire Wire Line
	5500 1050 5250 1050
Wire Wire Line
	4900 1500 5250 1500
Wire Wire Line
	5800 1500 6250 1500
Wire Wire Line
	6250 1050 6250 1150
Connection ~ 6250 1050
Wire Wire Line
	6250 1050 6850 1050
Connection ~ 6250 1500
$Comp
L Device:CP C3
U 1 1 5E3BE449
P 6250 1300
F 0 "C3" H 6368 1346 50  0000 L CNN
F 1 "1u" H 6368 1255 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 6288 1150 50  0001 C CNN
F 3 "~" H 6250 1300 50  0001 C CNN
	1    6250 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 1450 6250 1500
Wire Wire Line
	5250 1050 5250 1150
$Comp
L Device:CP C2
U 1 1 5E3C0DBF
P 5250 1300
F 0 "C2" H 5368 1346 50  0000 L CNN
F 1 "1u" H 5368 1255 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 5288 1150 50  0001 C CNN
F 3 "~" H 5250 1300 50  0001 C CNN
	1    5250 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1450 5250 1500
Connection ~ 5250 1500
Wire Wire Line
	5250 1500 5800 1500
Connection ~ 5250 1050
Wire Wire Line
	5250 1050 4900 1050
Wire Wire Line
	6250 1500 6850 1500
$Comp
L power:GND #PWR06
U 1 1 5E3C481B
P 4900 1500
F 0 "#PWR06" H 4900 1250 50  0001 C CNN
F 1 "GND" H 4905 1327 50  0000 C CNN
F 2 "" H 4900 1500 50  0001 C CNN
F 3 "" H 4900 1500 50  0001 C CNN
	1    4900 1500
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR09
U 1 1 5E3C552A
P 6850 1050
F 0 "#PWR09" H 6850 900 50  0001 C CNN
F 1 "+3.3V" H 6865 1223 50  0000 C CNN
F 2 "" H 6850 1050 50  0001 C CNN
F 3 "" H 6850 1050 50  0001 C CNN
	1    6850 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR05
U 1 1 5E3C63B3
P 4900 1050
F 0 "#PWR05" H 4900 900 50  0001 C CNN
F 1 "+5V" H 4915 1223 50  0000 C CNN
F 2 "" H 4900 1050 50  0001 C CNN
F 3 "" H 4900 1050 50  0001 C CNN
	1    4900 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 1350 5800 1500
$Comp
L power:GND #PWR010
U 1 1 5E3C4D9A
P 6850 1500
F 0 "#PWR010" H 6850 1250 50  0001 C CNN
F 1 "GND" H 6855 1327 50  0000 C CNN
F 2 "" H 6850 1500 50  0001 C CNN
F 3 "" H 6850 1500 50  0001 C CNN
	1    6850 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3300 6800 4250
Wire Wire Line
	6500 3300 6800 3300
Wire Wire Line
	6500 3400 6950 3400
Wire Wire Line
	6950 3600 6500 3600
Wire Wire Line
	6950 3500 6500 3500
$Comp
L power:GND #PWR0103
U 1 1 5E53BDF6
P 6800 4250
F 0 "#PWR0103" H 6800 4000 50  0001 C CNN
F 1 "GND" H 6805 4077 50  0000 C CNN
F 2 "" H 6800 4250 50  0001 C CNN
F 3 "" H 6800 4250 50  0001 C CNN
	1    6800 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4000 6650 4250
Wire Wire Line
	6500 4000 6650 4000
$Comp
L power:GND #PWR0102
U 1 1 5E53699C
P 6650 4250
F 0 "#PWR0102" H 6650 4000 50  0001 C CNN
F 1 "GND" H 6655 4077 50  0000 C CNN
F 2 "" H 6650 4250 50  0001 C CNN
F 3 "" H 6650 4250 50  0001 C CNN
	1    6650 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 4100 5050 3500
Wire Wire Line
	5200 3600 5500 3600
Wire Wire Line
	5200 4250 5200 3600
$Comp
L power:GND #PWR0101
U 1 1 5E524AB8
P 5200 4250
F 0 "#PWR0101" H 5200 4000 50  0001 C CNN
F 1 "GND" H 5205 4077 50  0000 C CNN
F 2 "" H 5200 4250 50  0001 C CNN
F 3 "" H 5200 4250 50  0001 C CNN
	1    5200 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4000 5350 4250
Wire Wire Line
	5500 4000 5350 4000
$Comp
L Device:R R4
U 1 1 5E60CC09
P 7000 2450
F 0 "R4" H 7070 2496 50  0000 L CNN
F 1 "4.7k" H 7070 2405 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 6930 2450 50  0001 C CNN
F 3 "~" H 7000 2450 50  0001 C CNN
	1    7000 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E60AE14
P 6700 2450
F 0 "R3" H 6770 2496 50  0000 L CNN
F 1 "4.7k" H 6770 2405 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 6630 2450 50  0001 C CNN
F 3 "~" H 6700 2450 50  0001 C CNN
	1    6700 2450
	1    0    0    -1  
$EndComp
Text GLabel 6950 3500 2    50   Input ~ 0
LEDSTRIP
Text GLabel 7250 2800 2    50   Input ~ 0
SDA
Text GLabel 7250 2900 2    50   Input ~ 0
SCL
Connection ~ 6700 2900
Wire Wire Line
	6500 2900 6700 2900
Wire Wire Line
	6700 2900 7250 2900
Wire Wire Line
	6700 2600 6700 2900
$Comp
L power:+5V #PWR011
U 1 1 5E366F63
P 5050 3500
F 0 "#PWR011" H 5050 3350 50  0001 C CNN
F 1 "+5V" H 5065 3673 50  0000 C CNN
F 2 "" H 5050 3500 50  0001 C CNN
F 3 "" H 5050 3500 50  0001 C CNN
	1    5050 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4100 5050 4100
$Comp
L power:GND #PWR012
U 1 1 5E367C24
P 5350 4250
F 0 "#PWR012" H 5350 4000 50  0001 C CNN
F 1 "GND" H 5355 4077 50  0000 C CNN
F 2 "" H 5350 4250 50  0001 C CNN
F 3 "" H 5350 4250 50  0001 C CNN
	1    5350 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2800 5350 2800
Text GLabel 6950 3400 2    50   Input ~ 0
TEMPERATURE
Text GLabel 6950 3600 2    50   Input ~ 0
PUMP
Text GLabel 5350 2800 0    50   Input ~ 0
SOIL
Wire Wire Line
	7000 2600 7000 2800
Wire Wire Line
	7000 2800 7250 2800
Wire Wire Line
	6500 2800 7000 2800
Connection ~ 7000 2800
$Comp
L power:+3.3V #PWR013
U 1 1 5E61CB92
P 6850 2100
F 0 "#PWR013" H 6850 1950 50  0001 C CNN
F 1 "+3.3V" H 6865 2273 50  0000 C CNN
F 2 "" H 6850 2100 50  0001 C CNN
F 3 "" H 6850 2100 50  0001 C CNN
	1    6850 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 2300 6700 2200
Wire Wire Line
	6700 2200 6850 2200
Wire Wire Line
	6850 2200 6850 2100
Wire Wire Line
	7000 2300 7000 2200
Wire Wire Line
	7000 2200 6850 2200
Connection ~ 6850 2200
$Comp
L ESP32-DEVKITC-32D:NodeMCU U3
U 1 1 5E363214
P 6000 3400
F 0 "U3" H 6000 4365 50  0000 C CNN
F 1 "NodeMCU" H 6000 4274 50  0000 C CNN
F 2 "floraable:newNodeMCU" H 3000 2800 50  0001 L BNN
F 3 "Espressif Systems" H 3000 2800 50  0001 L BNN
	1    6000 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR03
U 1 1 5E5BE0F4
P 3750 2550
F 0 "#PWR03" H 3750 2400 50  0001 C CNN
F 1 "+3.3V" H 3765 2723 50  0000 C CNN
F 2 "" H 3750 2550 50  0001 C CNN
F 3 "" H 3750 2550 50  0001 C CNN
	1    3750 2550
	1    0    0    -1  
$EndComp
Text GLabel 4650 3800 2    50   Output ~ 0
SOIL
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5E5BE0CC
P 3500 3600
F 0 "J2" H 3580 3592 50  0000 L CNN
F 1 "soil moisture sensor" H 3580 3501 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 3500 3600 50  0001 C CNN
F 3 "~" H 3500 3600 50  0001 C CNN
	1    3500 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	3750 3800 4300 3800
$Comp
L Device:R R1
U 1 1 5E5BE0DE
P 3750 2950
F 0 "R1" H 3820 2996 50  0000 L CNN
F 1 "22k" H 3820 2905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3680 2950 50  0001 C CNN
F 3 "~" H 3750 2950 50  0001 C CNN
	1    3750 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5E5BE0E4
P 3750 4050
F 0 "R2" H 3820 4096 50  0000 L CNN
F 1 "10k" H 3820 4005 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3680 4050 50  0001 C CNN
F 3 "~" H 3750 4050 50  0001 C CNN
	1    3750 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 3500 3750 3500
Wire Wire Line
	3700 3600 3750 3600
Connection ~ 3750 3800
Wire Wire Line
	3750 3800 3750 3900
Wire Wire Line
	3750 3600 3750 3800
Wire Wire Line
	3750 3100 3750 3500
$Comp
L power:GND #PWR04
U 1 1 5E5BE0EA
P 4000 4750
F 0 "#PWR04" H 4000 4500 50  0001 C CNN
F 1 "GND" H 4005 4577 50  0000 C CNN
F 2 "" H 4000 4750 50  0001 C CNN
F 3 "" H 4000 4750 50  0001 C CNN
	1    4000 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 2550 3750 2800
Wire Wire Line
	3750 4200 3750 4600
$Comp
L Device:C C1
U 1 1 5E365274
P 4300 4100
F 0 "C1" H 4415 4146 50  0000 L CNN
F 1 "100n" H 4415 4055 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 4338 3950 50  0001 C CNN
F 3 "~" H 4300 4100 50  0001 C CNN
	1    4300 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 4600 4000 4600
Wire Wire Line
	4300 4600 4300 4250
Wire Wire Line
	4300 3800 4300 3950
Connection ~ 4300 3800
Wire Wire Line
	4300 3800 4650 3800
Wire Wire Line
	4000 4750 4000 4600
Connection ~ 4000 4600
Wire Wire Line
	4000 4600 4300 4600
NoConn ~ 9200 2650
Wire Wire Line
	9150 2750 9150 2900
Wire Wire Line
	9200 2750 9150 2750
Wire Wire Line
	9150 2300 9150 2550
Wire Wire Line
	9200 2550 9150 2550
$Comp
L Connector_Generic:Conn_01x03 J4
U 1 1 5E44DAC9
P 9400 2650
F 0 "J4" H 9480 2692 50  0000 L CNN
F 1 "LED strip" H 9480 2601 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Horizontal" H 9400 2650 50  0001 C CNN
F 3 "~" H 9400 2650 50  0001 C CNN
	1    9400 2650
	1    0    0    1   
$EndComp
Connection ~ 8200 3100
Wire Wire Line
	8200 3100 8000 3100
Wire Wire Line
	8200 3600 8200 3700
Connection ~ 8200 3600
Wire Wire Line
	8200 3500 8200 3600
$Comp
L power:GND #PWR017
U 1 1 5E336B66
P 8200 3700
F 0 "#PWR017" H 8200 3450 50  0001 C CNN
F 1 "GND" H 8205 3527 50  0000 C CNN
F 2 "" H 8200 3700 50  0001 C CNN
F 3 "" H 8200 3700 50  0001 C CNN
	1    8200 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5E3353D3
P 8200 3350
F 0 "R8" H 8270 3396 50  0000 L CNN
F 1 "15k" H 8270 3305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8130 3350 50  0001 C CNN
F 3 "~" H 8200 3350 50  0001 C CNN
	1    8200 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 3100 8200 3200
Wire Wire Line
	8300 3100 8200 3100
$Comp
L Device:R R9
U 1 1 5E333EAA
P 8450 3100
F 0 "R9" V 8243 3100 50  0000 C CNN
F 1 "150R" V 8334 3100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 8380 3100 50  0001 C CNN
F 3 "~" H 8450 3100 50  0001 C CNN
	1    8450 3100
	0    1    1    0   
$EndComp
Wire Wire Line
	8850 3100 8600 3100
$Comp
L Device:Q_NMOS_GDS Q2
U 1 1 5E3EDD8D
P 9050 3100
F 0 "Q2" H 9254 3146 50  0000 L CNN
F 1 "IRL1404Z" H 9254 3055 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 9250 3200 50  0001 C CNN
F 3 "~" H 9050 3100 50  0001 C CNN
	1    9050 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 3600 9150 3600
Wire Wire Line
	9150 3600 9150 3300
Connection ~ 5800 1500
$EndSCHEMATC
