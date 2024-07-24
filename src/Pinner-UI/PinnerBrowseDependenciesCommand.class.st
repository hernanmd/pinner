Class {
	#name : 'PinnerBrowseDependenciesCommand',
	#superclass : 'CmCommand',
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