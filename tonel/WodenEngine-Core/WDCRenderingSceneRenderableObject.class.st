Class {
	#name : #WDCRenderingSceneRenderableObject,
	#superclass : #WDCAbstractRenderingSceneObject,
	#instVars : [
		'renderable'
	],
	#pools : [
		'AGPUConstants'
	],
	#category : #'WodenEngine-Core-Rendering'
}

{ #category : #accessing }
WDCRenderingSceneRenderableObject >> computeBoundingBox [
	"Transcript show: (renderable boundingBox transformedWith: spatialObject transform); cr."
	^ renderable boundingBox transformedWith: spatialObject transform
]

{ #category : #accessing }
WDCRenderingSceneRenderableObject >> renderOn: stateTracker [
	renderable validateForNode: node.
	spatialObject renderRenderable: renderable with: stateTracker

]

{ #category : #accessing }
WDCRenderingSceneRenderableObject >> renderPriority [
	^ renderable renderPriority
]

{ #category : #accessing }
WDCRenderingSceneRenderableObject >> renderable [
	^ renderable
]

{ #category : #accessing }
WDCRenderingSceneRenderableObject >> renderable: anObject [
	renderable := anObject
]

{ #category : #'as yet unclassified' }
WDCRenderingSceneRenderableObject >> updateCommonGpuStateForFrame: frameIndex [
	super updateCommonGpuStateForFrame: frameIndex.
	renderable updateCommonGpuStateForFrame: frameIndex.
]