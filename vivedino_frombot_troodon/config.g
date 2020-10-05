; Configuration file for Duet WiFi (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Sun Aug 30 2020 21:21:23 GMT+0200 (Mitteleuropäische Sommerzeit)

; General preferences
M111 S0                                            	; debugging off
G21                                                	; work in millimetres
G90                                                	; send absolute coordinates...
M83                                                	; ...but relative extruder moves
M550 P"Troodon"                                    	; set printer name
M669 K1                                            	; select CoreXY mode
M555 P2                                            	; set firmware compatibility to look like Marlin

; Network
M552 S1                                            	; enable network
M586 P0 S1                                         	; enable HTTP
M586 P1 S0                                         	; disable FTP
M586 P2 S0                                         	; disable Telnet

; Drives
M569 P0 S1 D2                                      	; X
M569 P1 S1 D2                                      	; Y
M569 P3 S1 D2                                      	; E0
M584 X0 Y1 E3 Z6:5:8:7                             	; set drive mapping // four Z motors, at 5, 6, 7, and 8
M671 X-100:-100:420:420 Y380:-115:-115:380 S20     	; Z belts at 4 corners

; Duex5
M569 P5 S1 D2     				   				   	; Z5
M569 P6 S0 D2									   	; Z6
M569 P7 S1 D2									   	; Z7
M569 P8 S0 D2					   				   	; Z8
M569 P2 R-1										   	; -1 = driver is always disabled and is not monitored
M569 P4 R-1										   	; -1 = driver is always disabled and is not monitored
M569 P9 R-1										   	; -1 = driver is always disabled and is not monitored

; Drive map
;    _______
;   | 6 | 7 |
;   | ----- |
;   | 5 | 8 |
;    -------
;     front

M350 X16 Y16 Z16 E16 I1                            	; configure microstepping with interpolation
M92 X80.00 Y80.00 Z400.00 E710.00                  	; set steps per mm
M566 X2000.00 Y2000.00 Z600.00 E300.00             	; set maximum instantaneous speed changes (mm/min)
M203 X20000.00 Y20000.00 Z1500.00 E3600.00         	; set maximum speeds (mm/min)
M201 X1500.00 Y1500.00 Z500.00 E600.00             	; set accelerations (mm/s^2)
M906 X1200 Y1200 Z1200 E430 I60                    	; set motor currents (mA) and motor idle factor in per cent
M84 S60                                            	; Set idle timeout

; Axis Limits
M208 X5 Y0 Z0 S1                                   	; set axis minima to end of safe travel
M208 X410 Y408 Z510 S0                             	; set axis maxima to match endstop location

; Endstops
M574 X2 S1 P"xstop"                                	; configure active-high endstop for high end on X via pin xstop
M574 Y2 S1 P"ystop"                                	; configure active-high endstop for high end on Y via pin ystop
;M574 Z1 S0 P"zstop"                               	; configure Z-probe endstop for low end on Z

; Z-Probe
M950 S7 C"!exp.heater7"                            	; create servo pin 7 for BLTouch
M558 P9 C"^zprobe.in" H3.5 F300 T12000              ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X0 Y21 Z1.41                              	; set Z probe trigger value, offset and trigger height
M557 X10:410 Y21:400 S49                           	; define mesh grid

; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B4138     			; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0                              			; create bed heater output on bedheat and map it to sensor 0
M307 H0 A90.0 C700.0 D10.0 S1.00 V0.0 B1           			; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            			; map heated bed to heater 0
M143 H0 S130                                       			; set temperature limit for heater 0 to 130C
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.06e-8      ; configure sensor 1 as thermistor on pin e0temp old settings:B4138
M950 H1 C"e0heat" T1                               			; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 A517.3 C213.3 D11.1 S1.00 V24 B0           			; disable bang-bang mode for heater and set PWM limit
M143 H1 S300                                       			; set temperature limit for heater 1 to 300C
M308 S2 P"e1_temp" Y"thermistor" T10000 B3950 A"Chamber"	; configure sensor 2 as thermistor on pin e1temp
M308 S10 Y"mcu-temp" A"mcu-temp"		   					; create virtual temp sensor 10
M308 S11 Y"drivers" A"drivers"			   					; create virtual temp sensor 11
M308 S12 Y"drivers-duex" A"drivers-duex"	   				; create virtual temp sensor 12

; Fans
M950 F0 C"fan0" Q250                               			; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"PART FAN"                         			; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan1" Q250                               			; create fan 1 on pin fan1 and set its frequency
M106 P1 H1 T45 S1 C"EXTRUDER FAN"                  			; set fan 1 value. Thermostatic control is turned on
M950 F2 C"fan2" Q250				   						; create fan 2 on pin fan2 and set its frequency
M106 P2 H10:11:12 T45:65 L0.4 X1.0 C"COMPARTMENT FAN"     	; set fan 2 value. starts to turn on when the MCU temperature (virtual heater 10) reaches 45C and reaches full speed when the MCU temperature reaches 65C or if any TMC2660 drivers (virtual heaters 11 and 12) report that they are over-temperature
M950 F8 C"duex.fan8" Q250			   						; create pin 8 on pin fan8 and set its frequency
M106 P8 H10:11:12 T40:65 L1.0 C"STEPPER FAN"	   			; set fan 8 value. Thermostatic control is turned on
M950 F9 C"duex.fan7" Q250			   						; create pin 9 on pin fan7 and set its frequency
M106 P9 S0 H-1 C"AIR FILTRATION"		   					; set fan 9 value. Thermostatic control is turned off

; Free up Fan pin
M950 F3 C"nil" 					   					; disable fan 3 and free up the associated pin
M950 F4 C"nil" 					   					; disable fan 4 and free up the associated pin
M950 F5 C"nil" 					   					; disable fan 5 and free up the associated pin
M950 F6 C"nil" 					   					; disable fan 6 and free up the associated pin

; Tools
M563 P0 S"E3D_Extruder_0" D0 H1 F0                 	; define tool 0
G10 P0 X0 Y0 Z0                                    	; set tool 0 axis offsets
G10 P0 R0 S0                                       	; set initial tool 0 active and standby temperatures to 0C

; Custom settings

; Filament sensing
M591 D0 P1 C"e0_stop" S1

; Firmware retraction
M207 P0 S0.3 R0 F3600 T3600 Z0	                   	; [ Snnn positive length to retract, in mm ]   // std M207 S2.5 R0 F6500 T4500 Z0
						   							; [ Rnnn positive or negative additional length to un-retract, in mm ]
                                                   	; [ Fnnn retraction feedrate, in mm/min ]
						   							; [ Tnnn feedrate for un-retraction if different from retraction, mm/min ]
						   							; [ Znnn additional zlift/hop ]

; Linear advance
M572 D0 S0.13					   					; Linear Advance
;M592 D0 A0.01 B0.0005			   					; nonlinear extrusion

; RGB leds - White
;M950 P3 C"duex.fan3" Q250		   					; create pin 3 on pin fan3 and set its frequency
;M106 P3 S255 					   					; not used for the moment
M950 P4 C"duex.fan4"			   					; create pin 24 on pin fan4 and set its frequency
M42 P4 S255 					   					; G-
M950 P5 C"duex.fan5"			   					; create pin 25 on pin fan5 and set its frequency
M42 P5 S255 					   					; R-
M950 P6 C"duex.fan6"			   					; create pin 26 on pin fan6 and set its frequency
M42 P6 S255 					   					; B-


; Miscellaneous
M575 P1 S1 B57600                                  	; enable support for PanelDue
M911 S23 R24 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000" 	; set voltage thresholds and actions to run on power loss
;M581						   						; Set Z-Probe Offset (Marlin Compatibility)

M501
M500