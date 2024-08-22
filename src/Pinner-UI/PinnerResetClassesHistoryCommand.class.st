"
Command to clean all saved history in the Pinner.
"
Class {
	#name : 'PinnerResetClassesHistoryCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerResetClassesHistoryCommand class >> defaultDescription [

	^ 'Clean the visit classes history'
]

{ #category : 'initialization' }
PinnerResetClassesHistoryCommand class >> defaultIconName [

	^ #back
]

{ #category : 'default' }
PinnerResetClassesHistoryCommand class >> defaultName [

	^ 'Reset classes history'
]

{ #category : 'executing' }
PinnerResetClassesHistoryCommand >> execute [

	(self confirm: 'Are you sure to remove all pinned classes history?')
		ifTrue: [ self context doResetClassesHistory ]
]
