"
Command to inspect a selected class in the Pinner UI
"
Class {
	#name : 'PinnerInspectClassCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerInspectClassCommand class >> defaultDescription [

	^ 'Inspect the selected class'
]

{ #category : 'initialization' }
PinnerInspectClassCommand class >> defaultIconName [

	^ #smallInspectIt
]

{ #category : 'default' }
PinnerInspectClassCommand class >> defaultName [

	^ 'Inspect selected class'
]

{ #category : 'executing' }
PinnerInspectClassCommand >> execute [

	self context selectedClass inspect
]
