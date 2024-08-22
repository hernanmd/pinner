"
Command to inspect a selected class in the Pinner UI
"
Class {
	#name : 'PinnerInspectMethodCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerInspectMethodCommand class >> defaultDescription [

	^ 'Inspect the selected method'
]

{ #category : 'initialization' }
PinnerInspectMethodCommand class >> defaultIconName [

	^ #smallInspectIt
]

{ #category : 'default' }
PinnerInspectMethodCommand class >> defaultName [

	^ 'Inspect selected method'
]

{ #category : 'executing' }
PinnerInspectMethodCommand >> execute [

	self context selectedMethod inspect
]
