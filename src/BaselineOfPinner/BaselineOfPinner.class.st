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
				package: 'Pinner-Tests'	with: [ spec requires: #(Pinner) ].
			spec 
				group: 'Core' 						with: #('Pinner');
				group: 'Tests' 						with: #('Pinner' 'Pinner-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]

{ #category : 'baselines' }
BaselineOfPinner >> orderedSet: spec [
			
	spec 
		baseline: 'ContainersOrderedSet'
		with: [ spec repository: 'github://pharo-containers/Containers-OrderedSet/src' ]

]
