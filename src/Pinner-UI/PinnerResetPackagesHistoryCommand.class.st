"
Command to clean all saved history in the Pinner.
"
Class {
	#name : 'PinnerResetPackagesHistoryCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerResetPackagesHistoryCommand class >> defaultDescription [

	^ 'Clean the visit packages history'
]

{ #category : 'initialization' }
PinnerResetPackagesHistoryCommand class >> defaultIconName [

	^ #back
]

{ #category : 'default' }
PinnerResetPackagesHistoryCommand class >> defaultName [

	^ 'Reset packages history'
]

{ #category : 'executing' }
PinnerResetPackagesHistoryCommand >> execute [

	(self confirm: 'Are you sure to remove all pinned packages history?')
		ifTrue: [ self context doResetPackagesHistory ]
]
