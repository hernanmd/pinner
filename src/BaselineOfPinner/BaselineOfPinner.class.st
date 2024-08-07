Class {
	#name : 'BaselineOfPinner',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPinner',
	#package : 'BaselineOfPinner'
}

{ #category : 'baselines' }
BaselineOfPinner >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			self orderedSet: spec.
			
			spec 
				package: 'Pinner'        with: [ spec requires: #(ContainersOrderedSet) ];
				package: 'Pinner-Calypso' with: [ spec requires: #(Pinner) ];
				package: 'Pinner-UI'     with: [ spec requires: #(Pinner) ];
				package: 'Pinner-Tests'	with: [ spec requires: #(Pinner 'Pinner-UI') ];
				package: 'Pinner-Tests-Calypso' with: [ spec requires: #(#'Pinner-Tests') ].

			spec 
				group: 'Core' 						with: #('Pinner');
				group: 'UI'                    with: #('Core' 'Pinner-UI' 'Pinner-Calypso');
				group: 'Tests' 						with: #('Pinner' 'Pinner-Tests' 'Pinner-Tests-Calypso');
				group: 'default' 					with: #('Core' 'UI' 'Tests') ]
]

{ #category : 'baselines' }
BaselineOfPinner >> orderedSet: spec [
			
	spec 
		baseline: 'ContainersOrderedSet'
		with: [ spec repository: 'github://pharo-containers/Containers-OrderedSet/src' ]

]
