Class {
	#name : #WDCQuadTree,
	#superclass : #WDCSpatialSubdivisionDataStructure,
	#instVars : [
		'size',
		'root',
		'nodeSplitCountThreshold'
	],
	#category : #'WodenEngine-Core-DataStructures'
}

{ #category : #adding }
WDCQuadTree >> addSpatialSubdivisionDataStructureElement: anElement [
	root ifNil: [
		self createRootNodeWithBoundingBox: (self boundingBoxForInitialElement: anElement)
	].

	root addElement: anElement.
	size := size + 1.
]

{ #category : #enumerating }
WDCQuadTree >> allElementsInsideOfBox: box do: aBlock [
	root ifNotNil: [
		root allElementsInsideOfBox: box do: [ :element |
			aBlock value: element spatialElementValue
		]
	]
]

{ #category : #enumerating }
WDCQuadTree >> allElementsIntersectingBox: box do: aBlock [
	root ifNotNil: [
		root allElementsIntersectingBox: box do: [ :element |
			aBlock value: element spatialElementValue
		]
	]
]

{ #category : #adding }
WDCQuadTree >> boundingBoxForInitialElement: anElement [
	| center halfExtent box |
	center := WMVector3F zero.
	halfExtent := WMVector3F ones * 1000.0.
	anElement isSpatialVolumeElement ifTrue: [
		box := anElement spatialElementBoundingBox.
		center := box center.
		halfExtent := box halfExtent *1000.0
	] ifFalse: [
		center := anElement spatialElementCenter.
	].

	^ WMBox3DF halfExtent: halfExtent center: center
]

{ #category : #adding }
WDCQuadTree >> createRootNodeWithBoundingBox: boundingBox [
	root := self nodeClass new
			maxDepth: self maxNodeDepth;
			boundingBox: boundingBox;
			tree: self;
			yourself
]

{ #category : #enumerating }
WDCQuadTree >> do: aBlock [
	root ifNotNil: [
		root do: [ :element |
			aBlock value: element spatialElementValue
		]
	]
]

{ #category : #initialization }
WDCQuadTree >> initialize [
	super initialize.
	size := 0.
	nodeSplitCountThreshold := 16.
]

{ #category : #testing }
WDCQuadTree >> isEmpty [
	^ size = 0
]

{ #category : #adding }
WDCQuadTree >> maxNodeDepth [
	^ 10
]

{ #category : #configuration }
WDCQuadTree >> nodeClass [
	^ WDCQuadTreeNode
]

{ #category : #accessing }
WDCQuadTree >> nodeSplitCountThreshold [
	^ nodeSplitCountThreshold
]

{ #category : #accessing }
WDCQuadTree >> nodeSplitCountThreshold: anObject [
	nodeSplitCountThreshold := anObject
]

{ #category : #accessing }
WDCQuadTree >> root [
	^ root
]

{ #category : #accessing }
WDCQuadTree >> size [
	^ size
]
