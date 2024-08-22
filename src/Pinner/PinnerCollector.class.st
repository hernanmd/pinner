"
Abstract class to hold browsing history behavior, regardless of specific browser implementation. The main method is `history` which retrieves the `Collection` of the browser history it holds.

It contains: 
- A reference to a browser.
- A `Collection` of 
  - Packages: instances of `Package`,
  - Package tags: instances of `PackageTag`,
  - Classes: instances of `Class`,
  - And methods: instances of `CompiledMethod`

"
Class {
	#name : 'PinnerCollector',
	#superclass : 'Object',
	#instVars : [
		'browser',
		'presenter'
	],
	#classVars : [
		'PinnedObjects',
		'UniqueInstance'
	],
	#category : 'Pinner-Core',
	#package : 'Pinner',
	#tag : 'Core'
}

{ #category : 'accessing' }
PinnerCollector class >> collectionClass [

	^ Bag
]

{ #category : 'class initialization' }
PinnerCollector class >> createInstance [

	^ self basicNew
]

{ #category : 'instance creation' }
PinnerCollector class >> new [

	^ self error: 'This is a singleton implementation, so you are not allowed to create instances yourself. 
Use #uniqueInstance to access the instance.'
]

{ #category : 'accessing' }
PinnerCollector class >> pinnedObjects [

	^ PinnedObjects
		ifNil: [ PinnedObjects := self collectionClass new ]
]

{ #category : 'accessing' }
PinnerCollector class >> pinnedObjects: aCollection [

	 PinnedObjects := aCollection
]

{ #category : 'class initialization' }
PinnerCollector class >> reset [ 
	<script>

	self pinnedObjects: nil.
]

{ #category : 'class initialization' }
PinnerCollector class >> uniqueInstance [

	^ UniqueInstance 
		ifNil: [ UniqueInstance := self createInstance ]
]

{ #category : 'accessing' }
PinnerCollector >> browser [

	^ browser
]

{ #category : 'accessing' }
PinnerCollector >> browser: anObject [

	browser := anObject
]

{ #category : 'accessing' }
PinnerCollector >> classes [
	"Answer a <Collection> of <PinnedObject> representing recently visited classes"

	^ self pinnedObjects select: [ : obj | obj isClass ]
]

{ #category : 'requirements' }
PinnerCollector >> collectionClass [
	"See class side comment"

	^ self class collectionClass
]

{ #category : 'testing' }
PinnerCollector >> hasPinnedHistory [
	"Answer <true> if the receiver contains any history recorded"
	
	^ self pinnedObjects notEmpty

	
]

{ #category : 'accessing' }
PinnerCollector >> methods [
	"Answer a <Collection> of <PinnedObject> recently visited methods"

	^ self pinnedObjects select: [ : obj | obj isMethod ]
]

{ #category : 'accessing' }
PinnerCollector >> packageTags [
	"Answer a <Collection> of <PinnedObject> representing representing recently visited package tags"

	^ self pinnedObjects select: [ : obj | obj class == PackageTag ]
]

{ #category : 'accessing' }
PinnerCollector >> packages [
	"Answer a <Collection> of <PinnedObject> representing recently visited packages"

	^ self pinnedObjects select: [ : obj | obj isPackage ]
]

{ #category : 'adding' }
PinnerCollector >> pinObjects: aCollection [
	"Add visited Smalltalk objects in aCollection to the receiver"

	self pinnedObjects addAll: (self safePinningOf: aCollection)
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects [

	^ self class pinnedObjects
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects: aCollection [

	self class pinnedObjects: aCollection
]

{ #category : 'accessing' }
PinnerCollector >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PinnerCollector >> presenter: aPinnerSpMainPresenter [ 
	presenter := aPinnerSpMainPresenter
]

{ #category : 'removing' }
PinnerCollector >> resetClassesHistory [ 
	"Remove all pinned classes in the receiver"
	
	self pinnedObjects: (self pinnedObjects removeAll: self classes) 
]

{ #category : 'removing' }
PinnerCollector >> resetHistory [ 
	"Remove all pinned objects in the receiver"
	
	self class reset.
]

{ #category : 'removing' }
PinnerCollector >> resetMethodsHistory [ 
	"Remove all pinned methods in the receiver"
	
	self pinnedObjects: (self pinnedObjects removeAll: self methods) 

]

{ #category : 'removing' }
PinnerCollector >> resetPackagesHistory [ 
	"Remove all pinned packages in the receiver"
	
	self pinnedObjects: (self pinnedObjects removeAll: self packages) 
]

{ #category : 'private' }
PinnerCollector >> safePinningOf: aCollection [ 
	"Answer objects 'safe' to be pinned, i.e. discard obsolete classes"
	
	^ (aCollection 
		reject: [ : stObject | stObject isClass and: [ stObject isObsolete ] ]
		thenCollect: [ : stObject | PinnedObject on: stObject ])
]

{ #category : 'actions' }
PinnerCollector >> updatePresenter [

	presenter ifNotNil: [ : p |
		p
			updatePackages: self packages;
			updateClasses: self classes;
			updateMethods: self methods ]
]
