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
PinnerSpMainPresenter >> classActionsCmdGroup [

	^ CmCommandGroup forSpec
		  beRoot;
		  register:
			  ((CmCommandGroup named: 'Browsing class commands') asSpecGroup
				   register: ((SpBrowseClassCommand forSpecContext: self)
						    name: 'Browse class';
						    shortcutKey: $B;
						    yourself);
				   register:
					   ((SpBrowseClassHierarchyCommand forSpecContext: self)
						    name: 'Browse class hierarchy';
						    shortcutKey: $H;
						    yourself);
				   register:
					   ((SpBrowseClassReferencesCommand forSpecContext: self)
						    name: 'Browse class references';
						    shortcutKey: $R;
						    yourself);
					beDisplayedAsGroup;
					yourself);
		  register: ((PinnerResetClassesHistoryCommand
				    forSpecWithIconNamed: #back
				    shortcutKey: $X)
				   name: 'Reset classes history';
				   context: self);
		  register: ((PinnerInspectClassCommand
				    forSpecWithIconNamed: #smallInspectIt
				    shortcutKey: $I)
				   name: 'Inspect';
				   context: self);
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
	"Answer a <String> representing a method item in the receiver's method list"

	^ String streamContents: [ : stream |
		stream
			<< cm methodClass asString;
			<< '>>';
			<< cm selector ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseClass [

	self systemNavigation browse: self selectedClass reference
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseClassReferences [

	| result classOrTrait |

	result := self selectedClass reference.
	(result isClass or: [ result isTrait ])
		ifFalse: [ result := result class ].

	classOrTrait := result instanceSide.
	classOrTrait isTrait
		ifTrue: [ self systemNavigation browseAllUsersOfTrait: classOrTrait ]
		ifFalse: [ self systemNavigation browseAllCallsOnClass: classOrTrait ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseHierarchy [

	self systemNavigation browseHierarchy: classesListPresenter selectedItem reference
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseImplementors [

	| realSelection |
	
	realSelection := self selectedMethod reference.
	self systemNavigation browseAllImplementorsOf: realSelection selector
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseMethodReferences [

	| realSelection |
	
	realSelection := self selectedMethod reference.
	self systemNavigation browseAllSendersOrUsersOf: realSelection selector
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowsePackage [

	self systemNavigation browse: packagesListPresenter selectedItem reference
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowsePackageDependencies [

	| analyzedPackage presenter |
	analyzedPackage := DADependencyChecker new daPackageFor: packagesListPresenter selectedItem referenceName.
	presenter := DATabPackageDependenciesPresenter on: analyzedPackage.
	presenter open.
	presenter withWindowDo: [ : w | w title: 'Package Dependencies' ]
]

{ #category : 'actions' }
PinnerSpMainPresenter >> doBrowseSenders [

	| realSelection |
	
	realSelection := self selectedMethod reference.
	self systemNavigation browseAllSendersOf: realSelection selector
]

{ #category : 'actions - reset' }
PinnerSpMainPresenter >> doResetAllHistory [
	"Private - Remove all pinned objects in the receiver"

	| empty |

	empty := self collector collectionClass empty.
	self collector resetHistory.
	self
		updatePackages: empty;
		updateClasses: empty;
		updateMethods: empty
]

{ #category : 'actions - reset' }
PinnerSpMainPresenter >> doResetClassesHistory [
	"Private - Remove all pinned classes in the receiver"

	| empty |

	empty := self collector collectionClass empty.
	self collector resetClassesHistory.
	self updateClasses: empty.
]

{ #category : 'actions - reset' }
PinnerSpMainPresenter >> doResetMethodsHistory [
	"Private - Remove all pinned methods in the receiver"

	| empty |

	empty := self collector collectionClass empty.
	self collector resetMethodsHistory.
	self updateMethods: empty.
]

{ #category : 'actions - reset' }
PinnerSpMainPresenter >> doResetPackagesHistory [
	"Private - Remove all pinned packages in the receiver"

	| empty |

	empty := self collector collectionClass empty.
	self collector resetPackagesHistory.
	self updatePackages: empty.
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
PinnerSpMainPresenter >> initializeClassListCountColumn [

	^ (SpStringTableColumn
		  title: '#'
		  evaluated: [ : cls | (self visitedClasses occurrencesOf: cls) asString ])
				width: 20;
				sortFunction: [ : m1 : m2 | (self visitedClasses occurrencesOf: m1) threeWayCompareTo: (self visitedClasses occurrencesOf: m2) ];
				yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeClassListNameColumn [

	^ (SpStringTableColumn
			title: 'Class'
			evaluated: [ : cls | cls name ])
				sortFunction: [ : c1 : c2 | c1 name threeWayCompareTo: c2 name ];
				yourself

]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeClassesList [

	| cmdGroup |

	cmdGroup := self classActionsCmdGroup.

	classesListPresenter := self newTable 
		beSingleSelection;
		addColumn: 
			((SpImageTableColumn evaluated: [ :cls | self iconNamed: cls systemIconName ])
				width: 20;
				yourself);
		addColumn: self initializeClassListCountColumn;
		addColumn: self initializeClassListNameColumn;
		whenSelectedItemChangedDo: [ : class | self updateMethodsList: class ];
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		items: self visitedClasses asOrderedSet;
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
PinnerSpMainPresenter >> initializeMethodListNameColumn [

	^ (SpStringTableColumn
		  title: 'Method'
		  evaluated: [ : pinnedMethod | self displayCompiledMethod: pinnedMethod reference ])
				beSortable;
				displayBold;
				sortFunction: [ : m1 : m2 | m1 selector threeWayCompareTo: m2 selector ];
				yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeMethodsList [

	| cmdGroup |

	cmdGroup := self methodActionsCmdGroup.

	methodsListPresenter := self newTable
		beSingleSelection;
		addColumn: 
			((SpImageTableColumn evaluated: [ : mth | self iconNamed: mth systemIconName ])
				width: 20;
				yourself);
		addColumn: self initializeMethodsListCountColumn;
		addColumn: self initializeMethodListNameColumn;
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		items: self visitedMethods asOrderedSet;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializeMethodsListCountColumn [

	^ (SpStringTableColumn
		  title: '#'
		  evaluated: [ : mth | (self visitedMethods occurrencesOf: mth) asString ])
			displayBold;
			beSortable;
			sortFunction: [ : m1 : m2 | (self visitedMethods occurrencesOf: m1) threeWayCompareTo: (self visitedMethods occurrencesOf: m2) ];					
			width: 20;
			yourself

]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePackageListCountColumn [

	^ (SpStringTableColumn
		  title: '#'
		  evaluated: [ : pkg | (self visitedPackages occurrencesOf: pkg) asString ])
				width: 20;
				sortFunction: [ : p1 : p2 | (self visitedPackages occurrencesOf: p1) threeWayCompareTo: (self visitedPackages occurrencesOf: p2) ];
				yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePackageListNameColumn [

	^ (SpStringTableColumn
		  title: 'Package'
		  evaluated: [ : pkg | pkg name ])
				beSortable;
				displayBold;
				sortFunction: [ : p1 : p2 | p1 name threeWayCompareTo: p2 name ];
				yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePackagesList [

	| cmdGroup |
	cmdGroup := self packageActionsCmdGroup.
	packagesListPresenter := self newTable
		beSingleSelection;
		addColumn: 
			((SpImageTableColumn evaluated: [ : mth | self iconNamed: #package ])
				width: 20;
				yourself);
		addColumn: self initializePackageListCountColumn;
		addColumn: self initializePackageListNameColumn;		
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		whenSelectedItemChangedDo: [ : package | self updateClassesList: package ];
		items: self visitedPackages asOrderedSet;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePresenters [

	self
		initializeMethodsList;
		initializeClassesList;
		initializePackagesList;
		initializeFocus
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
PinnerSpMainPresenter >> keybindsForFromContextMenu: aGroupElement [
	| keybinds keybindsCommands |
	keybinds := KMCategory new.

	keybindsCommands := aGroupElement allCommands select: [ :aCommand | aCommand hasShortcutKey ].

	keybindsCommands do: [ :aCommand | | action |
		action := [ :aSelectedElement | aCommand execute ].
		keybinds addKeymapEntry: (KMKeymap
			shortcut: aCommand shortcutKey
			action: action).
		].

	^ keybinds
]

{ #category : 'private' }
PinnerSpMainPresenter >> methodActionsCmdGroup [

	^ CmCommandGroup forSpec
		  beRoot;
		  register:
			  ((CmCommandGroup named: 'Browsing class commands') asSpecGroup
				   register:
					   ((SpBrowseMethodReferencesCommand forSpecContext: self)
						    name: 'Browse method references';
						    shortcutKey: $M;
						    yourself);
				   register: ((SpBrowseImplementorsCommand forSpecContext: self)
						    name: 'Browse method implementors';
						    shortcutKey: $I;
						    yourself);
				   register: ((SpBrowseSendersCommand forSpecContext: self)
						    name: 'Browse method senders';
						    shortcutKey: $S;
						    yourself);
				   beDisplayedAsGroup;
				   yourself);
		  register: ((PinnerResetMethodsHistoryCommand
				    forSpecWithIconNamed: #back
				    shortcutKey: $R)
				   name: 'Reset methods history';
				   context: self);
		  register: ((PinnerInspectMethodCommand
				    forSpecWithIconNamed: #smallInspectIt
				    shortcutKey: $I)
				   name: 'Inspect';
				   context: self);
		  yourself
]

{ #category : 'showing' }
PinnerSpMainPresenter >> open [

	super open.
	self withWindowDo: [ : w |
		"Tiling should not change the configured width"
		w adapter widget tileRight.
		w resize: (350 @ 600) scaledByDisplayScaleFactor ]
]

{ #category : 'private' }
PinnerSpMainPresenter >> packageActionsCmdGroup [

	^ CmCommandGroup forSpec
		  beRoot;
		  register:
			  ((CmCommandGroup named: 'Browsing commands') asSpecGroup
				   register: ((PinnerBrowseDependenciesCommand
						     forSpecWithIconNamed: #smallHierarchyBrowser
						     shortcutKey: $D)
						    name: 'Browse package dependencies';
						    context: self);
				   register: ((PinnerBrowsePackageCommand
						     forSpecWithIconNamed: #smallHierarchyBrowser
						     shortcutKey: $B)
						    name: 'Browse package';
						    context: self);
				   beDisplayedAsGroup;
				   yourself);
		  register: ((PinnerResetAllHistoryCommand
				    forSpecWithIconNamed: #back
				    shortcutKey: $R)
				   name: 'Reset all history';
				   context: self);
		  register: ((PinnerInspectPackageCommand
				    forSpecWithIconNamed: #smallInspectIt
				    shortcutKey: $I)
				   name: 'Inspect';
				   context: self);
		  yourself
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> resetAllSelections [
	"Private - It seems to be a bug in Spec2 because list selection keeps selected regardless of sending:
	resetListSelection; refresh; updateList "

	packagesListPresenter items: self visitedPackages asOrderedSet.
	classesListPresenter items: self visitedClasses asOrderedSet.
	methodsListPresenter items: self visitedMethods asOrderedSet
]

{ #category : 'backstops' }
PinnerSpMainPresenter >> selectedClass [

	^ classesListPresenter selectedItem
]

{ #category : 'backstops' }
PinnerSpMainPresenter >> selectedMethod [

	^ methodsListPresenter selectedItem
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> selectedPackage [

	^ packagesListPresenter selectedItem
]

{ #category : 'accessing - model' }
PinnerSpMainPresenter >> setModelBeforeInitialization: aModel [

	collector := aModel
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateClasses: aCollection [

	classesListPresenter items: aCollection asOrderedSet
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
					filteredItems := self visitedClasses select: [ : pinnedClass | pinnedClass package = aPackageOrNil reference ].
					classesListPresenter items: filteredItems asOrderedSet.
					methodsListPresenter items: Array empty.
					oldSelectedPackage := package ] ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateMethods: aCollection [

	methodsListPresenter items: aCollection asOrderedSet
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updateMethodsList: aClassOrNil [
	"Private - Class selection callback to update methods list with those methods that belongs to aClassOrNil"

	aClassOrNil
		ifNotNil: [ : class |
			| filteredItems |
			filteredItems := self visitedMethods select: [ : pinnedMethod | pinnedMethod reference methodClass = aClassOrNil reference ].
			methodsListPresenter items: filteredItems asOrderedSet ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updatePackages: aCollection [

	packagesListPresenter items: aCollection asOrderedSet
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedClasses [

	^ self collector classes
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedMethods [
	"Answer a <Collection> of <PinnedObject> recently visited methods"

	^ self collector methods
]

{ #category : 'accessing' }
PinnerSpMainPresenter >> visitedPackages [
	"Answer a <Collection> of the visited packages in the system"

	^ self collector packages
]
