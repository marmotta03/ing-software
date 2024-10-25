!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 22:04:33'!
test00PortfolioVacíoNoTieneTransacciones
	|portfolio|

	portfolio:= Portfolio new.

	
	self assert: (portfolio transactions) equals: (OrderedCollection new).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/22/2024 20:18:39'!
test01PortfolioVacioTieneBalance0
	|portfolio|

	portfolio:= Portfolio new.

	self assert: portfolio balance equals: 0! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 17:48:02'!
test02PortfolioConUnaCuentaTieneElBalanceDeEsaCuenta
	|portfolio account|

	portfolio:= Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio addAccount:account.

	self assert: portfolio balance equals: 100! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 18:00:07'!
test03PortfolioConUnaCuentaTieneLasTransaccionesDeEsaCuenta
	|portfolio account|

	portfolio:= Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio addAccount:account.

	self assert: (self tieneMismosElementos: (portfolio transactions) que: (account transactions))! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 18:39:11'!
test04PortfolioConMásDeUnaCuentaTieneElBalanceDeTodasLasCuentas
	|portfolio firstAccount secondAccount|

	portfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	Withdraw register: 50 on: secondAccount.
	
	portfolio addAccount:firstAccount.
	portfolio addAccount:secondAccount.	

	self assert: portfolio balance equals: 150! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 18:53:51'!
test05PortfolioConMásDeUnaCuentaTieneLasTransaccionesDeTodasLasCuentas
	|portfolio firstAccount secondAccount totalTransactions|

	portfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	Withdraw register: 50 on: secondAccount.
	
	portfolio addAccount:firstAccount.
	portfolio addAccount:secondAccount.	
	
	totalTransactions:= OrderedCollection new.
	totalTransactions addAll:	(firstAccount transactions).
	totalTransactions addAll: (secondAccount transactions).
	
	self assert: (self tieneMismosElementos: (portfolio transactions ) que: totalTransactions).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 21:58:45'!
test06PortfolioConoceTransaccionRegistradaEnAlgunaDeSusCuentas
	|portfolio firstAccount secondAccount withdraw|

	portfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	withdraw := Withdraw register: 50 on: secondAccount.
	
	portfolio addAccount:firstAccount.
	portfolio addAccount:secondAccount.	
	
	
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 21:58:57'!
test07PortfolioNoConoceTransaccionNoRegistradaEnNingunaDeSusCuentas
	|portfolio firstAccount secondAccount withdraw|

	portfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	Withdraw register: 50 on: secondAccount.
	
	portfolio addAccount:firstAccount.
	portfolio addAccount:secondAccount.	
	
	
	withdraw := Withdraw for: 50.
	
	self deny: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 19:37:55'!
test08PortfolioSumaElBalanceDePortfoliosRegistrados
	|parentPortfolio firstAccount secondAccount childrenPortfolio|

	parentPortfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	parentPortfolio addAccount:firstAccount.
	
	
	childrenPortfolio:= Portfolio new.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	Withdraw register: 50 on: secondAccount.
	
	childrenPortfolio addAccount:secondAccount.
	
	
	parentPortfolio addPortfolio: childrenPortfolio.
	
	self assert: parentPortfolio balance equals: 150.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 21:55:12'!
test09PortfolioTieneLasTransaccionesDePortfoliosRegistrados
	|parentPortfolio firstAccount secondAccount childrenPortfolio totalTransactions|

	parentPortfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	parentPortfolio addAccount:firstAccount.
	
	
	childrenPortfolio:= Portfolio new.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	Withdraw register: 50 on: secondAccount.
	
	childrenPortfolio addAccount:secondAccount.
	
	
	parentPortfolio addPortfolio: childrenPortfolio.
	
	totalTransactions:= OrderedCollection new.
	totalTransactions addAll:	(firstAccount transactions).
	totalTransactions addAll: (secondAccount transactions).
	
	self assert: (self tieneMismosElementos: (parentPortfolio transactions ) que: totalTransactions)	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 21:59:38'!
test10PortfolioConoceTransaccionesDePortfoliosRegistrados
	|parentPortfolio firstAccount secondAccount childrenPortfolio withdraw|

	parentPortfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	parentPortfolio addAccount:firstAccount.
	
	
	childrenPortfolio:= Portfolio new.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	withdraw:= Withdraw register: 50 on: secondAccount.
	
	childrenPortfolio addAccount:secondAccount.
	
	
	parentPortfolio addPortfolio: childrenPortfolio.
	
	
	
	self assert: (parentPortfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 23:31:28'!
test11PortfolioNoPuedeAgregarCuentasRepetidas
	|portfolio firstAccount|

	portfolio:= Portfolio new.
	firstAccount := ReceptiveAccount  new.
	Deposit register: 100 on: firstAccount.
	
	portfolio addAccount:firstAccount.
	
	self should: [portfolio addAccount:firstAccount]
		raise: Error 
		description: [portfolio cuentasRepetidasMensajeDeError]
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MAM 10/24/2024 17:59:16'!
tieneMismosElementos: anOrderedCollection que: anotherOrderedCollection
	^(anOrderedCollection inject: true into:[:acc :each| (anotherOrderedCollection includes:each) and: acc]) and:
	   (anotherOrderedCollection inject: true into:[:acc :each| (anOrderedCollection includes:each) and: acc])! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MAM 10/22/2024 19:50:41'!
value

	^ value! !


!AccountTransaction methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:02'!
isDeposit

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:09'!
isWithdraw

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'initialization' stamp: 'MAM 10/22/2024 19:50:29'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!Deposit methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:19'!
isDeposit
	^true! !

!Deposit methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:27'!
isWithdraw
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!Withdraw methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:37'!
isDeposit
	^false! !

!Withdraw methodsFor: 'accessing' stamp: 'MAM 10/22/2024 19:49:47'!
isWithdraw
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'MAM 10/24/2024 19:37:30'!
balance
	^(accounts sum:[:anAccount| anAccount balance] ifEmpty:[0])+(portfolios sum:[:aPortfolio| aPortfolio balance] ifEmpty:[0]).! !


!Portfolio methodsFor: 'entities' stamp: 'MAM 10/24/2024 17:48:57'!
addAccount: anAccount 
	accounts add:anAccount.! !

!Portfolio methodsFor: 'entities' stamp: 'MAM 10/24/2024 19:35:58'!
addPortfolio: childrenPortfolio 
	portfolios add:childrenPortfolio.! !


!Portfolio methodsFor: 'initialization' stamp: 'MAM 10/24/2024 19:36:22'!
initialize
	accounts:= OrderedCollection new.
	portfolios:=OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'MAM 10/24/2024 22:00:01'!
hasRegistered: aTransaction 
	^self transactions includes:aTransaction.! !

!Portfolio methodsFor: 'transactions' stamp: 'MAM 10/24/2024 21:56:23'!
transactions
	|transactions|
	transactions :=OrderedCollection new.
	accounts do:[:anAccount|transactions addAll: anAccount transactions].
	portfolios do:[:aPortfolio|transactions addAll:aPortfolio transactions].
	^transactions.! !


!Portfolio methodsFor: 'error messages' stamp: 'MAM 10/24/2024 23:30:04'!
cuentasRepetidasMensajeDeError
	^'No se puede tener cuentas repetidas en un portfolio!!'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MAM 10/22/2024 19:52:00'!
balance

	"^transactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]"
	"^transactions inject: 0 into:[:balanceAcc :aTransaction| aTransaction effectOnBalance:balanceAcc]."
	^self totalDeposits - (self totalWithdraws)! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MAM 10/22/2024 19:48:02'!
deposits

	^transactions select:[:aTransaction|aTransaction isDeposit].! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MAM 10/22/2024 19:53:53'!
totalDeposits

	^self deposits sum:[:aDeposit|aDeposit value] ifEmpty:[0]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MAM 10/22/2024 19:54:01'!
totalWithdraws

	^self withdraws sum:[:aWithdraw|aWithdraw value] ifEmpty:[0].! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MAM 10/22/2024 19:48:27'!
withdraws

	^transactions select:[:aTransaction|aTransaction isWithdraw].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
