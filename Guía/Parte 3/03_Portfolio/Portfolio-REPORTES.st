!classDefinition: #PortfolioTest category: 'Portfolio-REPORTES'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-REPORTES'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-REPORTES'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:45:34'!
test01AccountSummaryOfEmptyAccountIsBalanceZero
	|accountSummary account|
	
	account:=ReceptiveAccount new.
	
	"accountSummary:= account accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: account) report.
	
	self assert: accountSummary includes: 'Balance = 0'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:46:10'!
test02AccountSummaryIncludesDeposit
	|accountSummary account|
	
	account:=ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	"accountSummary:= account accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: account) report.
	
	self assert: accountSummary includes: 'Depósito por 100'.
	self assert: accountSummary includes: 'Balance = 100'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:46:26'!
test03AccountSummaryIncludesWithdraw
	|accountSummary account|
	
	account:=ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	"accountSummary:= account accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: account) report.
	
	self assert: accountSummary includes: 'Extracción por 100'.
	self assert: accountSummary includes: 'Balance = -100'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:46:42'!
test04AccountSummaryIncludesDepositLeg
	|accountSummary firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Transference register: 100 from: firstAccount to: secondAccount.
	
	"accountSummary:= secondAccount accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: secondAccount) report.
	
	self assert: accountSummary includes: 'Entrada por transferencia de 100'.
	self assert: accountSummary includes: 'Balance = 100'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:47:02'!
test05AccountSummaryIncludesWithdrawLeg
	|accountSummary firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Transference register: 100 from: firstAccount to: secondAccount.
	
	"accountSummary:= firstAccount accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: firstAccount) report.
	
	self assert: accountSummary includes: 'Salida por transferencia de 100'.
	self assert: accountSummary includes: 'Balance = -100'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:47:19'!
test06AccountSummaryIncludesAllTransactions
	|accountSummary firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Deposit register: 50 on: firstAccount.
	Transference register: 100 from: firstAccount to: secondAccount.
	
	"accountSummary:= firstAccount accountSummary."
	accountSummary:= (TransactionsVisitatorAccountSummary visitatorOf: firstAccount) report.
	
	self assert: accountSummary includes:'Depósito por 50'.
	self assert: accountSummary includes: 'Salida por transferencia de 100'.
	self assert: accountSummary includes: 'Balance = -50'.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:52:44'!
test07TransferNetOfEmptyAccountIsZero
	|transferNet account |
	
	account:=ReceptiveAccount new.
	
	"transferNet:= account transferNet."
	transferNet:= (TransactionsVisitatorTransferNet visitatorOf: account) report.
	
	self assert: transferNet equals:0.! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:53:07'!
test08TransferNetSubstractsTransferenceWithdraw
	|transferNet firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Transference register: 100 from: firstAccount to: secondAccount.
	
	"transferNet:= firstAccount transferNet."
	transferNet:= (TransactionsVisitatorTransferNet visitatorOf: firstAccount) report.
	
	self assert: transferNet equals:(-100).! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:53:22'!
test09TransferNetSumsTransferenceDeposit
	|transferNet firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Transference register: 100 from: firstAccount to: secondAccount.
	
	"transferNet:= secondAccount transferNet."
	transferNet:= (TransactionsVisitatorTransferNet visitatorOf: secondAccount) report.
	
	self assert: transferNet equals:(100).! !

!ReportsTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 23:53:42'!
test10TransferNetSumsAllTransferences
	|transferNet firstAccount secondAccount|
	
	firstAccount:=ReceptiveAccount new.
	secondAccount:=ReceptiveAccount new.
	Transference register: 100 from: firstAccount to: secondAccount.
	Transference register: 50 from: firstAccount to: secondAccount.
	
	"transferNet:= firstAccount transferNet."
	transferNet:= (TransactionsVisitatorTransferNet visitatorOf: firstAccount) report.
	
	self assert: transferNet equals:(-150).! !


!classDefinition: #TransferenceTest category: 'Portfolio-REPORTES'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!TransferenceTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 18:13:28'!
test01TransferenceDecreasesAndIncreasesBalance
	|firstAccount secondAccount|
	
	firstAccount := ReceptiveAccount new.
	
	secondAccount := ReceptiveAccount new.
	
	Transference register: 100 from: firstAccount to: secondAccount .
	
	self assert: firstAccount balance equals: -100.
	self assert: secondAccount balance equals: 100! !

!TransferenceTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 18:45:58'!
test02TransferenceIsRegisteredInBothAccounts
	|firstAccount secondAccount transference|
	
	firstAccount := ReceptiveAccount new.
	
	secondAccount := ReceptiveAccount new.
	
	transference := Transference register: 100 from: firstAccount to: secondAccount .
	
	self assert: (firstAccount hasRegistered: transference withdrawLeg).
	self assert: (secondAccount hasRegistered: transference depositLeg).! !

!TransferenceTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 18:47:35'!
test03CanGoFromDepositLegToWithdrawLeg
	|firstAccount secondAccount transference|
	
	firstAccount := ReceptiveAccount new.
	
	secondAccount := ReceptiveAccount new.
	
	transference := Transference register: 100 from: firstAccount to: secondAccount .
	
	self assert: (transference depositLeg withdrawLeg) equals:(transference withdrawLeg).! !

!TransferenceTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 18:54:51'!
test04CanGoFromWithdraLegToDepositLeg
	|firstAccount secondAccount transference|
	
	firstAccount := ReceptiveAccount new.
	
	secondAccount := ReceptiveAccount new.
	
	transference := Transference register: 100 from: firstAccount to: secondAccount .
	
	self assert: (transference withdrawLeg depositLeg) equals:(transference depositLeg ).! !

!TransferenceTest methodsFor: 'tests' stamp: 'MAM 10/30/2024 19:22:30'!
test05ValueMustBeKeptInOnePlaceOnly
	|firstAccount secondAccount transference|
	
	firstAccount := ReceptiveAccount new.
	
	secondAccount := ReceptiveAccount new.
	
	transference := Transference register: 100 from: firstAccount to: secondAccount .
	
	transference value: 50.
	
	self assert: (transference withdrawLeg value) equals:50.
	self assert: (transference depositLeg value) equals:50.
	! !


!classDefinition: #Account category: 'Portfolio-REPORTES'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-REPORTES'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-REPORTES'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-REPORTES'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'MAM 10/30/2024 21:44:14'!
accountSummary
	|accountSummary|
	
	accountSummary:= OrderedCollection new.
	transactions do:[:aTransaction |
		(aTransaction isKindOf:Deposit) ifTrue:[accountSummary add: ('Depósito por ', aTransaction value asString)].
		(aTransaction isKindOf:Withdraw) ifTrue:[accountSummary add: ('Extracción por ', aTransaction value asString)].
		(aTransaction isKindOf:DepositLegOfTransference) ifTrue:[accountSummary add: ('Entrada por transferencia de ', aTransaction value asString)].
		(aTransaction isKindOf:WithdrawLegOfTransference) ifTrue:[accountSummary add: ('Salida por transferencia de ', aTransaction value asString)].].
	
	accountSummary add:'Balance = ', self balance asString.
	
	^accountSummary ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:17:31'!
reportTransactionsOn: aVisitor
	transactions do:[:aTransaction | aTransaction reportOn: aVisitor.]! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MAM 10/30/2024 22:30:37'!
transferNet
	|transferNet|
	
	transferNet:= 0.
	transactions do:[:aTransaction |
		(aTransaction isKindOf:DepositLegOfTransference) ifTrue:[transferNet:=transferNet + aTransaction value].
		(aTransaction isKindOf:WithdrawLegOfTransference) ifTrue:[transferNet:=transferNet - aTransaction value].].
	
	^transferNet! !


!classDefinition: #AccountTransaction category: 'Portfolio-REPORTES'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:13:57'!
reportOn: aVisitor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-REPORTES'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-REPORTES'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:14:50'!
reportOn: aVisitor
	aVisitor reportDeposit: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-REPORTES'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Leg category: 'Portfolio-REPORTES'!
AccountTransaction subclass: #Leg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Leg methodsFor: 'initialization' stamp: 'MAM 10/30/2024 19:20:28'!
initializeOfTransference: aTransference.
	transference := aTransference .! !


!Leg methodsFor: 'value' stamp: 'MAM 10/30/2024 19:18:31'!
value
	^transference value .! !


!Leg methodsFor: 'balance' stamp: 'MAM 10/30/2024 19:10:19'!
affectBalance: aBalance

	self subclassResponsibility! !


!Leg methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:14:17'!
reportOn: aVisitor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Leg class' category: 'Portfolio-REPORTES'!
Leg class
	instanceVariableNames: ''!

!Leg class methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 19:20:16'!
registerTransference: aTransference on: account
	|transaction |
	
	transaction:= self new initializeOfTransference: aTransference .
	account register: transaction.
	
	^ transaction! !


!classDefinition: #DepositLegOfTransference category: 'Portfolio-REPORTES'!
Leg subclass: #DepositLegOfTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!DepositLegOfTransference methodsFor: 'balance' stamp: 'MAM 10/30/2024 19:09:30'!
affectBalance: aBalance

	^aBalance + self value ! !


!DepositLegOfTransference methodsFor: 'leg' stamp: 'MAM 10/30/2024 18:53:49'!
withdrawLeg
	^transference withdrawLeg .! !


!DepositLegOfTransference methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:15:19'!
reportOn: aVisitor
	aVisitor reportDepositLegOfTransference: self.! !


!classDefinition: #WithdrawLegOfTransference category: 'Portfolio-REPORTES'!
Leg subclass: #WithdrawLegOfTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!WithdrawLegOfTransference methodsFor: 'balance' stamp: 'MAM 10/30/2024 19:09:41'!
affectBalance: aBalance

	^aBalance - self value ! !


!WithdrawLegOfTransference methodsFor: 'leg' stamp: 'MAM 10/30/2024 18:54:13'!
depositLeg
	^transference depositLeg! !


!WithdrawLegOfTransference methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:15:38'!
reportOn: aVisitor
	aVisitor reportWithdrawLegOfTransference: self.! !


!classDefinition: #Withdraw category: 'Portfolio-REPORTES'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:15:48'!
reportOn: aVisitor
	aVisitor reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-REPORTES'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionsVisitator category: 'Portfolio-REPORTES'!
Object subclass: #TransactionsVisitator
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!TransactionsVisitator methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:16:25'!
report
	
	account reportTransactionsOn: self.! !

!TransactionsVisitator methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:49:41'!
reportDeposit: aDeposit

	self subclassResponsibility! !

!TransactionsVisitator methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:49:55'!
reportDepositLegOfTransference: aDepositLeg

	self subclassResponsibility! !

!TransactionsVisitator methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:50:00'!
reportWithdraw: aWithdraw

	self subclassResponsibility! !

!TransactionsVisitator methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:50:05'!
reportWithdrawLegOfTransference: aWithdrawLeg

	self subclassResponsibility! !


!TransactionsVisitator methodsFor: 'initialization' stamp: 'MAM 10/30/2024 22:52:39'!
initializeWith: anAccount
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionsVisitator class' category: 'Portfolio-REPORTES'!
TransactionsVisitator class
	instanceVariableNames: ''!

!TransactionsVisitator class methodsFor: 'as yet unclassified' stamp: 'MAM 10/30/2024 23:44:45'!
visitatorOf: account
	^self new initializeWith: account.! !


!classDefinition: #TransactionsVisitatorAccountSummary category: 'Portfolio-REPORTES'!
TransactionsVisitator subclass: #TransactionsVisitatorAccountSummary
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!TransactionsVisitatorAccountSummary methodsFor: 'initialization' stamp: 'MAM 10/30/2024 23:20:06'!
initialize
	accountSummary := OrderedCollection new.! !


!TransactionsVisitatorAccountSummary methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:24:36'!
report
	super report.
	accountSummary add:('Balance = ', account balance asString).
	^accountSummary .! !

!TransactionsVisitatorAccountSummary methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:23:27'!
reportDeposit: aDeposit
	accountSummary add: ('Depósito por ', aDeposit value asString).! !

!TransactionsVisitatorAccountSummary methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:23:49'!
reportDepositLegOfTransference: aDepositLeg
	accountSummary add: ('Entrada por transferencia de ', aDepositLeg value asString)! !

!TransactionsVisitatorAccountSummary methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:24:06'!
reportWithdraw: aWithdraw
	accountSummary add: ('Extracción por ', aWithdraw value asString)! !

!TransactionsVisitatorAccountSummary methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:24:25'!
reportWithdrawLegOfTransference: aWithdrawLeg
	accountSummary add: ('Salida por transferencia de ', aWithdrawLeg value asString)! !


!classDefinition: #TransactionsVisitatorTransferNet category: 'Portfolio-REPORTES'!
TransactionsVisitator subclass: #TransactionsVisitatorTransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!TransactionsVisitatorTransferNet methodsFor: 'initialization' stamp: 'MAM 10/30/2024 23:47:51'!
initialize
	transferNet:=0! !


!TransactionsVisitatorTransferNet methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:52:03'!
report
	super report.
	^transferNet.! !

!TransactionsVisitatorTransferNet methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:51:09'!
reportDeposit: aDeposit
! !

!TransactionsVisitatorTransferNet methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:51:22'!
reportDepositLegOfTransference: aDepositLeg

	transferNet:=transferNet + aDepositLeg value.! !

!TransactionsVisitatorTransferNet methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:51:27'!
reportWithdraw: aWithdraw
! !

!TransactionsVisitatorTransferNet methodsFor: 'reports' stamp: 'MAM 10/30/2024 23:51:46'!
reportWithdrawLegOfTransference: aWithdrawLeg

	transferNet:=transferNet - aWithdrawLeg value! !


!classDefinition: #Transference category: 'Portfolio-REPORTES'!
Object subclass: #Transference
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-REPORTES'!

!Transference methodsFor: 'initialization' stamp: 'MAM 10/30/2024 19:20:51'!
initializeWith: aValue from: firstAccount to: secondAccount 
	
	value := aValue.
	withdrawLeg := WithdrawLegOfTransference registerTransference: self on: firstAccount .
	depositLeg := DepositLegOfTransference registerTransference: self on: secondAccount .! !


!Transference methodsFor: 'legs' stamp: 'MAM 10/30/2024 18:44:45'!
depositLeg
	^depositLeg .
	! !

!Transference methodsFor: 'legs' stamp: 'MAM 10/30/2024 18:44:32'!
withdrawLeg
	^withdrawLeg 
	! !


!Transference methodsFor: 'value' stamp: 'MAM 10/30/2024 19:12:22'!
value
	^value.! !

!Transference methodsFor: 'value' stamp: 'MAM 10/30/2024 19:22:49'!
value: newValue 
	
	value := newValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-REPORTES'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'MAM 10/30/2024 18:45:10'!
register: aValue from: firstAccount to: secondAccount 
	
	|transference|
	
	transference:= self new initializeWith: aValue from: firstAccount to: secondAccount .
	
	^transference.! !
