!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'MAM 9/9/2024 17:19:43'!
initialize

	speed := 0 * kilometer / hour.
	altitude := 0 * meter.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'1.Replace-if-Type'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/9/2024 17:20:02'!
helicopter
	^Helicopter new initialize.! !

!Vehicle class methodsFor: 'instance creation' stamp: 'MAM 9/9/2024 17:20:55'!
motorcycle
	^Motorcycle new initialize.! !


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'move' stamp: 'MAM 9/9/2024 13:15:55'!
accelerate
	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter)! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'move' stamp: 'MAM 9/9/2024 13:17:45'!
accelerate
	speed := speed + (20 * kilometer / hour) ! !
