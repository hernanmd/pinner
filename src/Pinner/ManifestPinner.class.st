"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPinner',
	#superclass : 'PackageManifest',
	#category : 'Pinner-Manifest',
	#package : 'Pinner',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPinner class >> ruleImplementedNotSentRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#PinnerClyCollector #browsingHistory #false)) #'2024-07-23T17:54:32.927007+02:00') #(#(#RGMethodDefinition #(#PinnerCollector #packageTags #false)) #'2024-07-23T17:54:32.92717+02:00') )
]
