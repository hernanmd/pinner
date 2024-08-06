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

{ #category : 'accessing' }
PinnedObject >> reference [

	^ reference
]

{ #category : 'accessing' }
PinnedObject >> reference: anObject [

	reference := anObject
]

{ #category : 'accessing' }
PinnedObject >> startTime [

	^ startTime
]

{ #category : 'accessing' }
PinnedObject >> startTime: anObject [

	startTime := anObject
]
