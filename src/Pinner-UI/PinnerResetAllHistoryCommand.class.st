"
Command to clean all saved history in the Pinner.
"
Class {
	#name : 'PinnerResetAllHistoryCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerResetAllHistoryCommand class >> defaultDescription [

	^ 'Clean the visit history'
]

{ #category : 'initialization' }
PinnerResetAllHistoryCommand class >> defaultIconName [

	^ #back
]

{ #category : 'default' }
PinnerResetAllHistoryCommand class >> defaultName [

	^ 'Reset all history'
]

{ #category : 'executing' }
PinnerResetAllHistoryCommand >> execute [

	(self confirm: 'Are you sure to remove all pinned history?')
		ifTrue: [ self context doResetAllHistory ]
]
