!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'MAM 9/9/2024 21:55:53'!
initialize

	state := VehicleState new.! !


!Vehicle methodsFor: 'move' stamp: 'MAM 9/9/2024 22:12:43'!
accelerate
	state accelerate:self.
	
	"state = #Off ifTrue:[self error: self canNotAccelerateErrorMessage]."

	"type = #Helicopter
		ifTrue:[speed := speed + (10 * kilometer / hour).
			altitude := altitude + (5 * meter)].
		
	type = #Motorcycle
		ifTrue:[speed := speed + (20 * kilometer / hour)]."! !


!Vehicle methodsFor: 'on/off' stamp: 'MAM 9/9/2024 22:08:39'!
turnOff
state := state turnOff.! !

!Vehicle methodsFor: 'on/off' stamp: 'MAM 9/9/2024 22:08:32'!
turnOn
state := state turnOn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/9/2024 19:19:30'!
helicopter

	^Helicopter new! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/9/2024 19:19:49'!
motorcycle

	^Motorcycle new! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'move' stamp: 'MAM 9/9/2024 22:03:11'!
accelerateARunningVehicle
	state speed:(state speed+ (10 * kilometer/hour )).
	state altitude:(state altitude+ (10 * meter )).
	"speed := speed + (10 * kilometer ).
	altitude := altitude + (5 * meter)."! !


!Helicopter methodsFor: 'error messages' stamp: 'MAM 9/9/2024 22:07:16'!
canNotAccelerateErrorMessage
^self error:'Can not fly when turned off'! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'move' stamp: 'MAM 9/9/2024 22:02:57'!
accelerateARunningVehicle
state speed:(state speed + (20 * kilometer / hour)).
"speed := speed + (20 * kilometer / hour)."! !


!Motorcycle methodsFor: 'error messages' stamp: 'MAM 9/9/2024 22:07:07'!
canNotAccelerateErrorMessage
^self error: 'Can not run when turned off'! !


!classDefinition: #VehicleState category: #'3.Replace-if-Type+State'!
Object subclass: #VehicleState
	instanceVariableNames: 'speed altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!VehicleState methodsFor: 'initialization' stamp: 'MAM 9/9/2024 21:35:24'!
initialize
^Off new.! !


!VehicleState methodsFor: 'information' stamp: 'MAM 9/9/2024 21:39:49'!
altitude
^altitude! !

!VehicleState methodsFor: 'information' stamp: 'MAM 9/9/2024 21:47:52'!
altitude: aHeightToSet
altitude:=aHeightToSet ! !

!VehicleState methodsFor: 'information' stamp: 'MAM 9/9/2024 21:39:38'!
speed
^speed! !

!VehicleState methodsFor: 'information' stamp: 'MAM 9/9/2024 21:47:07'!
speed: aVelocityToSet
speed:= aVelocityToSet.! !


!VehicleState methodsFor: 'on/off' stamp: 'MAM 9/9/2024 21:55:03'!
turnOff
^Off new.! !

!VehicleState methodsFor: 'on/off' stamp: 'MAM 9/9/2024 21:54:55'!
turnOn
^On new.! !


!classDefinition: #Off category: #'3.Replace-if-Type+State'!
VehicleState subclass: #Off
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Off methodsFor: 'initialization' stamp: 'MAM 9/9/2024 21:39:14'!
initialize
speed:=0*kilometer/hour.
altitude := 0 * meter.! !


!Off methodsFor: 'move' stamp: 'MAM 9/9/2024 21:58:41'!
accelerate: aVehicle
^aVehicle canNotAccelerateErrorMessage.! !


!classDefinition: #On category: #'3.Replace-if-Type+State'!
VehicleState subclass: #On
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!On methodsFor: 'initialization' stamp: 'MAM 9/9/2024 21:39:26'!
initialize
speed:=0*kilometer/hour.
altitude := 0 * meter.! !


!On methodsFor: 'move' stamp: 'MAM 9/9/2024 22:03:24'!
accelerate: aVehicle
aVehicle accelerateARunningVehicle.! !
