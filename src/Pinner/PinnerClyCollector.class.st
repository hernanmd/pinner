"
Provides a collector to query the visited classes using the Claypso tool.

## Example

```
PinnerClyClassCollector new collect.
``` 

"
Class {
	#name : 'PinnerClyCollector',
	#superclass : 'PinnerCollector',
	#category : 'Pinner-Calypso',
	#package : 'Pinner',
	#tag : 'Calypso'
}

{ #category : 'examples' }
PinnerClyCollector class >> exampleClasses [

	self new classes inspect
]

{ #category : 'examples' }
PinnerClyCollector class >> examplePackages [

	self new packages inspect
]

{ #category : 'accessing' }
PinnerClyCollector >> browsingHistory [
	"If we have a browser attached, then answer a <Collection> of its browsing history <ClyNavigationHistory> instances, otherwise answer all current history instances"

	^ self browser
		ifNil: [ ClyNavigationHistory allInstances ]
		ifNotNil: [ : b | { b navigationHistory } ]
]

{ #category : 'accessing' }
PinnerClyCollector >> history [
	"Answer a <Collection> of objects stored in the receiver's history. Note that in Calypso, the current selection IS NOT part of the history"

	| selectedViewStates |

	selectedViewStates := self browsingHistory flatCollect: [ : aClyNavHistory |
			aClyNavHistory undoList collect: [ : fullBrowserState |
				| realBrowserState |
				realBrowserState := (fullBrowserState isKindOf: ClyAccrossWindowNavigationState)
					ifTrue: [ fullBrowserState browserState ]
					ifFalse: [ fullBrowserState ].
				realBrowserState viewStates
					select: [ : viewState | viewState selection hasSelectedItems ] ] ].

	^ (selectedViewStates select: #notEmpty) flattened collect: [ : queryState | queryState selection actualObjects anyOne ]
]
