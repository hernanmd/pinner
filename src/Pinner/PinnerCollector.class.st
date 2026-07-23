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
		'PinnedClasses',
		'PinnedMethods',
		'PinnedPackageTags',
		'PinnedPackages',
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
	^ self uniqueInstance pinnedObjects
]

{ #category : 'accessing' }
PinnerCollector class >> pinnedObjects: aCollection [
	self uniqueInstance pinnedObjects: aCollection
]

{ #category : 'accessing' }
PinnerCollector class >> reset [
	<script>
	PinnedClasses := nil.
	PinnedMethods := nil.
	PinnedPackages := nil.
	PinnedPackageTags := nil
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
	"Answer a <Bag> of <String> representing recently visited classes"
	^ self pinnedClasses
]

{ #category : 'requirements' }
PinnerCollector >> collectionClass [
	"See class side comment"

	^ self class collectionClass
]

{ #category : 'testing' }
PinnerCollector >> hasPinnedHistory [
	"Answer <true> if the receiver contains any history recorded"
	^ self pinnedClasses notEmpty
		or: [ self pinnedMethods notEmpty
			or: [ self pinnedPackages notEmpty
				or: [ self pinnedPackageTags notEmpty ] ] ]
]

{ #category : 'accessing' }
PinnerCollector >> methods [
	"Answer a <Bag> of <String> recently visited methods"
	^ self pinnedMethods
]

{ #category : 'accessing' }
PinnerCollector >> packageTags [
	"Answer a <Bag> of <String> representing recently visited package tags"
	^ self pinnedPackageTags
]

{ #category : 'accessing' }
PinnerCollector >> packages [
	"Answer a <Bag> of <String> representing recently visited packages"
	^ self pinnedPackages
]

{ #category : 'private' }
PinnerCollector >> pinObject: stObject [
	"Private - Store the String representation of stObject in the matching history bag."
	stObject isCompiledMethod
		ifTrue: [ ^ self pinnedMethods add: (self stringForMethod: stObject) ].
	stObject isClass
		ifTrue: [
			stObject isObsolete
				ifFalse: [ self pinnedClasses add: (self stringForClass: stObject) ].
			^ self ].
	stObject isPackage
		ifTrue: [ ^ self pinnedPackages add: (self stringForPackage: stObject) ].
	stObject class == PackageTag
		ifTrue: [ ^ self pinnedPackageTags add: (self stringForPackageTag: stObject) ]
]

{ #category : 'pinning' }
PinnerCollector >> pinObjects: aCollection [
	"Add visited Smalltalk objects to the receiver, storing their String representation (class name or Class>>#selector)."
	aCollection do: [ :stObject | self pinObject: stObject ]
]

{ #category : 'accessing' }
PinnerCollector >> pinnedClasses [
	^ PinnedClasses ifNil: [ PinnedClasses := self collectionClass new ]
]

{ #category : 'accessing' }
PinnerCollector >> pinnedMethods [
	^ PinnedMethods ifNil: [ PinnedMethods := self collectionClass new ]
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects [
	"Answer a combined <Bag> of all pinned String representations (for history checks)."
	^ Bag new
		addAll: self pinnedClasses;
		addAll: self pinnedMethods;
		addAll: self pinnedPackages;
		addAll: self pinnedPackageTags;
		yourself
]

{ #category : 'accessing' }
PinnerCollector >> pinnedObjects: aCollection [
	"Compatibility setter: reset all history."
	self reset
]

{ #category : 'accessing' }
PinnerCollector >> pinnedPackageTags [
	^ PinnedPackageTags ifNil: [ PinnedPackageTags := self collectionClass new ]
]

{ #category : 'accessing' }
PinnerCollector >> pinnedPackages [
	^ PinnedPackages ifNil: [ PinnedPackages := self collectionClass new ]
]

{ #category : 'accessing' }
PinnerCollector >> presenter [

	^ presenter
]

{ #category : 'accessing' }
PinnerCollector >> presenter: aPinnerSpMainPresenter [ 
	presenter := aPinnerSpMainPresenter
]

{ #category : 'accessing' }
PinnerCollector >> reset [
	<script>
	PinnedClasses := nil.
	PinnedMethods := nil.
	PinnedPackages := nil.
	PinnedPackageTags := nil
]

{ #category : 'accessing' }
PinnerCollector >> resetClassesHistory [
	"Remove all pinned classes in the receiver"
	PinnedClasses := nil
]

{ #category : 'accessing' }
PinnerCollector >> resetHistory [
	"Remove all pinned objects in the receiver"
	self reset
]

{ #category : 'accessing' }
PinnerCollector >> resetMethodsHistory [
	"Remove all pinned methods in the receiver"
	PinnedMethods := nil
]

{ #category : 'accessing' }
PinnerCollector >> resetPackagesHistory [
	"Remove all pinned packages in the receiver"
	PinnedPackages := nil
]

{ #category : 'private' }
PinnerCollector >> safePinningOf: aCollection [ 
	"Answer objects 'safe' to be pinned, i.e. discard obsolete classes"
	
	^ (aCollection 
		reject: [ : stObject | stObject isClass and: [ stObject isObsolete ] ]
		thenCollect: [ : stObject | PinnedObject on: stObject ])
]

{ #category : 'private' }
PinnerCollector >> stringForClass: aClass [
	"Answer the <String> representation of aClass"
	^ aClass name asString
]

{ #category : 'private' }
PinnerCollector >> stringForMethod: aCompiledMethod [
	"Answer the <String> representation of aCompiledMethod as 'ClassName>>#selector'"
	^ aCompiledMethod methodClass name asString , '>>#' , aCompiledMethod selector asString
]

{ #category : 'private' }
PinnerCollector >> stringForPackage: aPackage [
	"Answer the <String> representation of aPackage"
	^ aPackage name asString
]

{ #category : 'private' }
PinnerCollector >> stringForPackageTag: aPackageTag [
	"Answer the <String> representation of aPackageTag"
	^ aPackageTag name asString
]

{ #category : 'actions' }
PinnerCollector >> updatePresenter [

	presenter ifNotNil: [ : p |
		p
			updatePackages: self packages;
			updateClasses: self classes;
			updateMethods: self methods ]
]
