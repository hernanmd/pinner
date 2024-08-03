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
		at: #PinnerClyCollector
		ifAbsent: [ self error: 'Default history collector not available' ]
]

{ #category : 'private' }
PinnerSpApplication class >> menuPinnerOn: aBuilder [
	<worldMenu>

	(aBuilder item: #Pinner)
		parent: #Tools;
		label: 'Pinner';
		icon: (self iconNamed: #catalog);
		action: [ PinnerSpApplication startApplication ];
		help: 'Pinner';
		order: 628
]

{ #category : 'accessing' }
PinnerSpApplication class >> startApplication [
	<script>

	PinnerSpApplication new
		collector: self collectorClass new;
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

	(PinnerSpMainPresenter newApplication: self model: self collector) open
]
