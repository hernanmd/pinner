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
		'PinnedObjects'
	],
	#category : 'Pinner-Core',
	#package : 'Pinner',
	#tag : 'Core'
}

{ #category : 'accessing' }
PinnerCollector class >> collectionClass [

	^ Bag
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
	"Answer a <Collection> of recently visited classes"

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
	"Answer a <Collection> of recently visited methods"

	^ self pinnedObjects select: [ : obj | obj isCompiledMethod ]
]

{ #category : 'accessing' }
PinnerCollector >> packageTags [
	"Answer a <Collection> of recently visited packages"

	^ self pinnedObjects select: [ : obj | obj class == PackageTag ]
]

{ #category : 'accessing' }
PinnerCollector >> packages [
	"Answer a <Collection> of recently visited packages"

	^ self pinnedObjects select: [ : obj | obj isPackage ]
]

{ #category : 'adding' }
PinnerCollector >> pinObjects: aCollection [

	self pinnedObjects addAll: 
		(aCollection collect: [ : stObject | PinnedObject on: stObject ])
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects [

	^ self class pinnedObjects
]

{ #category : 'accessing' }
PinnerCollector >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PinnerCollector >> presenter: anObject [

	presenter := anObject
]

{ #category : 'removing' }
PinnerCollector >> resetHistory [ 
	"Remove all pinned objects in the receiver"
	
	self class reset.
]

{ #category : 'actions' }
PinnerCollector >> updatePresenter [

	presenter ifNotNil: [ : p |
		'updating...' traceCr.
		p
			updatePackages: self packages;
			updateClasses: self classes;
			updateMethods: self methods ]
]
