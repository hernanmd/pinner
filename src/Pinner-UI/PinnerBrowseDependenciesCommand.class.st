"
Command to open a Dependency Browser on the selected package
"
Class {
	#name : 'PinnerBrowseDependenciesCommand',
	#superclass : 'PinnerPackageBrowseCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerBrowseDependenciesCommand class >> defaultDescription [

	^ 'Browse the selected package dependencies'
]

{ #category : 'default' }
PinnerBrowseDependenciesCommand class >> defaultName [

	^ 'Browse dependencies'
]

{ #category : 'accessing' }
PinnerBrowseDependenciesCommand class >> order [

	^ 2
]

{ #category : 'executing' }
PinnerBrowseDependenciesCommand >> execute [

	self context doBrowsePackageDependencies
]
