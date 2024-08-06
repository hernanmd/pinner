"
Command to clean all saved history in the Pinner.
"
Class {
	#name : 'PinnerResetHistoryCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerResetHistoryCommand class >> defaultDescription [

	^ 'Clean the visit history'
]

{ #category : 'initialization' }
PinnerResetHistoryCommand class >> defaultIconName [

	^ #back
]

{ #category : 'default' }
PinnerResetHistoryCommand class >> defaultName [

	^ 'Reset all history'
]

{ #category : 'executing' }
PinnerResetHistoryCommand >> execute [

	(self confirm: 'Are you sure to remove all pinned history?')
		ifTrue: [ self context doResetHistory ]
]
