Class {
	#name : 'PinnerClyTestCase',
	#superclass : 'PinnerTestCase',
	#instVars : [
		'browser'
	],
	#category : 'Pinner-Tests-Calypso',
	#package : 'Pinner-Tests',
	#tag : 'Calypso'
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

	| environment |
	super setUp.
	environment := ClyNavigationEnvironment overSystemEnvironment: ClySystemEnvironment currentImage.
	environment detachFromSystem "to ensure no subscriptions".

	browser := ClyFullBrowserMorph new.
	browser navigationEnvironment: environment.
	browser plugins removeAll.

	pinner := PinnerClyCollector new
		browser: browser;
		yourself
]

{ #category : 'tests' }
PinnerClyTestCase >> testClassesSelection [

	self openBrowserAndSelectClasses.
	"Note that for Calypso, the current selection is not part of the navigation history"
	self
		assertCollection: pinner classes
		hasSameElements: self classesToBeSelected allButLast
]

{ #category : 'tests' }
PinnerClyTestCase >> testMethodsSelection [

	self openBrowserAndSelectMethods.
	"Note that for Calypso, the current selection is not part of the navigation history"
	self
		assertCollection: pinner methods
		hasSameElements: self methodsToBeSelected allButLast
]

{ #category : 'tests' }
PinnerClyTestCase >> testPackagesAndTagSelection [

	self skip.
	self flag: #toDo.
	self openBrowserAndSelectPackagesAndTag.
	"Note that for Calypso, the current selection is not part of the navigation history"
	self
		assertCollection: pinner packageTags
		hasSameElements: self packagesWithTagToBeSelected allButLast
]

{ #category : 'tests' }
PinnerClyTestCase >> testPackagesSelection [

	self openBrowserAndSelectPackages.
	"Note that for Calypso, the current selection is not part of the navigation history"
	self
		assertCollection: pinner packages
		hasSameElements: self packagesToBeSelected allButLast
]
