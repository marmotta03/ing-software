!classDefinition: #MarsRoversTest category: #'MarsRovers Ejercicio'!
TestCase subclass: #MarsRoversTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:40:42'!
test01MarsRovesEmptyCommands

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:''.

self assert: (marsRovers at:position heading: MarsRoversHeadingNorth)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:46:56'!
test02MarsRovesForwardNorth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:'f'.

self assert: (marsRovers at:position+(0@1) heading: MarsRoversHeadingNorth)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:47:04'!
test03MarsRovesTwoForwardNorth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:'ff'.

self assert: (marsRovers at:position+(0@2) heading: MarsRoversHeadingNorth)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:47:12'!
test04MarsRovesTwoBackwardNorth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:'bb'.

self assert: (marsRovers at:position-(0@2) heading: MarsRoversHeadingNorth)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:47:24'!
test05MarsRovesTurnsRightNorth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:'r'.

self assert: (marsRovers at:position heading: MarsRoversHeadingEast)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:47:37'!
test06MarsRovesTurnsLeftNorth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingNorth.

marsRovers move:'l'.

self assert: (marsRovers at:position heading: MarsRoversHeadingWest)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:47:51'!
test07MarsRovesCanProcessAllCommandsHeadingWest

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingWest.

marsRovers move:'ffbrll'.

self assert: (marsRovers at:position-(1@0) heading: MarsRoversHeadingSouth)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:48:01'!
test08MarsRovesCanProcessAllCommandsHeadingSouth

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingSouth.

marsRovers move:'ffbrll'.

self assert: (marsRovers at:position-(0@1) heading: MarsRoversHeadingEast)! !

!MarsRoversTest methodsFor: 'as yet unclassified' stamp: 'MAM 10/16/2024 17:48:13'!
test09MarsRovesCanProcessAllCommandsHeadingEast

|marsRovers position |

position:=0@0.

marsRovers:=MarsRovers new initializeInPosition: position heading: MarsRoversHeadingEast.

marsRovers move:'ffbrll'.

self assert: (marsRovers at:position+(1@0) heading: MarsRoversHeadingNorth)! !


!classDefinition: #MarsRovers category: #'MarsRovers Ejercicio'!
Object subclass: #MarsRovers
	instanceVariableNames: 'coordenates heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRovers methodsFor: 'initialization' stamp: 'MAM 10/16/2024 17:33:31'!
initializeInPosition: initialPosition heading: initialHeading 
	coordenates := initialPosition.
	heading := initialHeading heading:self.! !


!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 16:59:41'!
move: aStringOfCommands 
	aStringOfCommands do:[:aCommand | self processCommand: aCommand]! !

!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 17:38:56'!
processComandHeadingEast: aCommand

	(aCommand asString)= 'f' ifTrue:[coordenates:= coordenates+(1@0)].
	(aCommand asString)= 'b' ifTrue:[coordenates:= coordenates-(1@0)].
	(aCommand asString)= 'r' ifTrue:[heading:=MarsRoversHeadingSouth heading: self].
	(aCommand asString)= 'l' ifTrue:[heading:=MarsRoversHeadingNorth heading:self].! !

!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 17:39:25'!
processComandHeadingNorth: aCommand

	(aCommand asString)= 'f' ifTrue:[coordenates:= coordenates+(0@1)].
	(aCommand asString)= 'b' ifTrue:[coordenates:= coordenates-(0@1)].
	(aCommand asString)= 'r' ifTrue:[heading:=MarsRoversHeadingEast heading:self].
	(aCommand asString)= 'l' ifTrue:[heading:=MarsRoversHeadingWest heading:self]! !

!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 17:39:45'!
processComandHeadingSouth: aCommand

	(aCommand asString)= 'f' ifTrue:[coordenates:= coordenates-(0@1)].
	(aCommand asString)= 'b' ifTrue:[coordenates:= coordenates+(0@1)].
	(aCommand asString)= 'r' ifTrue:[heading:=MarsRoversHeadingWest heading:self].
	(aCommand asString)= 'l' ifTrue:[heading:=MarsRoversHeadingEast heading:self]! !

!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 17:40:15'!
processComandHeadingWest: aCommand

	(aCommand asString)= 'f' ifTrue:[coordenates:= coordenates-(1@0)].
	(aCommand asString)= 'b' ifTrue:[coordenates:= coordenates+(1@0)].
	(aCommand asString)= 'r' ifTrue:[heading:=MarsRoversHeadingNorth heading:self].
	(aCommand asString)= 'l' ifTrue:[heading:=MarsRoversHeadingSouth heading:self].! !

!MarsRovers methodsFor: 'move' stamp: 'MAM 10/16/2024 17:49:06'!
processCommand: aCommand
	heading processCommand: aCommand .! !


!MarsRovers methodsFor: 'testing' stamp: 'MAM 10/16/2024 17:35:55'!
at: aPosition heading: aHeading 
	^coordenates = aPosition and:(heading isKindOf:aHeading )! !


!classDefinition: #MarsRoversHeading category: #'MarsRovers Ejercicio'!
Object subclass: #MarsRoversHeading
	instanceVariableNames: 'marsRovers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversHeading methodsFor: 'initialization' stamp: 'MAM 10/16/2024 17:34:44'!
initializeHeading: aMarsRovers
	marsRovers:=aMarsRovers .! !


!MarsRoversHeading methodsFor: 'processing' stamp: 'MAM 10/16/2024 17:36:59'!
processCommand: aCommand

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversHeading class' category: #'MarsRovers Ejercicio'!
MarsRoversHeading class
	instanceVariableNames: ''!

!MarsRoversHeading class methodsFor: 'instance creation' stamp: 'MAM 10/16/2024 17:46:12'!
heading: aMarsRovers
	^self new initializeHeading: aMarsRovers .! !


!classDefinition: #MarsRoversHeadingEast category: #'MarsRovers Ejercicio'!
MarsRoversHeading subclass: #MarsRoversHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversHeadingEast methodsFor: 'processing' stamp: 'MAM 10/16/2024 17:37:17'!
processCommand: aCommand
	marsRovers processComandHeadingEast: aCommand.! !


!classDefinition: #MarsRoversHeadingNorth category: #'MarsRovers Ejercicio'!
MarsRoversHeading subclass: #MarsRoversHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversHeadingNorth methodsFor: 'processing' stamp: 'MAM 10/16/2024 17:37:33'!
processCommand: aCommand
	marsRovers processComandHeadingNorth: aCommand .! !


!classDefinition: #MarsRoversHeadingSouth category: #'MarsRovers Ejercicio'!
MarsRoversHeading subclass: #MarsRoversHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversHeadingSouth methodsFor: 'processing' stamp: 'MAM 10/16/2024 17:37:45'!
processCommand: aCommand
	marsRovers processComandHeadingSouth: aCommand .! !


!classDefinition: #MarsRoversHeadingWest category: #'MarsRovers Ejercicio'!
MarsRoversHeading subclass: #MarsRoversHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers Ejercicio'!

!MarsRoversHeadingWest methodsFor: 'processing' stamp: 'MAM 10/16/2024 17:37:55'!
processCommand: aCommand
	marsRovers processComandHeadingWest: aCommand .! !
