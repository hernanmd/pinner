"
Abstract command behavior for operations in the Pinner UI
"
Class {
	#name : 'PinnerCommand',
	#superclass : 'CmCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'testing' }
PinnerCommand >> canBeExecuted [

	^ self context hasPinnedHistory
]
