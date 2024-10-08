!classDefinition: #FloorTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #FloorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:14'!
test01CannotCreateFloorWithoutRooms

	self
		should: [ Floor createFloorWith: 0 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBePositiveErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:20'!
test02CannotCreateFloorWithNoIntergerNumberOfRooms

	self
		should: [ Floor createFloorWith: 1.5 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBeIntegerErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:25'!
test03CannotCreateFloorWithoutPrices

	self
		should: [ Floor createFloorWith: 10 and:  Dictionary new ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor pricesListCannotBeEmptyErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:30'!
test04WhenAFloorIsCreatedAllTheRoomsAreAvailable

	| floor |
	
	floor := Floor createFloorWith: 10 and: self defaultPriceList.
	
	self assert: floor isAvailable.
	self assert: 0 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:34'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := Floor createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:39'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsAndOccupiedAndReducesTheReservedByOne

	| floor roomsNumber roomsAvailable roomsOccupied roomsReserved |
	
	roomsNumber := 10.
	floor := Floor createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) reserve.

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	"Tech Debt"
	((floor rooms) at: 1) receiveWithReservation: self guestTypeVacation.
	
	self assert: roomsAvailable equals: floor totalRoomsAvailable. 
	self assert: roomsOccupied equals: floor totalRoomsOccupied.
	self assert: roomsReserved - 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:44'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedAndOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := Floor createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) reserve.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:48'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := Floor createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	((floor rooms) at: 2) receive: self guestTypeConference.
	((floor rooms) at: 3) reserve.
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 20:39:53'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := Floor createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	((floor rooms) at: 2) receive: self guestTypeConference.
	((floor rooms) at: 3) reserve.
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:09'!
guestTypeConference
	
	^ #conferenceGuest! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:42'!
guestTypeVacation
	
	^ #vacationGuest! !


!classDefinition: #HotelTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:03:06'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel createHotelWithFloors: (OrderedCollection new). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Hotel noFloorsErrorDescription.! !

!HotelTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:30:09'!
test02NewHotelsAreEmpty

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel isEmpty.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:22'!
test03HotelCanReceiveATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:32'!
test04HotelCanTakeAReservationForARoomAtFloor

	| hotel |
	
	hotel := self createHotel.

	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 1 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:41'!
test05HotelCanReceiveWithReservationATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.
	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:17:34'!
test06HotelCannotReceiveWithReservationWithoutPreviousReservation
	
	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	self 
		should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
			self assert: 0 equals: hotel totalRoomsReserved.
			self assert: 0 equals: hotel totalRoomsOccupied.
		]


! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:03:28'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.
	floor2 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:03:39'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.
	floor2 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:03:58'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 42 atFloor: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]
! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:04:09'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 1 atFloor: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:04:20'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:04:30'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel createHotelWithFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'MAM 9/24/2024 21:04:39'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := Floor createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel createHotelWithFloors: floors.

	hotel reserveRoom: 1 atFloor: 1. 
	
	self 
	should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
		self assert: 1 equals: hotel totalRoomsReserved.
		self assert: 1 equals: hotel totalRoomsOccupied.
	]! !


!HotelTest methodsFor: 'create' stamp: 'MAM 9/24/2024 21:01:45'!
createHotel
	
	^Hotel createHotelWithFloors: (OrderedCollection with: (Floor createFloorWith: 10 and: self defaultPriceList)
								      	 with: (Floor createFloorWith: 1 and: self defaultPriceList)).
								! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:36'!
guestTypeConference
	
	^ #conferenceGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:42'!
guestTypeVacation
	
	^ #vacationGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:48'!
maxPriceInList
	
	^ 200*peso ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:53'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #RoomTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 22:11:08'!
test01NewRoomsAreAvailable

	| room |
	
	room := Room new.

	self assert: room isAvailable.
	
	self deny: room isOccupied.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:03:07'!
test02ReceivingAGuestMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self assert: room isOccupied.

	self deny: room isAvailable.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:04:16'!
test03ReservingARoomMakesTheRoomReservedAndOccupied

	| room |
	
	room := Room new.

	room reserve.

	self assert: room isReserved.
	self assert: room isOccupied.

	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:25'!
test04CannotReceiveAGuestInAOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.

			self assert: room isOccupied.
			
			self deny: room isAvailable.
			self deny: room isReserved.
		]
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:32'!
test05CannotReceiveAGuestInAReservedRoom

	| room |
	
	room := Room new.

	room reserve.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			
			self assert: room isReserved.
			self assert: room isOccupied.
			
			self deny: room isAvailable.
		]

	

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:58:29'!
test06ReceivingOnReservationMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room reserve.
	
	room receiveWithReservation: self guestTypeVacation.
	
	self assert: room isOccupied.
	
	self deny: room isReserved.
	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:40'!
test07CannotReceiveOnReservationAnAvailableRoom

	| room |
	
	room := Room new.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.

			self assert: room isAvailable.

			self deny: room isReserved.
			self deny: room isOccupied.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:50'!
test08CannotReceiveOnReservationAnOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 	
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: room isOccupied.

			self deny: room isReserved.
			self deny: room isAvailable.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:22:02'!
test09ProfitOfAvailableRoomIsCeroPesos

	| room |
	
	room := Room new.

	self assert: 0*peso equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:22:57'!
test10ProfitOfReservedRoomIsHalfTheMinPriceInList

	| room |
	
	room := Room new.

	room reserve.

	self assert: self minPriceInList / 2 equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:45:00'!
test11ProfitOfOccupiedRoomDependsOnGuestType

	| roomWithConferenceGuest roomWithVacationGuest |
	
	roomWithConferenceGuest := Room new.
	roomWithConferenceGuest receive: self guestTypeConference.
	
	roomWithVacationGuest := Room new.
	roomWithVacationGuest receive: self guestTypeVacation.

	self assert: (self defaultPriceList at: self guestTypeConference) 
		equals: (roomWithConferenceGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

	self assert: (self defaultPriceList at: self guestTypeVacation) 
		equals: (roomWithVacationGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:52:21'!
test12NoProfitOnOccupiedRoomByUnknownGuestType

	| room |
	
	room := Room new.
	room receive: #unknownGuest.
	
	room profitUsing: self defaultPriceList ifAbsentGuestType: [ ^self ].
	
	"we should not get here"
	self failWith: 'should not calculate profit on room occupied by unknown guest type'.
! !

!RoomTest methodsFor: 'testing' stamp: 'JD 9/25/2024 17:01:06'!
test13LossesOfAvailableRoomIsTheMaxPriceInList

	
	| room |
	
	room := Room new.

	self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'JD 9/25/2024 17:04:41'!
test14LossesOfReservedRoomIsCeroPesos

		| room |
	
		room := Room new.

		room reserve.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).! !

!RoomTest methodsFor: 'testing' stamp: 'JD 9/25/2024 17:04:47'!
test15LossesOfOccupiedRoomIsCeroPesos

		| room |
		
		room := Room new.

		room receive: self guestTypeVacation.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:31'!
test16CannotReserveWhenReserved

	| room |
	
	room := Room new.

	room reserve.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isReserved ].! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:48'!
test17CannotReserveWhenOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isOccupied ].! !


!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:28'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:20:45'!
guestTypeConference
	
	^ #conferenceGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:02:15'!
guestTypeVacation
	
	^ #vacationGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:13'!
maxPriceInList
	
	^ 200*peso ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:40:38'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #Floor category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Floor
	instanceVariableNames: 'rooms prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Floor methodsFor: 'testing' stamp: 'FRT 4/21/2024 15:02:31'!
isAvailable
	
	^ self totalRooms = self totalRoomsAvailable

		
! !


!Floor methodsFor: 'accessing' stamp: 'JD 9/25/2024 16:56:03'!
getRoom: aRoomNumber

	^ rooms at: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ]! !

!Floor methodsFor: 'accessing' stamp: 'FRT 4/20/2024 21:34:09'!
rooms

	^ rooms! !


!Floor methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:17:21'!
totalLosses
	
	^rooms sum:[:aRoom| aRoom lossUsing: prices ifAbsentGuestType: [ self class signalUnknownGuestType ]].

		
! !

!Floor methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:17:26'!
totalProfits

	^rooms sum:[:aRoom| aRoom profitUsing: prices ifAbsentGuestType: [ self class signalUnknownGuestType ]].
! !


!Floor methodsFor: 'totals' stamp: 'FRT 4/21/2024 14:49:55'!
totalRooms
	
	^ rooms size
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:36'!
totalRoomsAvailable
	
	^rooms count: [ :room | room isAvailable ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:47'!
totalRoomsOccupied
	
	^rooms count: [ :room | room isOccupied ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:50:07'!
totalRoomsReserved
	
	^rooms count: [ :room | room isReserved ]! !


!Floor methodsFor: 'initialization' stamp: 'JD 9/25/2024 17:27:55'!
initializeWithPrice: aPriceList andNumberOfRooms: aNumberOfRooms
	
	
	prices := aPriceList.
	rooms := OrderedCollection new.
	
	aNumberOfRooms timesRepeat: [rooms add: Room new.].! !


!Floor methodsFor: 'guests' stamp: 'JD 9/25/2024 16:56:04'!
receive: aGuestType atRoom:aRoomNumber
	|room|
	room := self getRoom: aRoomNumber.
	room receive: aGuestType.! !

!Floor methodsFor: 'guests' stamp: 'JD 9/25/2024 16:56:04'!
receiveWithReservation: aGuestType atRoom:aRoomNumber
	|room|
	room := self getRoom: aRoomNumber.
	room receiveWithReservation: aGuestType.! !

!Floor methodsFor: 'guests' stamp: 'JD 9/25/2024 16:56:04'!
reserveAtRoom:aRoomNumber
	|room|
	room := self getRoom: aRoomNumber.
	room reserve.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'ISW1-2024-1C-Parcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:39:26'!
assertIsInteger: aNumber ifFalse: signalsBlock

	aNumber isInteger ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:40:06'!
assertIsPositive: aNumber ifFalse: signalsBlock

	aNumber strictlyPositive ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'MAM 9/24/2024 20:47:07'!
assertNumberOfRooms: aNumberOfRooms

	self assertIsPositive: aNumberOfRooms ifFalse: [ self signalNumberOfRoomsMustBePositive ].
	self assertIsInteger: aNumberOfRooms ifFalse: [ self signalNumberOfRoomsMustBeInteger ].! !

!Floor class methodsFor: 'assertions' stamp: 'MAM 9/24/2024 20:46:42'!
assertPrices: aPriceList

	aPriceList isEmpty ifTrue: [ self signalNoPrices ].
	
	aPriceList values do: [ :price | 
		self assertIsPositive: price ifFalse: [ self signalPriceMustBePositive ].
	].! !


!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:02:53'!
numberOfRoomsMustBeIntegerErrorDescription
	
	^ 'Number of rooms must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:35:54'!
numberOfRoomsMustBePositiveErrorDescription
	
	^'The number of rooms must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:12'!
priceMustBeIntegerErrorDescription
	
	^ 'Price must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:25'!
priceMustBePositiveErrorDescription
	
	^'Price must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:43:01'!
pricesListCannotBeEmptyErrorDescription 
	
	^ 'Prices List must not be empty'! !

!Floor class methodsFor: 'error messages' stamp: 'JD 9/25/2024 16:43:04'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:47:30'!
unknownGuestTypeErrorDescription
	
	^ 'The guest type is unknown'! !


!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:42:33'!
signalNoPrices
	
	self error: self pricesListCannotBeEmptyErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:02:35'!
signalNumberOfRoomsMustBeInteger
	
	self error: self numberOfRoomsMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:35:54'!
signalNumberOfRoomsMustBePositive

	self error: self numberOfRoomsMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:37'!
signalPriceMustBeInteger
	
	self error: self priceMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:58'!
signalPriceMustBePositive

	self error: self priceMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'JD 9/25/2024 16:42:36'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:48:09'!
signalUnknownGuestType

	self error: self class unknownGuestTypeErrorDescription
! !


!Floor class methodsFor: 'instance creation' stamp: 'MAM 9/24/2024 20:58:30'!
createFloorWith: aNumberOfRooms and: aPrice

	self assertNumberOfRooms: aNumberOfRooms .
	self assertPrices: aPrice.

	^self new initializeWithPrice: aPrice andNumberOfRooms: aNumberOfRooms .! !


!classDefinition: #Hotel category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Hotel methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:15:02'!
totalLosses
	^floors sum:[:aFloor| aFloor totalLosses ]
! !

!Hotel methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:15:07'!
totalProfits
	^floors sum:[:aFloor| aFloor totalProfits ]! !


!Hotel methodsFor: 'initialization' stamp: 'JD 9/25/2024 16:37:34'!
initializeWithFloors: aFloorsCollection

	floors := aFloorsCollection.
! !


!Hotel methodsFor: 'totals' stamp: 'JD 9/25/2024 17:15:42'!
totalRooms

	^floors sum:[:aFloor|aFloor totalRooms].

! !

!Hotel methodsFor: 'totals' stamp: 'JD 9/25/2024 16:26:11'!
totalRoomsAvailable

	^ floors sum:[ :aFloor| aFloor totalRoomsAvailable ].
! !

!Hotel methodsFor: 'totals' stamp: 'JD 9/25/2024 17:16:08'!
totalRoomsOccupied

	^ floors sum:[ :aFloor| aFloor totalRoomsOccupied ].


! !

!Hotel methodsFor: 'totals' stamp: 'JD 9/25/2024 17:16:14'!
totalRoomsReserved

	^ floors sum:[ :aFloor| aFloor totalRoomsReserved ].

! !


!Hotel methodsFor: 'testing' stamp: 'JD 9/25/2024 17:15:24'!
isEmpty
	
	^self totalRooms = (self totalRoomsAvailable)
	
! !


!Hotel methodsFor: 'guests' stamp: 'JD 9/25/2024 17:13:04'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor |
	
	floor := self getFloor: aFloorNumber.
	floor receive: aGuestType atRoom:aRoomNumber.
! !

!Hotel methodsFor: 'guests' stamp: 'JD 9/25/2024 17:13:04'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor |
	
	floor := self getFloor: aFloorNumber.
	floor receiveWithReservation: aGuestType atRoom: aRoomNumber .! !

!Hotel methodsFor: 'guests' stamp: 'JD 9/25/2024 17:13:04'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	| floor |
	
	floor := self getFloor: aFloorNumber.
	floor reserveAtRoom: aRoomNumber .! !


!Hotel methodsFor: 'accessing' stamp: 'JD 9/25/2024 17:13:04'!
getFloor: aFloorNumber

	^ floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hotel class' category: #'ISW1-2024-1C-Parcial'!
Hotel class
	instanceVariableNames: ''!

!Hotel class methodsFor: 'assertions' stamp: 'HAW 4/29/2024 08:48:39'!
assertHaveFloors: aFloorsCollection

	aFloorsCollection isEmpty ifTrue: [ self signalNoFloors ].! !


!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:42:02'!
floorNumberDoesNotExistErrorDescription

	^ 'Floor number does not exist'.! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/20/2024 21:42:02'!
noFloorsErrorDescription

	^ 'Cannot have a Hotel without floors'! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:41:41'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !


!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:24'!
signalFloorNumberDoesNotExist

	self error: self floorNumberDoesNotExistErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 21:41:30'!
signalNoFloors

	self error: self noFloorsErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:39'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !


!Hotel class methodsFor: 'instance creation' stamp: 'MAM 9/24/2024 20:52:15'!
createHotelWithFloors: aFloorsCollection
	
	self assertHaveFloors: aFloorsCollection.
	^Hotel new initializeWithFloors: aFloorsCollection ! !


!classDefinition: #Room category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Room
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:02:08'!
receive: aGuestType

	^state receive: aGuestType .! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:02:04'!
receiveGuest: aGuestType

	state:=OcupiedRoom stateOfRoom: self withGuest: aGuestType .! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:02:00'!
receiveWhenOccupied

	self error: self class roomIsNotEmptyErrorDescription.
! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:01:56'!
receiveWithReservation: aGuestType

	^state receiveWithReservation: aGuestType.
! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 15:43:08'!
receiveWithReservationWhenNotReserved
	
	self error: self class roomIsNotReservedErrorDescription.
! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:04:08'!
reserve

	"state isAvailable ifTrue:[state:=ReservedRoom stateOfRoom: self] ifFalse: [ self error: self class roomIsNotEmptyErrorDescription ]."
	^state reserve .
	! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:10:30'!
reserveNotAvailable

	self error: self class roomIsNotEmptyErrorDescription.
	! !

!Room methodsFor: 'guests' stamp: 'JD 9/25/2024 16:09:24'!
reserveWhenAvailable

	state:=ReservedRoom stateOfRoom: self.
	! !


!Room methodsFor: 'testing' stamp: 'JD 9/25/2024 16:01:30'!
isAvailable

	^state isAvailable .! !

!Room methodsFor: 'testing' stamp: 'JD 9/25/2024 16:01:23'!
isOccupied
	^state isOccupied.! !

!Room methodsFor: 'testing' stamp: 'JD 9/25/2024 16:01:27'!
isReserved

	^state isReserved .! !


!Room methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:01:42'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^state lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock .! !

!Room methodsFor: 'accounting' stamp: 'JD 9/25/2024 16:01:16'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^state profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock .! !


!Room methodsFor: 'initialization' stamp: 'JD 9/25/2024 15:24:01'!
initialize
state:=EmptyRoom stateOfRoom: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: #'ISW1-2024-1C-Parcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:14'!
roomIsNotEmptyErrorDescription

	^ 'Room is not empty.'! !

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:43'!
roomIsNotReservedErrorDescription

	^ 'Room is not reserved.'! !


!classDefinition: #RoomStatus category: #'ISW1-2024-1C-Parcial'!
Object subclass: #RoomStatus
	instanceVariableNames: 'room'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomStatus methodsFor: 'testing' stamp: 'JD 9/25/2024 15:15:05'!
isAvailable

	self subclassResponsibility! !

!RoomStatus methodsFor: 'testing' stamp: 'JD 9/25/2024 15:15:09'!
isOccupied

	self subclassResponsibility! !

!RoomStatus methodsFor: 'testing' stamp: 'JD 9/25/2024 15:15:15'!
isReserved

	self subclassResponsibility! !


!RoomStatus methodsFor: 'initialization' stamp: 'MAM 9/24/2024 21:17:32'!
initializeWithRoom:aRoom
room:=aRoom .! !


!RoomStatus methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:02:33'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	self subclassResponsibility! !

!RoomStatus methodsFor: 'accounting' stamp: 'JD 9/25/2024 15:19:49'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	self subclassResponsibility! !


!RoomStatus methodsFor: 'guests' stamp: 'JD 9/25/2024 15:28:20'!
receive: aGuestType

	self subclassResponsibility! !

!RoomStatus methodsFor: 'guests' stamp: 'JD 9/25/2024 15:28:42'!
receiveWithReservation: aGuestType

	self subclassResponsibility! !

!RoomStatus methodsFor: 'guests' stamp: 'JD 9/25/2024 16:05:52'!
reserve

	self subclassResponsibility! !


!classDefinition: #EmptyRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #EmptyRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!EmptyRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:06'!
isAvailable
^true! !

!EmptyRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:11'!
isOccupied
^false! !

!EmptyRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:15'!
isReserved
^false! !


!EmptyRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:04:04'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	^aPriceList values max! !

!EmptyRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 15:20:10'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	"Room Available"
	^ 0*peso 
! !


!EmptyRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:46:09'!
receive: aGuestType
	
	room receiveGuest:aGuestType. ! !

!EmptyRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:43:25'!
receiveWithReservation: aGuestType
	
	"Room Reserved"
	room receiveWithReservationWhenNotReserved . 
! !

!EmptyRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 16:09:05'!
reserve
room reserveWhenAvailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyRoom class' category: #'ISW1-2024-1C-Parcial'!
EmptyRoom class
	instanceVariableNames: ''!

!EmptyRoom class methodsFor: 'instance creation' stamp: 'JD 9/25/2024 15:50:30'!
stateOfRoom: aRoom
^self new initializeWithRoom: aRoom .! !


!classDefinition: #OcupiedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #OcupiedRoom
	instanceVariableNames: 'guest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!OcupiedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:31'!
isAvailable
^false! !

!OcupiedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:21'!
isOccupied
^true! !

!OcupiedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:27'!
isReserved
^false! !


!OcupiedRoom methodsFor: 'initialization' stamp: 'JD 9/25/2024 15:01:42'!
initializeWithRoom:aRoom andWithGuest:aGuestName
self initializeWithRoom: aRoom.
guest:=aGuestName .! !


!OcupiedRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:04:19'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
^0*peso! !

!OcupiedRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 15:20:58'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	"Room Occupied"
	^ aPriceList at: guest ifAbsent: unknownGuestTypeBlock.! !


!OcupiedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:33:36'!
receive: aGuestType

	"Room Occupied"
	room receiveWhenOccupied.! !

!OcupiedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:43:47'!
receiveWithReservation: aGuestType
	
	"Room Reserved"
	room receiveWithReservationWhenNotReserved .
! !

!OcupiedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 16:09:51'!
reserve
room reserveNotAvailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OcupiedRoom class' category: #'ISW1-2024-1C-Parcial'!
OcupiedRoom class
	instanceVariableNames: ''!

!OcupiedRoom class methodsFor: 'instance creation' stamp: 'JD 9/25/2024 15:11:10'!
stateOfRoom:aRoom withGuest:aGuestType
^self new initializeWithRoom: aRoom andWithGuest: aGuestType .! !


!classDefinition: #ReservedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #ReservedRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!ReservedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:38'!
isAvailable
^false! !

!ReservedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:54:23'!
isOccupied
^true! !

!ReservedRoom methodsFor: 'testing' stamp: 'JD 9/25/2024 15:52:48'!
isReserved
^true! !


!ReservedRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 17:02:56'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	^0*peso! !

!ReservedRoom methodsFor: 'accounting' stamp: 'JD 9/25/2024 15:21:27'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	"Room Reserved"
	^ aPriceList values min / 2.
! !


!ReservedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:59:26'!
receive: aGuestType

	room receiveWhenOccupied.! !

!ReservedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 15:47:03'!
receiveWithReservation: aGuestType
	
	"Room Reserved"
	room receiveGuest:aGuestType .
! !

!ReservedRoom methodsFor: 'guests' stamp: 'JD 9/25/2024 16:10:11'!
reserve
room reserveNotAvailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReservedRoom class' category: #'ISW1-2024-1C-Parcial'!
ReservedRoom class
	instanceVariableNames: ''!

!ReservedRoom class methodsFor: 'instance creation' stamp: 'JD 9/25/2024 15:10:23'!
stateOfRoom: aRoom
^self new initializeWithRoom: aRoom .! !
