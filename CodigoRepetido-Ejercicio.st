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
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 19:30:39'!
assert: aBlockClosure shouldNotTakeMoreThan: aTimeMeasure 
	
	self assert: (Time millisecondsToRun: aBlockClosure) * millisecond < aTimeMeasure
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:10:02'!
assertActiveCustomers: activeCustomer suspendedCustomers: suspendedCustomers customers: customers
	
	self assert: activeCustomer equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: customers equals: customerBook numberOfCustomers
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:09:17'!
setUp

	super setUp.
	customerBook := CustomerBook new! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:10:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self assert: [ customerBook addCustomerNamed: 'John Lennon' ] shouldNotTakeMoreThan: 50 * millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:10:29'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	|  paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: [ customerBook removeCustomerNamed: paulMcCartney] shouldNotTakeMoreThan: 100 * millisecond
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:10:37'!
test03CanNotAddACustomerWithEmptyName 

	self should: [customerBook addCustomerNamed: ''] raise: Error description: CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:10:51'!
test04CanNotRemoveAnInvalidCustomer
	
	|  johnLennon |
			
	
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] raise: NotFound.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:16:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	|  paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:17:25'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:11:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook suspendCustomerNamed: 'Paul McCartney'] raise: CantSuspend.
	
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon) 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FV 4/4/2019 20:11:47'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self should: [ customerBook suspendCustomerNamed: johnLennon ] raise: CantSuspend.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon) 
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'FV 4/4/2019 20:31:00'!
includesActiveCustomerNamed: aName

	^active includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'FV 4/4/2019 20:50:23'!
includesCustomerNamed: aName

	^(self includesActiveCustomerNamed: aName) or: [ self includesSuspendedCustomerNamed: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'FV 4/4/2019 20:31:10'!
includesSuspendedCustomerNamed: aName

	^suspended includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FV 4/4/2019 20:20:58'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FV 4/4/2019 20:22:12'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FV 4/4/2019 20:27:08'!
removeCustomerNamed: aName 
 
	^active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [NotFound signal]
		]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FV 4/4/2019 20:31:48'!
suspendCustomerNamed: aName 
	
	(self includesActiveCustomerNamed: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
