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

{ #category : 'class initialization' }
PinnerCollector class >> initialize [ 

	self pinnedObjects: nil.
]

{ #category : 'accessing' }
PinnerCollector class >> pinnedObjects [

	^ PinnedObjects
		ifNil: [ PinnedObjects := CTOrderedSet new ]
]

{ #category : 'accessing' }
PinnerCollector class >> pinnedObjects: aCollection [

	 PinnedObjects := aCollection
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

{ #category : 'initialization' }
PinnerCollector >> pinObjects: aCollection [

	self pinnedObjects addAll: aCollection
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects [

	^ self class pinnedObjects
]

{ #category : 'adding' }
PinnerCollector >> pinnedObjects: aCollection [ 

	self class pinnedObjects: aCollection
]

{ #category : 'accessing' }
PinnerCollector >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PinnerCollector >> presenter: anObject [

	presenter := anObject
]

{ #category : 'initialization' }
PinnerCollector >> updatePresenter [

	presenter
		updatePackages: self packages;
		updateClasses: self classes;
		updateMethods: self methods
]
