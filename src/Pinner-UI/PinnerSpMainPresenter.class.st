Class {
	#name : 'PinnerSpMainPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'packagesListPresenter',
		'classesListPresenter',
		'methodsListPresenter',
		'collector'
	],
	#category : 'Pinner-UI-Core',
	#package : 'Pinner-UI',
	#tag : 'Core'
}

{ #category : 'private' }
PinnerSpMainPresenter >> classActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (PinnerBrowseItemCommand forSpecContext: self);
		register: (SpBrowseClassCommand forSpecContext: self);
		register: (SpBrowseClassReferencesCommand forSpecContext: self);
		yourself
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> collector [

	^ collector
]

{ #category : 'layout' }
PinnerSpMainPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: packagesListPresenter;
		add: classesListPresenter;
		add: methodsListPresenter;
		yourself
]

{ #category : 'layout' }
PinnerSpMainPresenter >> displayCompiledMethod: cm [

	^ String streamContents: [ : stream |
		stream 
			<< cm methodClass asString;
			<< '>>';
			<< cm selector ]
]

{ #category : 'layout' }
PinnerSpMainPresenter >> initializeFocus [

	self focusOrder
		add: packagesListPresenter;
		add: classesListPresenter;
		add: methodsListPresenter.
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePresenters [

	packagesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Packages';
		display: [ : pkg | pkg name ];
		displayIcon: [ : pkg | self iconNamed: #package ];
		contextMenu: [ self packageActions asMenuPresenter ];
		items: self collector packages;
		yourself.
	classesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Classes';
		displayIcon: [ : cls | self iconNamed: cls systemIconName ];
		contextMenu: [ self classActions asMenuPresenter ];
		items: self collector classes;
		yourself.
	methodsListPresenter := self newList
		beSingleSelection;
		display: [ : cm | self displayCompiledMethod: cm  ];
		displayIcon: [ : cm | self iconNamed: cm systemIconName ];
		contextMenu: [ self methodActions asMenuPresenter ];
		headerTitle: 'Methods';
		items: self collector methods;
		yourself.
	self initializeFocus.
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		title: 'Pinner';
		windowIcon: (self iconNamed: #history);
		initialExtent: (400 @ 600) scaledByDisplayScaleFactor;
		aboutText: 'Pinner: A recent browsing history viewer'
]

{ #category : 'private' }
PinnerSpMainPresenter >> methodActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (StPlaygroundAdoptVersionCommand forSpecContext: self);
		register: (StPlaygroundAdoptVersionOnNewPlaygroundCommand forSpecContext: self);
		yourself
]

{ #category : 'private' }
PinnerSpMainPresenter >> packageActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (PinnerBrowseItemCommand forSpecContext: self);
		register: (PinnerBrowseDependenciesCommand forSpecContext: self);
		yourself
]

{ #category : 'accessing - model' }
PinnerSpMainPresenter >> setModelBeforeInitialization: aModel [

	collector := aModel
]
