"
Provides a Spec presenter window with three browsing history lists:

- Packages
- Classes
- Methods

It also provides callback methods for actions on each selected item.
"
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
		register: (SpBrowseClassCommand forSpecContext: self);
		register: (SpBrowseClassHierarchyCommand forSpecContext: self);
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

{ #category : 'private' }
PinnerSpMainPresenter >> displayCompiledMethod: cm [

	^ String streamContents: [ : stream |
		stream
			<< cm methodClass asString;
			<< '>>';
			<< cm selector ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseClass [

	self systemNavigation browse: classesListPresenter selectedItem
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseClassReferences [

	| result classOrTrait |

	result := classesListPresenter selectedItem.
	(result isClass or: [ result isTrait ])
		ifFalse: [ result := result class ].

	classOrTrait := result instanceSide.
	classOrTrait isTrait
		ifTrue: [ self systemNavigation browseAllUsersOfTrait: classOrTrait ]
		ifFalse: [ self systemNavigation browseAllCallsOnClass: classOrTrait ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseHierarchy [

	self systemNavigation browseHierarchy: classesListPresenter selectedItem
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseImplementors [

	self systemNavigation browseAllImplementorsOf: methodsListPresenter selectedItem selector
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseMethodReferences [

	self systemNavigation browseAllSendersOrUsersOf: methodsListPresenter selectedItem selector
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowsePackage [

	self systemNavigation browse: packagesListPresenter selectedItem
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowsePackageDependencies [

	| analyzedPackage presenter |
	analyzedPackage := DADependencyChecker new daPackageFor: packagesListPresenter selectedItem name.
	presenter := DATabPackageDependenciesPresenter on: analyzedPackage.
	presenter open.
	presenter withWindowDo: [ : w | w title: 'Package Dependencies' ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseSenders [

	self systemNavigation browseAllSendersOf: methodsListPresenter selectedItem selector
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeClassesList [

	classesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Classes';
		displayIcon: [ : cls | self iconNamed: cls systemIconName ];
		contextMenu: [ self classActions asMenuPresenter ];
		whenSelectedItemChangedDo: [ : class | self updateMethodsList: class ];
		"contextKeyBindings: self contextMenuKeyBindings;"
		items: self collector classes;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeFocus [

	self focusOrder
		add: packagesListPresenter;
		add: classesListPresenter;
		add: methodsListPresenter
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeMethodsList [

	methodsListPresenter := self newList
		beSingleSelection;
		display: [ : cm | self displayCompiledMethod: cm  ];
		displayIcon: [ : cm | self iconNamed: cm systemIconName ];
		contextMenu: [ self methodActions asMenuPresenter ];
		"contextKeyBindings: self contextMenuKeyBindings;"
		headerTitle: 'Methods';
		items: self collector methods;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePackagesList [

	packagesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Packages';
		display: [ : pkg | pkg name ];
		displayIcon: [ : pkg | self iconNamed: #package ];
		contextMenu: [ self packageActions asMenuPresenter ];
		"contextKeyBindings: self contextMenuKeyBindings;"
		whenSelectedItemChangedDo: [ : package | self updateClassesList: package ];
		items: self collector packages;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePresenters [

	self
		initializePackagesList;
		initializeClassesList;
		initializeMethodsList;
		initializeFocus
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
		register: (SpBrowseMethodReferencesCommand forSpecContext: self);
		register: (SpBrowseImplementorsCommand forSpecContext: self);
		register: (SpBrowseSendersCommand forSpecContext: self);
		yourself
]

{ #category : 'private' }
PinnerSpMainPresenter >> packageActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: (PinnerBrowsePackageCommand forSpecContext: self);
		register: (PinnerBrowseDependenciesCommand forSpecContext: self);
		yourself
]

{ #category : 'accessing - model' }
PinnerSpMainPresenter >> setModelBeforeInitialization: aModel [

	collector := aModel
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateClassesList: aPackageOrNil [
	"Private - Callback to package selection"

	aPackageOrNil
		ifNotNil: [ : package | classesListPresenter items: (package classes difference: Set empty)  ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateMethodsList: aClassOrNil [
	"Private - Callback to class selection"

	aClassOrNil
		ifNotNil: [ : class | methodsListPresenter items: (class methods difference: Set empty)  ]
]
