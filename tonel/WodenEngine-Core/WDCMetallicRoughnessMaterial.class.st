Class {
	#name : #WDCMetallicRoughnessMaterial,
	#superclass : #WDCAbstractGenericSurfaceMaterial,
	#instVars : [
		'metallicRoughnessTexture'
	],
	#category : #'WodenEngine-Core-Material'
}

{ #category : #'as yet unclassified' }
WDCMetallicRoughnessMaterial class >> defaultMetallicFactor [
	^ 0.0
]

{ #category : #'as yet unclassified' }
WDCMetallicRoughnessMaterial class >> defaultRoughnessFactor [
	^ 0.55
]

{ #category : #'state binding' }
WDCMetallicRoughnessMaterial >> bindResources [
	super bindResources.
	metallicRoughnessTexture ifNotNil: [ resourceBinding bind: 5 texture: metallicRoughnessTexture].
]

{ #category : #'as yet unclassified' }
WDCMetallicRoughnessMaterial >> concretizeMaterial [
	super concretizeMaterial.
	metallicRoughnessTexture := engine resourceCache concretizeTexture: metallicRoughnessTexture.
]

{ #category : #rendering }
WDCMetallicRoughnessMaterial >> forwardFragmentShader [
	^ forwardFragmentShader ifNil: [ 
		forwardFragmentShader := 
		albedoTexture ifNotNil: [ 
			normalTexture ifNotNil: [
				metallicRoughnessTexture ifNotNil: [
					self shaderLibrary getFragmentStage: #forward_albedoNormalMetallicRoughness
				] ifNil: [
					self shaderLibrary getFragmentStage: #forward_albedoNormal
				]		
			] ifNil: [
				metallicRoughnessTexture ifNotNil: [ 
					self shaderLibrary getFragmentStage: #forward_albedoMetallicRoughness
			] ifNil: [
					self shaderLibrary getFragmentStage: #forward_albedo
				]
			]	
		] ifNil: [
			self shaderLibrary getFragmentStage: #forward_color
		].
	]

]

{ #category : #initialization }
WDCMetallicRoughnessMaterial >> initialize [
	super initialize.
	materialState
		metallicFactor: self class defaultMetallicFactor;
		roughnessFactor: self class defaultRoughnessFactor
]

{ #category : #'state binding' }
WDCMetallicRoughnessMaterial >> materialStateClass [
	^ WDCMetallicRoughnessMaterialState
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> metallicFactor [
	^ materialState metallicFactor
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> metallicFactor: factor [
	materialState metallicFactor: factor asFloat.
	self uploadMaterialStateData
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> metallicRoughnessTexture [
	^ metallicRoughnessTexture
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> metallicRoughnessTexture: anObject [
	metallicRoughnessTexture := anObject
]

{ #category : #parsing }
WDCMetallicRoughnessMaterial >> parse: materialFileReference data: data [
	super parse: materialFileReference data: data.
	metallicRoughnessTexture := self parse: data at: materialFileReference optionalTexture: 'metallic-roughness-texture'.

	materialState
		roughnessFactor: (data at: 'roughness-factor' ifAbsent: [
			metallicRoughnessTexture
				ifNil: [ self class defaultRoughnessFactor ]
				ifNotNil: [ 1.0 ]
		]);
		metallicFactor: (data at: 'metallic-factor' ifAbsent: [
			metallicRoughnessTexture
				ifNil: [ self class defaultMetallicFactor ]
				ifNotNil: [ 1.0 ]
		]).
	self invalidateCache.
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> roughnessFactor [
	^ materialState
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> roughnessFactor: factor [
	materialState roughnessFactor: factor asFloat.
	self uploadMaterialStateData
]

{ #category : #accessing }
WDCMetallicRoughnessMaterial >> shaderLibrary [
	^ shaderLibrary ifNil: [ shaderLibrary := engine loadShaderLibrary: 'shaders/material/metallic-roughness.dastrel' ].

]
