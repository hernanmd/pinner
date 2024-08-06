"
Provides a Spec presenter with three browsing history lists:

- Packages
- Classes
- Methods

When a package is selected, all visited classes that belong to the selected package are displayed. Similarily, when a class is selected, all visited methods that belong to the selected class are displayed.

"
Class {
	#name : 'PinnerSpMainPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'packagesListPresenter',
		'classesListPresenter',
		'methodsListPresenter',
		'collector',
		'oldSelectedPackage'
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

{ #category : 'actions' }
PinnerSpMainPresenter >> doResetHistory [
	"Private - Remove all pinned objects in the receiver"

	self collector resetHistory.
	self
		updatePackages: self collector collectionClass empty;
		updateClasses: self collector collectionClass empty;
		updateMethods: self collector collectionClass empty
]

{ #category : 'testing' }
PinnerSpMainPresenter >> hasPinnedHistory [
	"Answer <true> if the receiver contains any history recorded"

	^ self collector hasPinnedHistory
]

{ #category : 'testing' }
PinnerSpMainPresenter >> hasSelectedPackage [

	^ packagesListPresenter selectedItem notNil
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
		initializeMethodsList;
		initializeClassesList;
		initializePackagesList;
		initializeTiling;
		initializeFocus
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeTiling [
	"Private - Try to tile the receiver if supported"

	self whenVisibleChangedDo: [ : this | .
		this widget tileRight ]
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Pinner';
		windowIcon: (self iconNamed: #history);
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

{ #category : 'showing' }
PinnerSpMainPresenter >> open [

	super open.
	self withWindowDo: [ : w |
		"Tiling should not change the configured width"
		w adapter widget width: 200 scaledByDisplayScaleFactor.
		w adapter widget tileRight; toggleStickiness ]
]

{ #category : 'private' }
PinnerSpMainPresenter >> packageActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'Browsing commands') asSpecGroup
			register: ((PinnerBrowseDependenciesCommand
				forSpecWithIconNamed: #smallHierarchyBrowser
				shortcutKey: 'D' asShortcut)
					context: self);
			register: ((PinnerBrowsePackageCommand
				forSpecWithIconNamed: #smallHierarchyBrowser
				shortcutKey: 'B' asShortcut)
					context: self);
			beDisplayedAsGroup;
			yourself);
		register: ((PinnerResetHistoryCommand
			forSpecWithIconNamed: #back
			shortcutKey: 'R' asShortcut)
				context: self);
		yourself
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> resetAllSelections [
	"Private - It seems to be a bug in Spec2 because list selection keeps selected regardless of sending:
	resetListSelection; refresh; updateList "

	packagesListPresenter items: self visitedPackages.
	classesListPresenter items: self visitedClasses.
	methodsListPresenter items: self visitedMethods
]

{ #category : 'accessing - model' }
PinnerSpMainPresenter >> setModelBeforeInitialization: aModel [

	collector := aModel
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateClasses: aCollection [

	classesListPresenter items: aCollection
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateClassesList: aPackageOrNil [
	"Private - Package selection callback to update class list with those classes that belongs to aPackageOrNil"

	aPackageOrNil
		ifNotNil: [ : package |
			"If selected item is the same as the one already selected, we unselect and clean selection"
			package = oldSelectedPackage
				ifTrue: [ self resetAllSelections ]
				ifFalse: [
					| filteredItems |
					filteredItems := package classes select: [ : c | self visitedClasses includes: c ].
					classesListPresenter items: filteredItems asOrderedSet.
					methodsListPresenter items: Array empty.
					oldSelectedPackage := package ] ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateMethods: aCollection [

	methodsListPresenter items: aCollection
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateMethodsList: aClassOrNil [
	"Private - Class selection callback to update methods list with those methods that belongs to aClassOrNil"

	aClassOrNil
		ifNotNil: [ : class |
			| filteredItems |.
			filteredItems := class methods select: [ : c | self visitedMethods includes: c ].
			methodsListPresenter items: filteredItems asOrderedSet ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updatePackages: aCollection [

	packagesListPresenter items: aCollection
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedClasses [

	^ self collector classes
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedMethods [

	^ self collector methods
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedPackages [
	"Answer a <Collection> of the visited packages in the system"

	^ self collector packages
]
