"
Command to clean all saved history in the Pinner.
"
Class {
	#name : 'PinnerResetMethodsHistoryCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerResetMethodsHistoryCommand class >> defaultDescription [

	^ 'Clean the visit methods history'
]

{ #category : 'initialization' }
PinnerResetMethodsHistoryCommand class >> defaultIconName [

	^ #back
]

{ #category : 'default' }
PinnerResetMethodsHistoryCommand class >> defaultName [

	^ 'Reset methods history'
]

{ #category : 'executing' }
PinnerResetMethodsHistoryCommand >> execute [

	(self confirm: 'Are you sure to remove all pinned methods history?')
		ifTrue: [ self context doResetMethodsHistory ]
]
