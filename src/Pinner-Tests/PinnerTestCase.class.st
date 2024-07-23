Class {
	#name : 'PinnerTestCase',
	#superclass : 'TestCase',
	#instVars : [
		'pinner'
	],
	#category : 'Pinner-Tests-Core',
	#package : 'Pinner-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
PinnerTestCase >> classesToBeSelected [

	^ { Object . Behavior .  Class . FileReference . IdentityBag }
]

{ #category : 'running' }
PinnerTestCase >> deleteBrowser [

	self subclassResponsibility
]

{ #category : 'tests' }
PinnerTestCase >> methodsToBeSelected [

	^ {
		Object >> #= .
		Behavior >> #new .
		Class >> #isClass .
		FileReference >> #size .
		Bag >> #add:
		}
]

{ #category : 'tests' }
PinnerTestCase >> packagesToBeSelected [

	^ {
		'Kernel' asPackage .
		'Kernel-CodeModel' asPackage .
		'FileSystem-Core' asPackage .
		'Collections-Unordered' asPackage }
]

{ #category : 'tests' }
PinnerTestCase >> packagesWithTagToBeSelected [

	^ {
		'Kernel' asPackage tagNamed: #Objects .
		'Kernel-CodeModel' asPackage tagNamed: #Classes .
		'FileSystem-Core' asPackage tagNamed: #Kernel .
		'Collections-Unordered' asPackage tagNamed: #Dictionaries
		}
]

{ #category : 'running' }
PinnerTestCase >> tearDown [

	self deleteBrowser.
	super tearDown
]
