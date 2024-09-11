!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:25:03'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:27:17'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:20'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := Vehicle electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:16'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := Vehicle gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:11'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := Vehicle helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:47:14'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:05'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:53:50'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:55:32'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!classDefinition: #Engine category: #'4.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!


!classDefinition: #ElectricEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #ElectricEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!ElectricEngine methodsFor: 'accelerate' stamp: 'MAM 9/11/2024 19:33:57'!
accelerationWithInitialSpeed: initialSpeed
^(initialSpeed + (5 * kilometer / hour)) * 2 ! !


!classDefinition: #GasolineEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #GasolineEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!GasolineEngine methodsFor: 'accelerate' stamp: 'MAM 9/11/2024 19:34:46'!
accelerationWithInitialSpeed: initialSpeed
^10 * kilometer / hour.! !


!classDefinition: #JetFueledEngine category: #'4.Replace-if-Strategy'!
Engine subclass: #JetFueledEngine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!JetFueledEngine methodsFor: 'accelerate' stamp: 'MAM 9/11/2024 19:35:49'!
accelerationWithInitialSpeed: initialSpeed
^((initialSpeed amount + 1) ^ 2) * kilometer / hour.! !


!classDefinition: #PowerStatus category: #'4.Replace-if-Strategy'!
Object subclass: #PowerStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!PowerStatus methodsFor: 'move' stamp: 'MAM 9/11/2024 19:44:45'!
accelerate: aVehicle
^self subclassResponsibility .! !


!classDefinition: #Off category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #Off
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Off methodsFor: 'move' stamp: 'MAM 9/11/2024 19:24:14'!
accelerate: aVehicle
^aVehicle canNotAccelerateErrorMessage ! !


!classDefinition: #On category: #'4.Replace-if-Strategy'!
PowerStatus subclass: #On
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!On methodsFor: 'move' stamp: 'MAM 9/11/2024 19:25:00'!
accelerate: aVehicle
^aVehicle accelerateWhenOn.! !


!classDefinition: #SpeedLimiter category: #'4.Replace-if-Strategy'!
Object subclass: #SpeedLimiter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!


!classDefinition: #City category: #'4.Replace-if-Strategy'!
SpeedLimiter subclass: #City
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!City methodsFor: 'limiter' stamp: 'MAM 9/11/2024 20:03:36'!
limit: aSpeedToLimit
^aSpeedToLimit min:(70 * kilometer / hour).! !


!classDefinition: #OpenRoad category: #'4.Replace-if-Strategy'!
SpeedLimiter subclass: #OpenRoad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!OpenRoad methodsFor: 'limiter' stamp: 'MAM 9/11/2024 20:05:24'!
limit: aSpeedToLimit
^aSpeedToLimit min:(130 * kilometer / hour )! !


!classDefinition: #Skies category: #'4.Replace-if-Strategy'!
SpeedLimiter subclass: #Skies
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Skies methodsFor: 'limiter' stamp: 'MAM 9/11/2024 20:05:42'!
limit: aSpeedToLimit
^aSpeedToLimit min:(500 * kilometer / hour )! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy'!
Object subclass: #Vehicle
	instanceVariableNames: 'state speed engineType where'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Vehicle methodsFor: 'initialization' stamp: 'MAM 9/11/2024 20:00:26'!
initializeWithengineType: anEngineType andSurroundings: surroundings

	self subclassResponsibility! !


!Vehicle methodsFor: 'move' stamp: 'MAM 9/11/2024 19:41:57'!
accelerate
^self subclassResponsibility.! !

!Vehicle methodsFor: 'move' stamp: 'MAM 9/11/2024 19:57:34'!
speedAt: aSpeed

	self subclassResponsibility! !


!Vehicle methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:08'!
turnOff

	self subclassResponsibility! !

!Vehicle methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:21'!
turnOn

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 20:09:00'!
electricMotorcycle

	^ Motorcycle new initializeWithengineType: ElectricEngine andSurroundings: City.

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 20:08:54'!
gasolineMotorcycle
	^Motorcycle new initializeWithengineType: GasolineEngine andSurroundings: OpenRoad.! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/11/2024 20:09:26'!
helicopter
	^Helicopter  new initializeWithengineType: JetFueledEngine andSurroundings: Skies .! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Helicopter methodsFor: 'error messages' stamp: 'MAM 9/11/2024 19:18:11'!
canNotAccelerateErrorMessage
	^self error:'Can not fly when turned off'.! !


!Helicopter methodsFor: 'move' stamp: 'MAM 9/11/2024 19:42:33'!
accelerate
^state accelerate:self.! !

!Helicopter methodsFor: 'move' stamp: 'MAM 9/11/2024 19:26:47'!
accelerateWhenOff
^self canNotAccelerateErrorMessage.! !

!Helicopter methodsFor: 'move' stamp: 'MAM 9/11/2024 20:19:41'!
accelerateWhenOn

	| acceleration |
	acceleration:= engineType accelerationWithInitialSpeed:speed.
	altitude := altitude + (5 * meter).
	speed:= where limit:(speed+ acceleration).! !

!Helicopter methodsFor: 'move' stamp: 'MAM 9/11/2024 19:57:50'!
altitudeAt: anAltitude

	^ altitude = anAltitude! !

!Helicopter methodsFor: 'move' stamp: 'MAM 9/11/2024 19:57:34'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Helicopter methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:08'!
turnOff

	state := Off new.
	speed := 0 * kilometer / hour! !

!Helicopter methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:21'!
turnOn

	state := On new.! !


!Helicopter methodsFor: 'initialization' stamp: 'MAM 9/11/2024 20:00:26'!
initializeWithengineType: anEngineType andSurroundings: surroundings

	state := Off new.
	engineType := anEngineType new.
	where := surroundings new.
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Motorcycle methodsFor: 'error messages' stamp: 'MAM 9/11/2024 19:19:41'!
canNotAccelerateErrorMessage
^self error:'Can not run when turned off'.! !


!Motorcycle methodsFor: 'move' stamp: 'MAM 9/11/2024 19:43:12'!
accelerate
^state accelerate: self.! !

!Motorcycle methodsFor: 'move' stamp: 'MAM 9/11/2024 19:26:26'!
accelerateWhenOff
^self canNotAccelerateErrorMessage.! !

!Motorcycle methodsFor: 'move' stamp: 'MAM 9/11/2024 20:19:24'!
accelerateWhenOn

	| acceleration |
	acceleration:= engineType accelerationWithInitialSpeed: speed.
	speed := where limit:(speed + acceleration).! !

!Motorcycle methodsFor: 'move' stamp: 'MAM 9/11/2024 19:57:34'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Motorcycle methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:08'!
turnOff

	state := Off new.
	speed := 0 * kilometer / hour! !

!Motorcycle methodsFor: 'on/off' stamp: 'MAM 9/11/2024 19:57:20'!
turnOn

	state := On new.! !


!Motorcycle methodsFor: 'initialization' stamp: 'MAM 9/11/2024 20:01:13'!
initializeWithengineType: anEngineType andSurroundings: surroundings

	state := Off new.
	engineType := anEngineType new.
	where := surroundings new.
	speed := 0 * kilometer / hour.! !
