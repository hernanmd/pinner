"
Provides a collector to query the visited classes using the Claypso tool.

## Example

```
PinnerClyClassCollector new collect.
``` 

"
Class {
	#name : 'PinnerClyCollector',
	#superclass : 'Object',
	#category : 'Pinner-Collector',
	#package : 'Pinner',
	#tag : 'Collector'
}

{ #category : 'examples' }
PinnerClyCollector class >> exampleClasses [

	self new collectClasses inspect
]

{ #category : 'examples' }
PinnerClyCollector class >> examplePackages [

	self new collectPackages inspect
]

{ #category : 'accessing' }
PinnerClyCollector >> collectAll [
	"Answer a <Collection> of recently visited classes"
	
	^ self flattenedHistory collect: #selection

]

{ #category : 'accessing' }
PinnerClyCollector >> collectClasses [
	"Answer a <Collection> of recently visited classes"
	
	^ (self flattenedHistory select: [ : obj | obj isClass ]) asSet

]

{ #category : 'accessing' }
PinnerClyCollector >> collectMethods [
	"Answer a <Collection> of recently visited methods"
	
	^ (self flattenedHistory select: [ : obj | obj isCompiledMethod ]) asSet

]

{ #category : 'accessing' }
PinnerClyCollector >> collectPackages [
	"Answer a <Collection> of recently visited packages"
	
	^ (self flattenedHistory select: [ : obj | obj isPackage ]) asSet

]

{ #category : 'accessing' }
PinnerClyCollector >> flattenedHistory [

	^ ((ClyNavigationHistory allInstances 
		flatCollect: [ : nh |
			nh undoList collect: [ : fullBrowserState |
				fullBrowserState viewStates 
					select: [ : viewState | viewState selection hasSelectedItems ] ] ])
						select: #notEmpty) flattened
							collect: [ : queryState | queryState selection actualObjects anyOne ]
]
