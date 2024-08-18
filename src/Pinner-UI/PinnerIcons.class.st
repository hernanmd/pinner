"
Browse icons created by Flat Icons - Flaticon. From `https://www.flaticon.com/free-icons/browse` 

"
Class {
	#name : 'PinnerIcons',
	#superclass : 'SpPharoThemeIconProvider',
	#classVars : [
		'icons'
	],
	#category : 'Pinner-UI-Icons',
	#package : 'Pinner-UI',
	#tag : 'Icons'
}

{ #category : 'accessing - icons' }
PinnerIcons class >> browsing_16x16Icon [
	"Private - Generated method"
	^ self icons
		at: #browsing_16x16Icon
		ifAbsentPut: [ Form fromBinaryStream: self browsing_16x16IconContents base64Decoded asByteArray readStream ]
]

{ #category : 'private - contents' }
PinnerIcons class >> browsing_16x16IconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAB+FBMVEUAAABHjPdMkP5Gi/ZEifM+g+tgi89diMsARpU7gehajt9UiNpCh/Bgi85diMxahchSid5Vh9U5f+Vcgr8ANn42fOE3feI4fuM9g+oAR5b///9HjPdHjPdHjPdHjPdHjPdHjPdHjPdHjPdHjPdHjPdHjPdHjPdGjPk5jv9HjPdHjPdFi/VHjPdHjPibh2eHiIqEhYaZhGRFivWFiIuBg4aCg4Z+gIJ7fYCAgoVHjfhFi/VBhu+DhYd9f4JGi/ZCh/AAOYOdh2WBg4Z7fYCahWNHjfpCiPE5f+U6jv+Gh4iAgoV7fYCDhIU/k/9Ch/E7geeDhIV9f4JBh+86gOachF97fYB8fYCchWA/he03feKAgoV9f4J8foFDiPI9guoAPolHjPeCgoF7fYB7foJ8f4N8foE/he05f+VHjPdEivQ5g/GJTyWCW0WKY0mRYDlAhu47gedHjPdHjPdGi/ZAhu9XUm+AMwaLPAdoZoNCifQ/he0zedw6gOY8guk6gOdGbLKBMwWLPAZNecc9g+s5f+U2fOE0et40e+BIaq2ANAeKPAlRZJCnqKnV1dalpqj6+vr4+Pien6HS09Pv8PCYmZqdnqDr7O3AwsPS0tPt7u6TlJbi5OS7vL2kpaf39/f29/fy8/Pj5OWVl5mcnqDDxMW9v8CVlpj///8fmr4/AAAAjHRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFyw4i6ahNwZwqlgcCFlvBpoYBRwdBXE9rt7erj0Yqjnh4ViNAQWtrQUbpxgIHN3dHAihLhvdoS4ErKwEpxg74OBYjAEYOavu7qurOJg6Mgm3tgqacQVz5Lwdz84dVqoGKMC7NrCuRIk5BhMOBRsaAylH7ncAAAABYktHRBp1Z+QyAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH6AgSETso6EBpHwAAAQhJREFUGNNjYGBgZGSUlpGVlQHSjAwMYL6cvIKiooK8EhMzM4ivrKKqpq6hoa6pqqXNwgoU0NLRZdPTNzBk19Ux4uBkYFRS1eUyNjE1M7fgtrSy5mFglNfkNbbp6e3ts7Vgt7N3YJBRUHd06unv758w0dnF1c2dQVbRw9Nr0uQpU6dN9/bx9fMHCQQEzpg5a9bsOd4BvkHBIC0hoXPnzV+wcFFYuHpEJNBQNb6o6MVLli6LieKPjYtnYJRTTRBITEpOSY0S1E1LFwI6TCUjMys7JzdP2DK/QEQUKFBYVFxSWlZeUVlVUC0mDvSMRE1tXX1DY1NziySIz8Ag2trW3tHZ1S0lJArkAwBIakEdwPW+bwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNC0wOC0xOFQxNzo1MjowMCswMDowMDj3JyoAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjQtMDgtMThUMTc6MTg6MzArMDA6MDBg3ns+AAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI0LTA4LTE4VDE3OjU5OjQwKzAwOjAwYhVLRAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAAASUVORK5CYII='
]

{ #category : 'accessing' }
PinnerIcons class >> icons [
	^ icons ifNil: [ icons := Dictionary new ]
]

{ #category : 'InspectorExtensions' }
PinnerIcons class >> inspectionIcons [
	<inspectorPresentationOrder: 0 title: 'icons'>
	<script: 'self inspect'>
	^ SpTablePresenter new
		  addColumn: (SpImageTableColumn title: 'Icon' evaluated: #value);
		  addColumn: (SpStringTableColumn title: 'Name' evaluated: #key);
		  items:
			  ((self class selectorsInCategory: 'accessing - icons') sorted
				   collect: [ :each | each -> (self perform: each) ]);
		  yourself
]

{ #category : 'accessing - reset' }
PinnerIcons class >> resetIcons [
	<script>
	^ icons := nil
]

{ #category : 'accessing' }
PinnerIcons >> iconNamed: aName ifAbsent: aBlock [
	"Answer a <Form> representing an icon named aName. Execute aBlock if not found"
	
	(aName isNil or: [ (self class respondsTo: aName) not ])
		ifTrue: [ ^ aBlock value ].

	 ^ self class perform: aName
]
