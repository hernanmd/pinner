"
Specializes Calypso navigation history to collect the visited items.
"
Class {
	#name : 'PinnerClyNavigationHistory',
	#superclass : 'ClyNavigationHistory',
	#category : 'Pinner-Calypso-NavigationHistory',
	#package : 'Pinner-Calypso',
	#tag : 'NavigationHistory'
}

{ #category : 'accessing' }
PinnerClyNavigationHistory >> historyCollector [

	^ PinnerSpApplication allInstances 
		ifNotEmpty: [ : spApp | spApp anyOne collector ]
		ifEmpty: [ " 'History collector not found' ." 
			nil ]
]

{ #category : 'operations' }
PinnerClyNavigationHistory >> historyFrom: aBrowserState [
	"Answer a <Collection> of objects stored in the receiver's history. Note that in Calypso, the current selection IS NOT part of the history"

	| selectedViewStates realBrowserState |

	realBrowserState := (aBrowserState isKindOf: ClyAccrossWindowNavigationState)
		ifTrue: [ aBrowserState browserState ]
		ifFalse: [ aBrowserState ].
	selectedViewStates := realBrowserState viewStates select: [ : viewState | viewState selection hasSelectedItems ].
	^ selectedViewStates flattened collect: [ : queryState | queryState selection actualObjects anyOne ]
]

{ #category : 'operations' }
PinnerClyNavigationHistory >> recordState: aBrowserState [
	"Private - It should be possible with something like:
		
		(aBrowserState systemScope environment queryCache associationsSelect: [ : q | q key class inheritsFrom: ClyTypedQuery ]) inspect.
		
	However it was difficult to debug, and for now we use a simpler implementation"

	aBrowserState representsConcreteQuery ifFalse: [ ^self ].
	waitingNewState ifFalse: [ ^self ].

	undoExecuting | redoExecuting ifTrue: [
		"During undo or redo system can trigger multiple navigation changes.
		waitingNewState flag here is to address this case. We need to track only first change"
		waitingNewState := false ].

	undoExecuting
		ifTrue: [ redoList add: aBrowserState ]
		ifFalse: [
			self updateHistory: (self historyFrom: aBrowserState).
			redoExecuting ifFalse: [ redoList removeAll].
			undoList add: aBrowserState ]
]

{ #category : 'operations' }
PinnerClyNavigationHistory >> updateHistory: aCollection [ 

	self historyCollector ifNotNil: [ : collector | 
		collector pinObjects: aCollection.
		collector updatePresenter ]. 

]
