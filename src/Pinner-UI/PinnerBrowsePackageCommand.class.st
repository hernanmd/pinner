"
Command to open a Browser on the selected package
"
Class {
	#name : 'PinnerBrowsePackageCommand',
	#superclass : 'PinnerPackageBrowseCommand',
	#category : 'Pinner-UI-Commands',
	#package : 'Pinner-UI',
	#tag : 'Commands'
}

{ #category : 'default' }
PinnerBrowsePackageCommand class >> defaultDescription [

	^ 'Browse the selected item'
]

{ #category : 'default' }
PinnerBrowsePackageCommand class >> defaultIconName [

	^ #smallHierarchyBrowser
]

{ #category : 'default' }
PinnerBrowsePackageCommand class >> defaultName [

	^ 'Browse package'
]

{ #category : 'default' }
PinnerBrowsePackageCommand class >> order [

	^ 0
]

{ #category : 'executing' }
PinnerBrowsePackageCommand >> execute [

	self context doBrowsePackage
]
