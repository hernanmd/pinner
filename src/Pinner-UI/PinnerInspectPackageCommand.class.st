"
Command to inspect a selected class in the Pinner UI
"
Class {
	#name : 'PinnerInspectPackageCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerInspectPackageCommand class >> defaultDescription [

	^ 'Inspect the selected package'
]

{ #category : 'initialization' }
PinnerInspectPackageCommand class >> defaultIconName [

	^ #smallInspectIt
]

{ #category : 'default' }
PinnerInspectPackageCommand class >> defaultName [

	^ 'Inspect selected package'
]

{ #category : 'executing' }
PinnerInspectPackageCommand >> execute [

	self context selectedPackage inspect
]
