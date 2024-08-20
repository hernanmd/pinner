"
This is the main Pinner Spec2 application class which:

•	Contains a *collector*: An object that represents a repository of *visited objects*.
•	Handles the application start up. See the `PinnerSpApplication >> #start` method.
•	Creates a new entry for this application in the World menu.
"
Class {
	#name : 'PinnerSpApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'collector'
	],
	#classInstVars : [
		'collectorClass'
	],
	#category : 'Pinner-UI-Core',
	#package : 'Pinner-UI',
	#tag : 'Core'
}

{ #category : 'accessing' }
PinnerSpApplication class >> collectorClass [
	"Answer a <PinnerCollector>"

	^ collectorClass
		ifNil: [ collectorClass := self defaultCollectorClass ]
]

{ #category : 'accessing' }
PinnerSpApplication class >> collectorClass: anObject [

	collectorClass := anObject
]

{ #category : 'accessing' }
PinnerSpApplication class >> defaultCollectorClass [

	^ self environment
		at: #PinnerCollector
		ifAbsent: [ self error: 'Default history collector not available' ]
]

{ #category : 'private' }
PinnerSpApplication class >> iconNamed: aSymbol [

	^ PinnerIcons new
		iconNamed: aSymbol
		ifAbsent: [ super iconNamed: #info  ]
]

{ #category : 'private' }
PinnerSpApplication class >> menuPinnerOn: aBuilder [
	<worldMenu>

	(aBuilder item: #Pinner)
		parent: #Tools;
		label: 'Pinner';
		icon: (self iconNamed: #browsing_16x16Icon);
		action: [ PinnerSpApplication startApplication ];
		help: 'Pinner';
		order: 628
]

{ #category : 'accessing' }
PinnerSpApplication class >> startApplication [
	<script>

	PinnerSpApplication new
		collector: self collectorClass uniqueInstance;
		start
]

{ #category : 'accessing' }
PinnerSpApplication >> collector [
	^ collector
]

{ #category : 'accessing' }
PinnerSpApplication >> collector: aPinnerCollector [

	collector := aPinnerCollector
]

{ #category : 'running' }
PinnerSpApplication >> start [
	" Private - See superimplementor's comment "

	| newPresenter |
	newPresenter := PinnerSpMainPresenter newApplication: self model: self collector.
	"self flag: #toDo"
	self collector presenter: newPresenter.
	newPresenter open
]
