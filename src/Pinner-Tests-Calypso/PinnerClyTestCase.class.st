Class {
	#name : 'PinnerClyTestCase',
	#superclass : 'PinnerTestCase',
	#instVars : [
		'browser'
	],
	#category : 'Pinner-Tests-Calypso',
	#package : 'Pinner-Tests-Calypso'
}

{ #category : 'running' }
PinnerClyTestCase >> deleteBrowser [

	browser ifNotNil: [
		browser window ifNotNil: [ :window |
			window delete ] ]
]

{ #category : 'helpers' }
PinnerClyTestCase >> openBrowserAndSelectClasses [

	browser open.
	self classesToBeSelected do: [ : cls | browser selectClass: cls ]
]

{ #category : 'helpers' }
PinnerClyTestCase >> openBrowserAndSelectMethods [

	browser open.
	self methodsToBeSelected do: [ : mth | browser selectMethod: mth ]
]

{ #category : 'helpers' }
PinnerClyTestCase >> openBrowserAndSelectPackages [

	"	browser selectPackage: (PackageOrganizer default packageNamed: #Kernel) andTag: 'BasicObjects'.'"

	browser open.
	self classesToBeSelected do: [ : cls | browser selectPackage: cls package ]
]

{ #category : 'helpers' }
PinnerClyTestCase >> openBrowserAndSelectPackagesAndTag [

	browser open.
	self packagesWithTagToBeSelected do: [ : pkgTag |
		browser
			selectPackage: pkgTag package
			andTag: pkgTag name ]
]

{ #category : 'running' }
PinnerClyTestCase >> setUp [
	"Note that for Calypso, the current selection is not part of the navigation history"

	| environment |
	super setUp.
	"Warning: Running tests should clean the history"
	PinnerCollector reset.
	environment := ClyNavigationEnvironment overSystemEnvironment: ClySystemEnvironment currentImage.
	environment detachFromSystem "to ensure no subscriptions".

	browser := ClyFullBrowserMorph new.
	browser navigationEnvironment: environment.
	browser plugins removeAll.

	pinner := PinnerCollector uniqueInstance
		browser: browser;
		yourself
]

{ #category : 'running' }
PinnerClyTestCase >> tearDown [

	PinnerCollector reset.
	super tearDown.
]

{ #category : 'tests' }
PinnerClyTestCase >> testClassesSelection [

	self openBrowserAndSelectClasses.
	self
		assertCollection: (pinner classes collect: #reference)
		hasSameElements: self classesToBeSelected allButLast
]

{ #category : 'tests' }
PinnerClyTestCase >> testMethodsSelection [

	self openBrowserAndSelectMethods.
	self
		assertCollection: (pinner methods collect: #reference)
		hasSameElements: self methodsToBeSelected allButLast
]

{ #category : 'tests' }
PinnerClyTestCase >> testPackagesSelection [

	self openBrowserAndSelectPackages.
	self
		assertCollection: (pinner packages collect: #reference)
		hasSameElements: self packagesToBeSelected allButLast
]
