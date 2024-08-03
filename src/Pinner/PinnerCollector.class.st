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
		'browser'
	],
	#category : 'Pinner-Core',
	#package : 'Pinner',
	#tag : 'Core'
}

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

	^ (self history select: [ : obj | obj isClass ]) asOrderedSet
]

{ #category : 'accessing' }
PinnerCollector >> history [

	self subclassResponsibility
]

{ #category : 'accessing' }
PinnerCollector >> methods [
	"Answer a <Collection> of recently visited methods"

	^ (self history select: [ : obj | obj isCompiledMethod ]) asOrderedSet
]

{ #category : 'accessing' }
PinnerCollector >> packageTags [
	"Answer a <Collection> of recently visited packages"

	^ (self history select: [ : obj | obj class == PackageTag ]) asOrderedSet
]

{ #category : 'accessing' }
PinnerCollector >> packages [
	"Answer a <Collection> of recently visited packages"

	^ (self history select: [ : obj | obj isPackage ]) asOrderedSet
]
