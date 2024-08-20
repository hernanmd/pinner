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
	self class = aPinnedObject class
		ifFalse: [ ^ false ].
	self referenceClass = aPinnedObject referenceClass
		ifFalse: [ ^ false ].
	^ self referenceName = aPinnedObject referenceName

]

{ #category : 'accessing' }
PinnedObject >> classes [
	"If the receiver represents a <Package>, answer a <Collection> of contained classes"
	
	^ self reference classes
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
PinnedObject >> methods [
	"The reference is a <Class>. Answer a <Collection> of reference contained methods"

	^ self reference methods 
]

{ #category : 'comparing' }
PinnedObject >> name [

	^ self reference name
]

{ #category : 'accessing' }
PinnedObject >> package [
	"Answer the receiver's reference <Package>"
	
	^ self reference package
]

{ #category : 'printing' }
PinnedObject >> printOn: aStream [

	super printOn: aStream.
	aStream 
		space;
		<< '[';
		<< self referenceType;
		<< ']'
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
PinnedObject >> referenceType [

	^ self isClass
		ifTrue: [ 'class' ]
		ifFalse: [ 
			self isPackage
				ifTrue: [ 'package' ]
				ifFalse: [ 'method'] ]
]

{ #category : 'accessing' }
PinnedObject >> selector [
	"Reference is a <CompiledMethod>. Answer a <Symbol> representing its selector"
	
	^ self reference selector
]

{ #category : 'accessing' }
PinnedObject >> startTime [

	^ startTime
]

{ #category : 'accessing' }
PinnedObject >> startTime: anObject [

	startTime := anObject
]
