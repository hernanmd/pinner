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
			spec 
				package: 'Pinner';
				package: 'Pinner-Tests'	with: [ spec requires: #(Pinner) ].
			spec 
				group: 'Core' 						with: #('Pinner');
				group: 'Tests' 						with: #('Pinner' 'Pinner-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
