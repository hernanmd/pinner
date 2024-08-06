"
Abstract class to group package behavior.

"
Class {
	#name : 'PinnerPackageBrowseCommand',
	#superclass : 'PinnerCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'as yet unclassified' }
PinnerPackageBrowseCommand class >> order [
	^ self subclassResponsibility
]

{ #category : 'testing' }
PinnerPackageBrowseCommand >> canBeExecuted [

	^ super canBeExecuted and: [ self context hasSelectedPackage ]
]
