!classDefinition: #PacmanTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #PacmanTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 21:57:21'!
loQueQueda
	"
	Se que me queda crear una clase Entity con los fantasmas y el pacman porque tienen muchos metodos en comun. OBvio mejorar un monton de clases que quedaron con codigo repetido, como pacman game
	el resto de los test serian
	ver que clyde no come pildoras chicas
	ver que ninguno come pildoras grandes
	ver que se mueve random al llegar a la pared
	todo el final del juego: volver a casilla inicial, perdida de vidas, etc
	Una lastima. Perdi mucho con el principio con el procesamiento del tablero que fue confuso, sino hubiera llegado.
	"! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:29:15'!
test01PacmanStartsMovingLeftAndLeftsEmptySpace
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#p=--#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 19:57:33'!
test02PacmanStaysInPlaceIfTheresAWallAtLeft
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'##p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'##p--#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:03:32'!
test03PacmanStartsWith3LifesAndZeroPoints
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'##p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	self assert: game pacmanPoints equals: 0.
	self assert: game pacmanLifes equals: 3.! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:06:06'!
test04PacmanSumsOnePointWhenEatingASmallPill
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	self assert: game pacmanPoints equals: 1.! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:23:44'!
test05PacmanSumsTwoPointsWhenEatingABigPill
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#*p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	self assert: game pacmanPoints equals: 2.! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:34:52'!
test06PacmanMovesToRightAfterToldToMoveRight
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game pacmanMoveRight.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#-=p-#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:43:35'!
test07PacmanMovesUpAfterToldToMoveUp
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#----#'
'#-p--#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game pacmanMoveUp.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#-p--#'
'#-=--#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:47:12'!
test08PacmanMovesDownAfterToldToMoveDown
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'#----#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game pacmanMoveDown.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#-=--#'
'#-p--#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 20:56:59'!
test09PacmanCanMoveLeftAgainAfterToldToMoveOtherDirection
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'#----#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game pacmanMoveDown.
	game pacmanMoveLeft.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#p=--#'
'#----#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 21:20:41'!
test10PacmanMovesTwiceAfterTwoTicks
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#--p-#'
'#----#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#-BC-#'
'#p==-#'
'#----#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 21:12:27'!
test11BlinkyStartsMovingFrom4TicksOnToTheLeftAndLeftsEmptySpace
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'#----#'
'######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	game tick.
	game tick.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'######'
'#B=C-#'
'#p=--#'
'#----#'
'######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 21:53:32'!
test12BlinkyDoesNotEatSmallPills
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'#######'
'#--BC-#'
'#--p--#'
'#-----#'
'#######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	game tick.
	game tick.
	game tick.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'#######'
'#B-==C#'
'#p==--#'
'#-----#'
'#######').! !

!PacmanTest methodsFor: 'tests' stamp: 'MAM 11/22/2024 21:54:49'!
test13ClydeStartsMovingFrom5TicksOnToTheRightAndLeftsEmptySpace
	"OBSERVACION: me quedo el mismo test porque el test anterior lo habia hecho con el tablero sin mover a clyde"
	|boardString game|
	boardString:= StringPacmanBoard representedAs:#(
'#######'
'#--BC-#'
'#--p--#'
'#-----#'
'#######').

	game:= PacmanGame startWithBoard:boardString.
	game tick.
	game tick.
	game tick.
	game tick.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals:#(
'#######'
'#B-==C#'
'#p==--#'
'#-----#'
'#######').! !


!classDefinition: #StringPacmanBoardTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #StringPacmanBoardTest
	instanceVariableNames: 'visitedElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test01CannotCreateABoardWithoutThePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test02CannotCreateABoardWithMoreThanOnePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BCpp') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test03CannotCreateABoardWithoutBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 14:32:55'!
test04CannotCreateABoardWithMoreThanOneBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pBBC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:33'!
test05CannotCreateABoardWithoutClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pB') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:40'!
test06CannotCreateABoardWithMoreThanOneClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pBCC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:49'!
test07AllRowsHaveSameSize

	self 
		should: [ StringPacmanBoard representedAs: #('pBC' '') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: StringPacmanBoard rowsMustHaveSameSizeErrorDescription! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:00'!
test08VisitElementsWithRightPosition

	| board |
	
	visitedElements := Dictionary new.
	
	board := StringPacmanBoard representedAs: #('pBC#-*=').
	board visitElementsWith: self.
	
	self assert: (visitedElements at: #pacman) equals: 1@1.
	self assert: (visitedElements at: #blinky) equals: 2@1.
	self assert: (visitedElements at: #clyde) equals: 3@1.
	self assert: (visitedElements at: #wall) equals: 4@1.
	self assert: (visitedElements at: #smallPill) equals: 5@1.
	self assert: (visitedElements at: #bigPill) equals: 6@1.
	self assert: (visitedElements at: #space) equals: 7@1.
	self assert: visitedElements size equals: 7
	
	
	! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:11'!
test09InvalidCharactersAreNotAllowed

	self 
		should: [ StringPacmanBoard representedAs: #('pBCx') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard notAllowCharaterErrorDescriptionFor: $x)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 16:42:59'!
test10BoardTranslationExample
"
	HACER PASAR ESTE TEST ANTES DE COMENZAR: falla porque en la posicion del pacman (p) pone un string en vez de #pacman
"
	| board translator |
	
	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p=-#'
'######').

	translator := BoardTranslatorExample on: board.
	
	self assert: translator stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#-p=-#'
'######').
! !


!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:25'!
visitBigPillAt: position 
	
	visitedElements at: #bigPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:27'!
visitBlinkyAt: position 
	
	visitedElements at: #blinky put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:56'!
visitClydeAt: position 
	
	visitedElements at: #clyde put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:10'!
visitPacmanAt: position 
	
	visitedElements at: #pacman put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:14'!
visitSmallPillAt: position 
	
	visitedElements at: #smallPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:17:12'!
visitSpaceAt: position 
	
	visitedElements at: #space put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:05'!
visitWallAt: position 
	
	visitedElements at: #wall put: position ! !


!classDefinition: #BoardTranslatorExample category: #'2024-2C-Parcial-2'!
Object subclass: #BoardTranslatorExample
	instanceVariableNames: 'board boardExtent'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:38:51'!
characterRepresentationOf: anElement
	
	(anElement = #smallPill) ifTrue: [ ^StringPacmanBoard smallPillCharacter ].
	(anElement = #bigPill) ifTrue: [ ^StringPacmanBoard bigPillCharacter ].
	(anElement = #blinky) ifTrue: [ ^StringPacmanBoard blinkyCharacter ].
	(anElement = #clyde) ifTrue: [ ^StringPacmanBoard clydeCharacter ].
	(anElement = #space) ifTrue: [ ^StringPacmanBoard spaceCharacter ].
	(anElement = #wall) ifTrue: [ ^StringPacmanBoard wallCharacter ].
	(anElement = #pacman) ifTrue: [ ^StringPacmanBoard pacmanCharacter ].
	
	self error: 'Unknown pacman element type'! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:45:23'!
representationOfRowNumber: y
	
	^String streamContents: [ :rowStream |
		1 to: boardExtent x do: [ :x |
			rowStream nextPut: (self characterRepresentationOf: (board at: x@y))]]! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'LL 11/22/2024 10:44:29'!
stringRepresentationOfBoard
	
	| rows |
	
	rows := OrderedCollection new.

	1 to: boardExtent y do: [ :y | 
		rows add: (self representationOfRowNumber: y) ].
	
	^rows asArray! !


!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:42:38'!
visitBigPillAt: aPosition 
	
	board at: aPosition put: #bigPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:40:34'!
visitBlinkyAt: aPosition 
	
	board at: aPosition put: #blinky! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:04'!
visitClydeAt: aPosition 
	
	board at: aPosition put: #clyde! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'MAM 11/22/2024 17:52:52'!
visitPacmanAt: aPosition 
	
	board at: aPosition put: #pacman! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:22'!
visitSmallPillAt: aPosition 
	
	board at: aPosition put: #smallPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:30'!
visitSpaceAt: aPosition

	board at: aPosition put: #space
	
	! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:35'!
visitWallAt: aPosition 
	
	board at: aPosition put: #wall! !


!BoardTranslatorExample methodsFor: 'initialization' stamp: 'MAM 11/22/2024 18:34:56'!
aBoardDictionaryExtent: aBoardDictionary

	^((aBoardDictionary keys collect:[:akey| akey x]) max) @ ((aBoardDictionary keys collect:[:akey| akey y]) max)! !

!BoardTranslatorExample methodsFor: 'initialization' stamp: 'HAW 11/22/2024 14:43:18'!
initializeOn: aBoard

	board := Dictionary new.
	boardExtent := aBoard extent.
	aBoard visitElementsWith: self! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardTranslatorExample class' category: #'2024-2C-Parcial-2'!
BoardTranslatorExample class
	instanceVariableNames: ''!

!BoardTranslatorExample class methodsFor: 'as yet unclassified' stamp: 'LL 11/22/2024 10:37:38'!
on: aBoard

	^self new initializeOn: aBoard! !


!classDefinition: #BoardTranslatorForDictionary category: #'2024-2C-Parcial-2'!
Object subclass: #BoardTranslatorForDictionary
	instanceVariableNames: 'boardGameDictionary boardGameExtent'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BoardTranslatorForDictionary methodsFor: 'initialization' stamp: 'MAM 11/22/2024 19:41:55'!
boardDictionaryExtent

	^((boardGameDictionary keys collect:[:akey| akey x]) max) @ ((boardGameDictionary keys collect:[:akey| akey y]) max)! !

!BoardTranslatorForDictionary methodsFor: 'initialization' stamp: 'MAM 11/22/2024 19:40:22'!
initializeFor: boardGame 
	boardGameDictionary := boardGame.
	boardGameExtent := self boardDictionaryExtent.! !


!BoardTranslatorForDictionary methodsFor: 'string representation' stamp: 'MAM 11/22/2024 19:45:58'!
characterRepresentationOf: anElement
	
	(anElement isKindOf:SmallPill ) ifTrue: [ ^StringPacmanBoard smallPillCharacter ].
	(anElement isKindOf:BigPill ) ifTrue: [ ^StringPacmanBoard bigPillCharacter ].
	(anElement isKindOf:Blinky ) ifTrue: [ ^StringPacmanBoard blinkyCharacter ].
	(anElement isKindOf:Clyde ) ifTrue: [ ^StringPacmanBoard clydeCharacter ].
	(anElement isKindOf:Space ) ifTrue: [ ^StringPacmanBoard spaceCharacter ].
	(anElement isKindOf:Wall ) ifTrue: [ ^StringPacmanBoard wallCharacter ].
	(anElement isKindOf:Pacman ) ifTrue: [ ^StringPacmanBoard pacmanCharacter ].
	
	self error: 'Unknown pacman element type'! !

!BoardTranslatorForDictionary methodsFor: 'string representation' stamp: 'MAM 11/22/2024 19:44:30'!
representationOfRowNumber: y
	
	^String streamContents: [ :rowStream |
		1 to: boardGameExtent x do: [ :x |
			rowStream nextPut: (self characterRepresentationOf: (boardGameDictionary at: x@y))]]! !

!BoardTranslatorForDictionary methodsFor: 'string representation' stamp: 'MAM 11/22/2024 19:43:45'!
stringRepresentationOfBoard
	
	| rows |
	
	rows := OrderedCollection new.

	1 to: boardGameExtent y do: [ :y | 
		rows add: (self representationOfRowNumber: y) ].
	
	^rows asArray! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardTranslatorForDictionary class' category: #'2024-2C-Parcial-2'!
BoardTranslatorForDictionary class
	instanceVariableNames: ''!

!BoardTranslatorForDictionary class methodsFor: 'instance creation' stamp: 'MAM 11/22/2024 19:37:54'!
for: boardGame
	
	^self new initializeFor: boardGame ! !


!classDefinition: #EntityHeading category: #'2024-2C-Parcial-2'!
Object subclass: #EntityHeading
	instanceVariableNames: 'entity'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!EntityHeading methodsFor: 'initialization' stamp: 'MAM 11/22/2024 21:28:17'!
initializeFor: anEntity
	entity:= anEntity .! !


!EntityHeading methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:28:23'!
move
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EntityHeading class' category: #'2024-2C-Parcial-2'!
EntityHeading class
	instanceVariableNames: ''!

!EntityHeading class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 21:30:25'!
for: aPacman
	^self new initializeFor: aPacman .! !


!classDefinition: #EntityHeadingDown category: #'2024-2C-Parcial-2'!
EntityHeading subclass: #EntityHeadingDown
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!EntityHeadingDown methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:28:32'!
move
	entity moveDown.! !


!classDefinition: #EntityHeadingLeft category: #'2024-2C-Parcial-2'!
EntityHeading subclass: #EntityHeadingLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!EntityHeadingLeft methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:28:40'!
move
	entity moveLeft.! !


!classDefinition: #EntityHeadingRight category: #'2024-2C-Parcial-2'!
EntityHeading subclass: #EntityHeadingRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!EntityHeadingRight methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:28:47'!
move
	entity moveRight.! !


!classDefinition: #EntityHeadingUp category: #'2024-2C-Parcial-2'!
EntityHeading subclass: #EntityHeadingUp
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!EntityHeadingUp methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:28:53'!
move
	entity moveUp.! !


!classDefinition: #PacmanCell category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanCell
	instanceVariableNames: 'game position'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanCell methodsFor: 'initialization' stamp: 'MAM 11/22/2024 20:53:53'!
initializeForGame: aPacmanGame at: aPosition
	game:= aPacmanGame .
	position:= aPosition .! !


!classDefinition: #BigPill category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #BigPill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BigPill methodsFor: 'occupying' stamp: 'MAM 11/22/2024 20:30:44'!
pacmanStepsOnItFrom: initialPosition 
	game pacmanStepsOnBigPillOn: position from: initialPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BigPill class' category: #'2024-2C-Parcial-2'!
BigPill class
	instanceVariableNames: ''!

!BigPill class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 20:12:42'!
for: aPacmanGame at:aPosition
	^self new initializeForGame: aPacmanGame at:aPosition.! !


!classDefinition: #Ghost category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #Ghost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ghost class' category: #'2024-2C-Parcial-2'!
Ghost class
	instanceVariableNames: ''!

!Ghost class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 19:33:09'!
for: aPacmanGame at:aPosition
	^self new initializeForGame: aPacmanGame at:aPosition.! !


!classDefinition: #Blinky category: #'2024-2C-Parcial-2'!
Ghost subclass: #Blinky
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Blinky methodsFor: 'initialization' stamp: 'MAM 11/22/2024 21:33:19'!
initialize
	heading:=EntityHeadingLeft for:self.! !


!Blinky methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:33:02'!
move
	heading move.! !

!Blinky methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:35:17'!
moveLeft
	game moveBlinkyTo:(position + (-1@0)) from:position.! !


!Blinky methodsFor: 'position' stamp: 'MAM 11/22/2024 21:39:37'!
actualizePositionAt: finalPosition 
	position:= finalPosition .! !


!classDefinition: #Clyde category: #'2024-2C-Parcial-2'!
Ghost subclass: #Clyde
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Clyde methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:48:42'!
move
	heading move.! !

!Clyde methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:50:38'!
moveRight
	game moveClydeTo:(position + (1@0)) from:position.! !


!Clyde methodsFor: 'initialization' stamp: 'MAM 11/22/2024 21:49:38'!
initialize
	heading:= EntityHeadingRight for:self.! !


!Clyde methodsFor: 'position' stamp: 'MAM 11/22/2024 21:52:57'!
actualizePositionAt: aPosition
	position:= aPosition! !


!classDefinition: #Pacman category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #Pacman
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Pacman methodsFor: 'moving' stamp: 'MAM 11/22/2024 21:29:16'!
move
	heading move.! !

!Pacman methodsFor: 'moving' stamp: 'MAM 11/22/2024 20:49:20'!
moveDown
	game movePacmanTo:(position + (0@1)) from:position.! !

!Pacman methodsFor: 'moving' stamp: 'MAM 11/22/2024 20:41:21'!
moveLeft
	
	game movePacmanTo:(position + (-1@0)) from:position.! !

!Pacman methodsFor: 'moving' stamp: 'MAM 11/22/2024 20:41:32'!
moveRight
	
	game movePacmanTo:(position + (1@0)) from:position.! !

!Pacman methodsFor: 'moving' stamp: 'MAM 11/22/2024 20:46:29'!
moveUp
	
	game movePacmanTo:(position + (0@-1)) from:position.! !


!Pacman methodsFor: 'initialization' stamp: 'MAM 11/22/2024 21:33:37'!
initialize
	heading:= EntityHeadingLeft for:self! !


!Pacman methodsFor: 'orientation' stamp: 'MAM 11/22/2024 21:31:38'!
orientateDown
	heading:=EntityHeadingDown for:self.! !

!Pacman methodsFor: 'orientation' stamp: 'MAM 11/22/2024 21:31:57'!
orientateLeft
	heading:=EntityHeadingLeft for:self.! !

!Pacman methodsFor: 'orientation' stamp: 'MAM 11/22/2024 21:32:13'!
orientateRight
	heading:=EntityHeadingRight for:self.! !

!Pacman methodsFor: 'orientation' stamp: 'MAM 11/22/2024 21:32:22'!
orientateUp
	heading:=EntityHeadingUp for:self.! !


!Pacman methodsFor: 'position' stamp: 'MAM 11/22/2024 21:22:01'!
actualizePositionAt: aPosition
	position :=aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pacman class' category: #'2024-2C-Parcial-2'!
Pacman class
	instanceVariableNames: ''!

!Pacman class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 19:33:39'!
for: aPacmanGame at: aPosition
	^self new initializeForGame: aPacmanGame at: aPosition.! !


!classDefinition: #SmallPill category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #SmallPill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!SmallPill methodsFor: 'occupying' stamp: 'MAM 11/22/2024 21:37:46'!
blinkyStepsOnItFrom: initialPosition 
	game blinkyStepsOnSmallPillOn: position from: initialPosition .! !

!SmallPill methodsFor: 'occupying' stamp: 'MAM 11/22/2024 21:51:40'!
clydeStepsOnItFrom: initialPosition 
	game clydeStepsOnSmallPillOn: position from: initialPosition .! !

!SmallPill methodsFor: 'occupying' stamp: 'MAM 11/22/2024 20:31:12'!
pacmanStepsOnItFrom: initialPosition
	game pacmanStepsOnSmallPillOn: position from: initialPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SmallPill class' category: #'2024-2C-Parcial-2'!
SmallPill class
	instanceVariableNames: ''!

!SmallPill class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 20:12:34'!
for: aPacmanGame at:aPosition
	^self new initializeForGame: aPacmanGame at:aPosition.! !


!classDefinition: #Space category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #Space
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Space class' category: #'2024-2C-Parcial-2'!
Space class
	instanceVariableNames: ''!

!Space class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 20:51:41'!
for: aPacmanGame at:aPosition
	^self new initializeForGame: aPacmanGame at:aPosition.! !


!classDefinition: #Wall category: #'2024-2C-Parcial-2'!
PacmanCell subclass: #Wall
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Wall methodsFor: 'occupying' stamp: 'MAM 11/22/2024 20:22:00'!
pacmanStepsOnItFrom: initialPosition 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wall class' category: #'2024-2C-Parcial-2'!
Wall class
	instanceVariableNames: ''!

!Wall class methodsFor: 'as yet unclassified' stamp: 'MAM 11/22/2024 20:12:48'!
for: aPacmanGame at:aPosition
	^self new initializeForGame: aPacmanGame at:aPosition.! !


!classDefinition: #PacmanGame category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanGame
	instanceVariableNames: 'boardGame ticks boardString pacman blinky clyde pacmanPoints pacmanLifes'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGame methodsFor: 'initialization' stamp: 'MAM 11/22/2024 18:48:12'!
createBoardGame
	boardString visitElementsWith: self.! !

!PacmanGame methodsFor: 'initialization' stamp: 'MAM 11/22/2024 20:22:50'!
initializeStartWithBoard: aBoard 
	boardString:= aBoard.
	boardGame := Dictionary new.
	self createBoardGame.
	ticks:= 0.
	pacmanPoints:=0.
	pacmanLifes:=3.! !


!PacmanGame methodsFor: 'ticking' stamp: 'MAM 11/22/2024 19:11:49'!
tick
	ticks:= ticks + 1.
	self continueGame.! !


!PacmanGame methodsFor: 'visualization' stamp: 'MAM 11/22/2024 19:37:27'!
stringRepresentationOfBoard
	|translator|
	translator := BoardTranslatorForDictionary for: boardGame .
	^translator stringRepresentationOfBoard .! !


!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 20:11:22'!
visitBigPillAt: aPosition 
	
	boardGame at: aPosition put: (BigPill for:self at:aPosition ) .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 19:34:35'!
visitBlinkyAt: aPosition 
	
	|aBlinky|
	aBlinky:= Blinky for: self at: aPosition .
	boardGame at:aPosition put:aBlinky .
	blinky := aBlinky .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 19:34:27'!
visitClydeAt: aPosition 
	|aClyde|
	aClyde:= Clyde for: self at: aPosition .
	boardGame at:aPosition put:aClyde .
	clyde:= aClyde .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 19:34:15'!
visitPacmanAt: position
	|aPacman|
	aPacman:= Pacman for: self at: position .
	boardGame at:position put:aPacman .
	pacman:= aPacman .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 20:11:51'!
visitSmallPillAt: aPosition 
	
	boardGame at: aPosition put: (SmallPill for:self at:aPosition ) .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 20:12:04'!
visitSpaceAt: aPosition

	boardGame at: aPosition put: (Space for:self at:aPosition ) .! !

!PacmanGame methodsFor: 'board string visiting' stamp: 'MAM 11/22/2024 20:12:14'!
visitWallAt: position
	boardGame at:position put: (Wall for:self at:position ).! !


!PacmanGame methodsFor: 'playing' stamp: 'MAM 11/22/2024 21:48:04'!
continueGame
	pacman move.
	ticks>=4 ifTrue:[blinky move].
	ticks>=5 ifTrue:[clyde move].! !


!PacmanGame methodsFor: 'pacman stats' stamp: 'MAM 11/22/2024 20:23:02'!
pacmanLifes
	^pacmanLifes ! !

!PacmanGame methodsFor: 'pacman stats' stamp: 'MAM 11/22/2024 20:22:29'!
pacmanPoints
	^pacmanPoints! !


!PacmanGame methodsFor: 'pacman moving' stamp: 'MAM 11/22/2024 20:26:33'!
movePacmanTo: finalPosition from: initialPosition
	(boardGame at: finalPosition) pacmanStepsOnItFrom: initialPosition .
	! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'MAM 11/22/2024 21:23:35'!
pacmanStepsOnBigPillOn: finalPosition from: initialPosition 
	self placePacmanFrom: initialPosition On: finalPosition .
	pacmanPoints := pacmanPoints +2.! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'MAM 11/22/2024 21:23:35'!
pacmanStepsOnSmallPillOn: finalPosition from: initialPosition
	self placePacmanFrom: initialPosition On: finalPosition .
	pacmanPoints := pacmanPoints +1.! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'MAM 11/22/2024 21:23:35'!
placePacmanFrom: initialPosition On: finalPosition

	boardGame at: finalPosition put: pacman.
	boardGame at: initialPosition put: (Space for: self at:initialPosition).
	pacman actualizePositionAt: finalPosition! !


!PacmanGame methodsFor: 'pacman orientation' stamp: 'MAM 11/22/2024 20:47:38'!
pacmanMoveDown
	pacman orientateDown.! !

!PacmanGame methodsFor: 'pacman orientation' stamp: 'MAM 11/22/2024 20:57:15'!
pacmanMoveLeft
	pacman orientateLeft.! !

!PacmanGame methodsFor: 'pacman orientation' stamp: 'MAM 11/22/2024 20:36:30'!
pacmanMoveRight
	pacman orientateRight.! !

!PacmanGame methodsFor: 'pacman orientation' stamp: 'MAM 11/22/2024 20:44:01'!
pacmanMoveUp
	pacman orientateUp.! !


!PacmanGame methodsFor: 'blinky moving' stamp: 'MAM 11/22/2024 21:44:08'!
blinkyStepsOnSmallPillOn: finalPosition from: initialPosition 
	boardGame at: finalPosition put: blinky.
	ticks=4 ifTrue:[boardGame at: initialPosition put: (Space for: self at:initialPosition)]
			ifFalse:[boardGame at: initialPosition put: (SmallPill for: self at:initialPosition)].
	blinky actualizePositionAt: finalPosition.! !

!PacmanGame methodsFor: 'blinky moving' stamp: 'MAM 11/22/2024 21:36:25'!
moveBlinkyTo: finalPosition from: initialPosition 
	(boardGame at: finalPosition) blinkyStepsOnItFrom: initialPosition .! !


!PacmanGame methodsFor: 'clyde moving' stamp: 'MAM 11/22/2024 21:52:33'!
clydeStepsOnSmallPillOn: finalPosition from: initialPosition 
	boardGame at: finalPosition put: clyde.
	ticks=5 ifTrue:[boardGame at: initialPosition put: (Space for: self at:initialPosition)]
			ifFalse:[boardGame at: initialPosition put: (SmallPill for: self at:initialPosition)].
	clyde actualizePositionAt: finalPosition.! !

!PacmanGame methodsFor: 'clyde moving' stamp: 'MAM 11/22/2024 21:51:14'!
moveClydeTo: finalPosition from: initialPosition 
	(boardGame at: finalPosition) clydeStepsOnItFrom: initialPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PacmanGame class' category: #'2024-2C-Parcial-2'!
PacmanGame class
	instanceVariableNames: ''!

!PacmanGame class methodsFor: 'instance creation' stamp: 'MAM 11/22/2024 18:01:23'!
startWithBoard: board 
	
	^self new initializeStartWithBoard: board ! !


!classDefinition: #StringPacmanBoard category: #'2024-2C-Parcial-2'!
Object subclass: #StringPacmanBoard
	instanceVariableNames: 'stringRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoard methodsFor: 'initialization' stamp: 'HAW 11/18/2024 19:29:26'!
initializeRepresentedAs: aStringRepresentation 
	
	stringRepresentation := aStringRepresentation.! !


!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:23:48'!
bigPillCharacter

	^self class bigPillCharacter! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:20'!
blinkyCharacter

	^ self class blinkyCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:30'!
clydeCharacter

	^ self class clydeCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:52'!
pacmanCharacter

	^ self class pacmanCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:15'!
smallPillCharacter

	^self class smallPillCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:37'!
spaceCharacter

	^self class spaceCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:26:00'!
wallCharacter

	^self class wallCharacter! !


!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:21'!
isBigPill: anElement

	^ anElement = self bigPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:36'!
isBlinky: anElement

	^ anElement = self blinkyCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:09'!
isClyde: anElement

	^ anElement = self clydeCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:17'!
isPacman: anElement

	^ anElement = self pacmanCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:12'!
isSmalltPill: anElement

	^ anElement = self smallPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:29'!
isSpace: anElement

	^ anElement = self spaceCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:03'!
isWall: anElement

	^ anElement = self wallCharacter! !


!StringPacmanBoard methodsFor: 'visiting' stamp: 'HAW 11/22/2024 14:38:19'!
visit: anElement at: position with: aPacmanBoardVisitor

	(self isWall: anElement) ifTrue: [ ^aPacmanBoardVisitor visitWallAt: position ].
	(self isSmalltPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSmallPillAt: position ].
	(self isBigPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBigPillAt: position ].
	(self isBlinky: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBlinkyAt: position ].
	(self isClyde: anElement) ifTrue: [ ^aPacmanBoardVisitor visitClydeAt: position ].
	(self isPacman: anElement) ifTrue: [ ^aPacmanBoardVisitor visitPacmanAt: position ].
	(self isSpace: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSpaceAt: position ].
	
	"No hay necesidad de generar un error porque no se permite crear un board con caracteres distintos a todos estos - Hernan"! !

!StringPacmanBoard methodsFor: 'visiting' stamp: 'HAW 11/20/2024 17:22:41'!
visitElementsWith: aPacmanBoardVisitor

	stringRepresentation withIndexDo: [ :aRow :y |
		aRow withIndexDo: [ :anElement :x | 
			self visit: anElement at: x@y with: aPacmanBoardVisitor.]]! !


!StringPacmanBoard methodsFor: 'extent' stamp: 'HAW 11/22/2024 10:50:10'!
extent
	
	"There is always a row and their size is the same to all - Hernan"
	^stringRepresentation first size @ stringRepresentation size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringPacmanBoard class' category: #'2024-2C-Parcial-2'!
StringPacmanBoard class
	instanceVariableNames: ''!

!StringPacmanBoard class methodsFor: 'instance creation' stamp: 'HAW 11/22/2024 10:48:32'!
representedAs: aStringRepresentation 
	
	| elementCharactersCount |
	
	elementCharactersCount := self elementCharacterCountOf: aStringRepresentation.	
	self asserltAllActorsAreIn: elementCharactersCount.
	"If I get here the there is always a row - Hernan"
	self assertAllRowsHaveSameSizeIn: aStringRepresentation.
	
	^self new initializeRepresentedAs: aStringRepresentation 
	! !


!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:30'!
characterIsMissingErrorDescriptionFor: aCharacterName
	
	^aCharacterName, ' is missing'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:39:12'!
notAllowCharaterErrorDescriptionFor: aCharacter

	^'Character ', aCharacter asString, ' is not allowed'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:07:31'!
rowsMustHaveSameSizeErrorDescription
	
	^'Rows must have same number of columns'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:01'!
shouldBeUniqueErrorDescriptionFor: aCharacterName
	
	^'There should be only one ', aCharacterName ! !


!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/21/2024 20:17:42'!
allowedCharacters
	
	^ {
	self pacmanCharacter.
	self blinkyCharacter.
	self clydeCharacter.
	self wallCharacter.
	self bigPillCharacter.
	self smallPillCharacter.
	self spaceCharacter.
	}! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:24:06'!
bigPillCharacter
	
	^ $*! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:25'!
blinkyCharacter
	
	^$B! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:42'!
clydeCharacter
	
	^$C! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:41:25'!
pacmanCharacter
	
	^$p! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:24'!
smallPillCharacter
	
	^ $-! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:46'!
spaceCharacter
	
	^ $=! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:26:06'!
wallCharacter
	
	^ $#! !


!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:12'!
blinkyName

	^ #blinky! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:29'!
clydeName

	^ #clyde! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:05'!
pacmanName

	^ #pacman! !


!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/21/2024 19:59:27'!
asserltAllActorsAreIn: elementCharactersCount

	{ self pacmanName. self blinkyName. self clydeName } do: [ :aCharacterName | 
		self assertActorIsCorrect: aCharacterName in: elementCharactersCount ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:04'!
assert: anElementCharacter isAllowed: allowedCharacters

	(allowedCharacters includes: anElementCharacter) ifFalse: [ self error: (self notAllowCharaterErrorDescriptionFor: anElementCharacter) ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:48:41'!
assertActorIsCorrect: aCharacterName in: elements 
	
	| characterIdentifier |
	
	characterIdentifier := self perform: (aCharacterName, #Character) asSymbol.
	(elements includes: characterIdentifier)
		ifFalse: [ self error: (self characterIsMissingErrorDescriptionFor: aCharacterName) ].
		
	(elements occurrencesOf: characterIdentifier) > 1
		ifTrue: [ self error: (self shouldBeUniqueErrorDescriptionFor: aCharacterName) ].
! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:16'!
assertAllRowsHaveSameSizeIn: aStringRepresentation

	(aStringRepresentation allSatisfy: [ :aRow | aRow size = aStringRepresentation first size ]) ifFalse: [ 
		self error: self rowsMustHaveSameSizeErrorDescription ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:30'!
elementCharacterCountOf: aStringRepresentation

	| elementCharactersCount allowedCharacters |
	
	elementCharactersCount := Bag new.
	allowedCharacters := self allowedCharacters.
	
	aStringRepresentation do: [ :aRow |
		aRow do: [ :anElementCharacter | 
			self assert: anElementCharacter isAllowed: allowedCharacters.
			elementCharactersCount add: anElementCharacter ]].
	
	^elementCharactersCount ! !
