!classDefinition: #Automobil category: #'2.Replace-if-State'!
Object subclass: #Automobil
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobil methodsFor: 'initialization' stamp: 'MAM 9/9/2024 17:48:56'!
initialize

	state := AutomobilState new initialize.! !


!Automobil methodsFor: 'move' stamp: 'MAM 9/9/2024 18:05:19'!
accelerate

	state:= state accelerate.! !

!Automobil methodsFor: 'move' stamp: 'MAM 9/9/2024 18:04:57'!
turnOn

	state := state turnOn.! !


!classDefinition: #AutomobilState category: #'2.Replace-if-State'!
Object subclass: #AutomobilState
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutomobilState methodsFor: 'information' stamp: 'MAM 9/9/2024 17:45:29'!
speed
^speed.! !

!AutomobilState methodsFor: 'information' stamp: 'MAM 9/9/2024 18:02:42'!
state
^self.! !


!AutomobilState methodsFor: 'initialization' stamp: 'MAM 9/9/2024 17:53:27'!
initialize
^Off new! !


!AutomobilState methodsFor: 'changing state' stamp: 'MAM 9/9/2024 17:50:16'!
turnOn
^On new.! !


!classDefinition: #Off category: #'2.Replace-if-State'!
AutomobilState subclass: #Off
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Off methodsFor: 'move' stamp: 'MAM 9/9/2024 17:44:29'!
accelerate
^self error: 'Can not accelerate when turned off'.! !


!Off methodsFor: 'initialization' stamp: 'MAM 9/9/2024 18:01:55'!
initialize
speed := 0* kilometer / hour.! !


!classDefinition: #On category: #'2.Replace-if-State'!
AutomobilState subclass: #On
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!On methodsFor: 'move' stamp: 'MAM 9/9/2024 17:45:54'!
accelerate
speed := speed + (10 * kilometer / hour).! !


!On methodsFor: 'initialization' stamp: 'MAM 9/9/2024 17:53:42'!
initialize
speed := 0* kilometer / hour.! !
