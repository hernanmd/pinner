Class {
	#name : 'PinnerPackageBrowseCommand',
	#superclass : 'CmCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'testing' }
PinnerPackageBrowseCommand >> canBeExecuted [ 

	^ self context hasSelectedPackage
]
