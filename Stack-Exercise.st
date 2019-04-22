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

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:13:42'!
test01FindWithStackEmpty

	| finder |
	
	finder := SentenceFinderByPrefix with: OOStack new.
	self assert: (finder find: 'A')  isEmpty
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:26:41'!
test02FindWithNonExistentSentencesWithPrefixA

	| finder |
	
	finder := SentenceFinderByPrefix with: (OOStack new push: 'winter is coming').
	self assert: (finder find: 'A')  isEmpty
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:43:33'!
test03FindWithExistentSentencesWithPrefixW

	| finder |
	
	finder := SentenceFinderByPrefix with: (OOStack new push: 'winter is coming').
	self assert: (finder find: 'w')  equals: (OrderedCollection with: 'winter is coming').
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:50:21'!
test04FindSentencesWithPrefixWInMultipleSentencesStack

	| finder stack |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winter is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	finder := SentenceFinderByPrefix with: stack.
	self assert: (finder find: 'winter')  equals: (OrderedCollection with: 'Winter is here' with: 'winter is everything'with: 'winter is coming' ).
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:51:14'!
test05FindSentencesWithPrefixWInMultipleAndDuplicatedSentencesStack

	| finder stack |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winter is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	stack push: 'winter is coming'.
	finder := SentenceFinderByPrefix with: stack.
	self assert: (finder find: 'winter')  equals: (OrderedCollection with: 'winter is coming' with: 'Winter is here' with: 'winter is everything'with: 'winter is coming' ).
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 15:03:10'!
test06FindWithEmptyPrefixIsNotAllowed

	| finder stack |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winter is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	stack push: 'winter is coming'.
	finder := SentenceFinderByPrefix with: stack.
	self
		should: [ finder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]
	
	
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'values'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'comparing' stamp: 'ARS 4/22/2019 13:56:43'!
isEmpty
	
	^values last isEmpty! !

!OOStack methodsFor: 'comparing' stamp: 'ARS 4/22/2019 14:00:43'!
size
	
	^values size - 1! !


!OOStack methodsFor: 'accessing' stamp: 'ARS 4/22/2019 13:44:54'!
pop
	
	^values last removeFrom: self! !

!OOStack methodsFor: 'accessing' stamp: 'ARS 4/22/2019 13:41:52'!
push: anObject

	values add: (OOStackElement with: anObject)! !

!OOStack methodsFor: 'accessing' stamp: 'ARS 4/22/2019 13:59:07'!
top
	
	^values last top: self! !


!OOStack methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:40:53'!
initialize

	values := OrderedCollection with: OOStackBase new! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:51:48'!
removeLast

	^values removeLast value
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:47:39'!
stackEmpty
	
	^self error: self class stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
Object subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:57:00'!
isEmpty

	^true! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:47:25'!
removeFrom: stack

	^stack stackEmpty! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:59:27'!
top: stack

	^stack stackEmpty! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:32:00'!
initializeWith: anObject

	value := anObject! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:57:18'!
isEmpty

	^false! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:51:57'!
removeFrom: stack

	^stack removeLast
! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:59:55'!
top: stack

	^value
! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:35:25'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: #'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 13:53:42'!
with: anObject

	^self new
		initializeWith: anObject;
		yourself! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ARS 4/22/2019 14:15:30'!
initializeWith: anOOStack 

	stack := anOOStack! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'ARS 4/22/2019 15:04:41'!
find: prefix 
	
	| finderStack matchs token |
	
	prefix isEmpty ifTrue: [^self error: self class prefixEmptyErrorDescription].
	matchs := OrderedCollection new.
	finderStack := OOStack new.
	token := prefix, '*'.
	[stack isEmpty] whileFalse: [ | element |
		element :=  stack pop.
		matchs add: element.
		finderStack push: element ].
	[finderStack isEmpty] whileFalse: [stack push: finderStack pop].
	^matchs select: [:element | (token match: element) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ARS 4/15/2019 21:30:00'!
stack: anOOStack prefix: aCollection

	^self new 
		initializeStack: anOOStack prefix: aCollection;
		yourself! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'ARS 4/22/2019 14:14:53'!
with: anOOStack 
	
		^self new 
		initializeWith: anOOStack ;
		yourself! !


!SentenceFinderByPrefix class methodsFor: 'accessing' stamp: 'ARS 4/22/2019 15:05:14'!
prefixEmptyErrorDescription
	
	^'El prefijo no puede ser vacio'! !
