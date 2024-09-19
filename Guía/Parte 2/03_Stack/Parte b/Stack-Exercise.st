!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:35:30'!
test01EmptyStackWithCorrectPrefixReturnsEmptyCollection
|stack finder|
	stack := OOStack new.

	finder:= SentenceFinderByPrefix finderOf: 'fir' On: stack.
	
	self assert: finder findByPrefix class = OrderedCollection.
	self assert: finder findByPrefix size =0.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:45:11'!
test02NonOOStackWithCorrectPrefixCannotBeCreated
|stack firstPushedObject secondPushedObject|
	stack := OrderedCollection new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'fircondSomething'.
	
	stack addFirst: firstPushedObject.
	stack addFirst: secondPushedObject.
	self
		should: [ SentenceFinderByPrefix finderOf:'fir'On:stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'El stack debe ser de la clase OOStack' ].
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:47:02'!
test03OOStackWithEmptyPrefixCannotBeCreated
|stack firstPushedObject secondPushedObject |
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'fircondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.

	self
		should: [ SentenceFinderByPrefix finderOf:''On:stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'El prefijo no puede ser vacío' ].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:47:45'!
test04OOStackWithPrefixWithSpacesCannotBeCreated
|stack firstPushedObject secondPushedObject |
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'fircondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.

	self
		should: [ SentenceFinderByPrefix finderOf:'Hol s das'On:stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'El prefijo no puede contener espacios vacíos' ].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:59:36'!
test05OOStackWithoutWordsMatchingWithCorrectPrefixReturnsEmptyCollection
|stack firstPushedObject secondPushedObject finder wordsSelected|
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'fircondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	finder:= SentenceFinderByPrefix finderOf: 'hol' On: stack.
	wordsSelected:=finder findByPrefix.
	self assert: wordsSelected class = OrderedCollection.
	self assert: wordsSelected size = 0.
	self assert: stack size = 2.
	self assert: stack pop = secondPushedObject .
	self assert: stack pop = firstPushedObject .
	self assert: stack isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 21:00:36'!
test06OOStackWithOneWordMatchingWithCorrectPrefixReturnsColecctionWithTheElement
|stack firstPushedObject secondPushedObject thirdPushedObject finder wordsSelected|
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	thirdPushedObject:= 'thirdSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	stack push: thirdPushedObject .
	
	finder:= SentenceFinderByPrefix finderOf: 'sec' On: stack.
	wordsSelected:=finder findByPrefix.
	self assert: wordsSelected class = OrderedCollection.
	self assert: wordsSelected size = 1.
	self assert: wordsSelected includes: secondPushedObject .
	self assert: stack size = 3.
	self assert: stack pop = thirdPushedObject .
	self assert: stack pop = secondPushedObject .
	self assert: stack pop = firstPushedObject .
	self assert: stack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'MAM 9/19/2024 19:11:26'!
test07OOStackWithSeveralWordsMatchingWithCorrectPrefixReturnsCollectionWithTheElements
|stack firstPushedObject secondPushedObject thirdPushedObject finder wordsSelected|
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	thirdPushedObject:= 'firdSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	stack push: thirdPushedObject .
	
	finder:= SentenceFinderByPrefix finderOf: 'fir' On: stack.
	wordsSelected:=finder findByPrefix.
	self assert: wordsSelected class = OrderedCollection.
	self assert: wordsSelected size = 2.
	self assert: wordsSelected includes: firstPushedObject .
	self assert: wordsSelected includes: thirdPushedObject .
	self assert: stack size = 3.
	self assert: stack pop = thirdPushedObject .
	self assert: stack pop = secondPushedObject .
	self assert: stack pop = firstPushedObject .
	self assert: stack isEmpty.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MAM 9/18/2024 15:40:39'!
initialize
stack:= OrderedCollection new.! !


!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 21:27:02'!
isEmpty
^self size = 0! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:35:31'!
isNotEmpty
^self size ~= 0! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 21:26:36'!
size
^stack size! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:25:49'!
state
^OOStackState stateOf: self.! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:42:43'!
top
^self state top.
! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:47:24'!
topANotEmptyStack
^stack first.! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:39:58'!
topAnEmptyStack
^self error:(self class stackEmptyErrorDescription).! !


!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/18/2024 15:51:08'!
pop
|poppedElement|
poppedElement:= self top.
stack removeFirst.
^poppedElement
! !

!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/18/2024 15:41:50'!
push: anElementToAdd
stack addFirst:anElementToAdd .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:44:17'!
top
self subclassResponsibility .! !


!OOStackState methodsFor: 'initialization' stamp: 'MAM 9/18/2024 15:39:06'!
initializeWith: anOOStack.
stack:= anOOStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 15:38:43'!
stateOf: anOOStack
^(self subclasses detect:[:anStackState| anStackState isStateOf:anOOStack]) new initializeWith: anOOStack.! !


!classDefinition: #EmptyStackState category: #'Stack-Exercise'!
OOStackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:43:36'!
top
^stack topAnEmptyStack .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStackState class' category: #'Stack-Exercise'!
EmptyStackState class
	instanceVariableNames: ''!

!EmptyStackState class methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 15:31:45'!
isStateOf: anOOStack
^anOOStack isEmpty.! !


!classDefinition: #NotEmptyStackState category: #'Stack-Exercise'!
OOStackState subclass: #NotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackState methodsFor: 'accessing' stamp: 'MAM 9/18/2024 15:43:53'!
top
^stack topANotEmptyStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStackState class' category: #'Stack-Exercise'!
NotEmptyStackState class
	instanceVariableNames: ''!

!NotEmptyStackState class methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 15:36:11'!
isStateOf: anOOStack
^anOOStack isNotEmpty.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack prefix wordsWithPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:22:08'!
findByPrefix
|top|
stack isEmpty ifTrue:[^wordsWithPrefix].
top:=stack pop.
self findByPrefix.
(top prefixMatchesRegex: prefix) ifTrue: [wordsWithPrefix addFirst:top.].
stack push:top.
^wordsWithPrefix! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 20:19:38'!
initializeWithPrefix: aSentencePrefix andStack: anOOStack
	
	(aSentencePrefix includesSubString:' ') ifTrue:[self error:'El prefijo no puede contener espacios vacíos'].
	aSentencePrefix isEmpty ifTrue:[self error:'El prefijo no puede ser vacío'].
	(anOOStack class ~= OOStack )ifTrue:[self error:'El stack debe ser de la clase OOStack'].

	stack:=anOOStack .
	prefix:=aSentencePrefix .
	wordsWithPrefix:= OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'MAM 9/18/2024 18:49:13'!
finderOf: aSentencePrefix On: anOOStack
^self new initializeWithPrefix: aSentencePrefix andStack: anOOStack! !
