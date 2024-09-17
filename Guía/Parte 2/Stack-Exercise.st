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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MAM 9/16/2024 22:36:52'!
initialize
stack:= OrderedCollection new.
state:= EmptyStack new.! !


!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 21:27:02'!
isEmpty
^self size = 0! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 21:26:36'!
size
^stack size! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:43:59'!
top
^state top:self.
! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:39:40'!
topANotEmptyStack
|topElement|
topElement := stack removeFirst.
stack addFirst:topElement.
^topElement.! !

!OOStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:39:58'!
topAnEmptyStack
^self error:(self class stackEmptyErrorDescription).! !


!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/16/2024 22:43:49'!
pop
^state pop:self.
! !

!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/16/2024 22:49:19'!
popANotEmptyStack
|poppedElement|
poppedElement:=stack removeFirst.
self isEmpty ifTrue:[state:=EmptyStack new].
^poppedElement.! !

!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/16/2024 22:43:18'!
popAnEmptyStack
^self error:(self class stackEmptyErrorDescription).! !

!OOStack methodsFor: 'add/remove' stamp: 'MAM 9/16/2024 22:47:37'!
push: anElementToAdd
stack addFirst:anElementToAdd .
state:= NotEmptyStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:41:19'!
top: aStack
self subclassResponsibility .! !


!OOStackState methodsFor: 'remove' stamp: 'MAM 9/16/2024 22:42:11'!
pop: aStack

	self subclassResponsibility! !


!classDefinition: #EmptyStack category: #'Stack-Exercise'!
OOStackState subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:40:17'!
top: aStack
^aStack topAnEmptyStack .! !


!EmptyStack methodsFor: 'remove' stamp: 'MAM 9/16/2024 22:44:24'!
pop: aStack
^aStack popAnEmptyStack .! !


!classDefinition: #NotEmptyStack category: #'Stack-Exercise'!
OOStackState subclass: #NotEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStack methodsFor: 'accessing' stamp: 'MAM 9/16/2024 22:52:58'!
top: aStack
^aStack topANotEmptyStack.! !


!NotEmptyStack methodsFor: 'remove' stamp: 'MAM 9/16/2024 22:44:38'!
pop: aStack
^aStack popANotEmptyStack .! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
