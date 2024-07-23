Class {
	#name : 'PinnerSpApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'collector'
	],
	#category : 'Pinner-UI-Core',
	#package : 'Pinner-UI',
	#tag : 'Core'
}

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
		collector: PinnerClyCollector new;
		start
]

{ #category : 'accessing' }
PinnerSpApplication >> collector [
	^ collector
]

{ #category : 'accessing' }
PinnerSpApplication >> collector: aPinnerClyCollector [ 

	collector := aPinnerClyCollector
]

{ #category : 'running' }
PinnerSpApplication >> start [
	" Private - See superimplementor's comment "

	(PinnerSpMainPresenter newApplication: self model: self collector) open.
]
