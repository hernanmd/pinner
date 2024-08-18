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
		register: ((SpBrowseClassCommand forSpecContext: self) 
			name: 'Browse class';
			shortcutKey: $B; 
			yourself);
		register: ((SpBrowseClassHierarchyCommand forSpecContext: self)
			name: 'Browse class hierarchy';
			shortcutKey: $H;
			yourself);
		register: ((SpBrowseClassReferencesCommand forSpecContext: self)
			name: 'Browse class references';
			shortcutKey: $R;
			yourself);
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

	| empty |
	
	empty := self collector collectionClass empty.
	self collector resetHistory.
	self
		updatePackages: empty;
		updateClasses: empty;
		updateMethods: empty
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

	| cmdGroup |
	
	cmdGroup := self classActionsCmdGroup.
	classesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Classes';
		displayIcon: [ : cls | self iconNamed: cls systemIconName ];
		contextMenu: [ self classActionsCmdGroup asMenuPresenter ];
		whenSelectedItemChangedDo: [ : class | self updateMethodsList: class ];
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		items: self collector classes asOrderedSet;
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

	| cmdGroup |
	
	cmdGroup := self methodActionsCmdGroup.
	methodsListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Methods';		
		display: [ : cm | self displayCompiledMethod: cm  ];
		displayIcon: [ : cm | self iconNamed: cm systemIconName ];
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		items: self collector methods asOrderedSet;
		yourself
]

{ #category : 'initialization' }
PinnerSpMainPresenter >> initializePackagesList [

	| cmdGroup |
	cmdGroup := self packageActionsCmdGroup.
	packagesListPresenter := self newList
		beSingleSelection;
		headerTitle: 'Packages';
		display: [ : pkg | pkg name ];
		displayIcon: [ : pkg | self iconNamed: #package ];
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		whenSelectedItemChangedDo: [ : package | self updateClassesList: package ];
		items: self collector packages asOrderedSet;
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
		resize: (200 @ 600) scaledByDisplayScaleFactor;
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
		register: ((SpBrowseMethodReferencesCommand forSpecContext: self)
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
		yourself
]

{ #category : 'showing' }
PinnerSpMainPresenter >> open [

	super open.
	self withWindowDo: [ : w |
		"Tiling should not change the configured width"
		w adapter widget tileRight.
		w resize: (200 @ 800) scaledByDisplayScaleFactor ]
]

{ #category : 'private' }
PinnerSpMainPresenter >> packageActionsCmdGroup [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'Browsing commands') asSpecGroup
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
		register: ((PinnerResetHistoryCommand
			forSpecWithIconNamed: #back
			shortcutKey: $R)
				name: 'Reset history';			
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
					filteredItems := package classes select: [ : c | self visitedClasses includes: c ].
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
			| filteredItems |.
			filteredItems := class methods select: [ : c | self visitedMethods includes: c ].
			methodsListPresenter items: filteredItems asOrderedSet ]
]

{ #category : 'callbacks' }
PinnerSpMainPresenter >> updatePackages: aCollection [

	self halt.
	packagesListPresenter items: aCollection asOrderedSet;
		updateList
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
