"
A wrapper for Smalltalk commonly navigated objects in a Browser (packages, classes, methods).

"
Class {
	#name : 'PinnedObject',
	#superclass : 'Object',
	#instVars : [
		'startTime',
		'reference'
	],
	#category : 'Pinner-Core',
	#package : 'Pinner',
	#tag : 'Core'
}

{ #category : 'instance creation' }
PinnedObject class >> on: aSmalltalkObject [

	^ self new
		reference: aSmalltalkObject;
		yourself.
]

{ #category : 'comparing' }
PinnedObject >> = aPinnedObject [

	self == aPinnedObject 
		ifTrue: [ ^ true ].
	self referenceClass = aPinnedObject referenceClass
		ifFalse: [ ^ false ].
	^ self referenceName = aPinnedObject referenceName

]

{ #category : 'comparing' }
PinnedObject >> hash [

	^ self reference hash
]

{ #category : 'testing' }
PinnedObject >> isClass [

	^ self reference isClass
]

{ #category : 'testing' }
PinnedObject >> isMethod [

	^ self reference isCompiledMethod
]

{ #category : 'testing' }
PinnedObject >> isPackage [

	^ self reference isPackage
]

{ #category : 'accessing' }
PinnedObject >> reference [

	^ reference
]

{ #category : 'accessing' }
PinnedObject >> reference: anObject [

	reference := anObject
]

{ #category : 'accessing' }
PinnedObject >> referenceClass [

	^ self reference class
]

{ #category : 'accessing' }
PinnedObject >> referenceName [
	"Answer a <String> representation of the receiver"
	
	^ self reference name
]

{ #category : 'accessing' }
PinnedObject >> startTime [

	^ startTime
]

{ #category : 'accessing' }
PinnedObject >> startTime: anObject [

	startTime := anObject
]
