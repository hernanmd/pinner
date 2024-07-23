Class {
	#name : 'PinnerBrowseItemCommand',
	#superclass : 'CmCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerBrowseItemCommand class >> defaultDescription [

	^ 'Browse the selected item'
]

{ #category : 'default' }
PinnerBrowseItemCommand class >> defaultIconName [

	^ #smallHierarchyBrowser 
]

{ #category : 'default' }
PinnerBrowseItemCommand class >> defaultName [

	^ 'Browse'
]

{ #category : 'default' }
PinnerBrowseItemCommand class >> order [

	^ 0
]
