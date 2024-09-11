!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:28:51'!
ActiveCustomers: firstNumber SuspendedCustomers: secondNumber Customers: thirdNumber On: customerBook

	self assert: firstNumber equals: customerBook numberOfActiveCustomers.
	self assert: secondNumber equals: customerBook numberOfSuspendedCustomers.
	self assert: thirdNumber equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:34:00'!
PaulMcCartneyNotOn: customerBook

	^ self deny: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:34:26'!
PaulMcCartneyOn: customerBook

	^ self assert: (customerBook includesCustomerNamed: 'Paul McCartney')! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:24:47'!
addAndSuspend:name On: customerBook

	customerBook addCustomerNamed: name.
	customerBook suspendCustomerNamed: name.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 20:44:04'!
onlyJohnLennonOn: customerBook

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 19:35:24'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self toDo:[customerBook addCustomerNamed: 'John Lennon']takesLessThan:(50 * millisecond).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 19:39:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.	
	customerBook addCustomerNamed: 'Paul McCartney'.
	  
	self toDo:[customerBook removeCustomerNamed: 'Paul McCartney']takesLessThan:(100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:14:27'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self tryAddingCustomerWithEmptyName: customerBook! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:15:30'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self tryRemovingPaulMcCartney: customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:34:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' On: customerBook.
	self ActiveCustomers: 0 SuspendedCustomers: 1 Customers: 1 On: customerBook .
	
	self PaulMcCartneyOn: customerBook.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:34:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' On: customerBook.
	customerBook removeCustomerNamed: 'Paul McCartney'.

	self ActiveCustomers: 0 SuspendedCustomers: 0 Customers: 0 On: customerBook.
	
	self PaulMcCartneyNotOn: customerBook.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:16:44'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self trySuspend:'George Harrison'  withOnlyJohnLennonOn: customerBook .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:26:39'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	self addAndSuspend: 'John Lennon' On: customerBook .
	
	self trySuspend:'John Lennon'  withOnlyJohnLennonOn: customerBook.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 19:36:27'!
toDo: aBlock takesLessThan: time

	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:14:27'!
tryAddingCustomerWithEmptyName: customerBook

	^ [ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:15:30'!
tryRemovingPaulMcCartney: customerBook

	^ [ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self onlyJohnLennonOn: customerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MAM 9/5/2024 22:16:14'!
trySuspend: aName withOnlyJohnLennonOn: customerBook

	[ customerBook suspendCustomerNamed: aName.
		self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self onlyJohnLennonOn: customerBook ]! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 22:48:56'!
addCustomerNamed: aName

	self discardIfEmpty: aName.
	self discardIfAlreadyExists: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 22:48:56'!
discardIfAlreadyExists: aName

	^ ((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 22:48:23'!
discardIfEmpty: aName

	^ aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 23:13:49'!
removeCustomerNamed: aName 
	|foundInCustomerBook|
	
	foundInCustomerBook:= self removeIfFound: aName.

	foundInCustomerBook ifTrue:[^aName] ifFalse:[^ NotFound signal].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 23:14:04'!
removeIfFound: aName

	^ (active includes: aName) ifTrue: [active remove:aName.true] 
							   ifFalse:[(suspended includes: aName) ifTrue: [suspended remove:aName.true]ifFalse:false]! !

!CustomerBook methodsFor: 'customer management' stamp: 'MAM 9/5/2024 22:42:08'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
