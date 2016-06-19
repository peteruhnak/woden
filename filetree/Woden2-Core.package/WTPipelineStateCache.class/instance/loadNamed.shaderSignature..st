state loading
loadNamed: name shaderSignature: signatureDesc
	| signature elementName elementType element |
	signature := WTShaderSignature new
		name: name;
		yourself.
	signature elements: (signatureDesc collect: [:elementDesc |
		elementName := elementDesc at: 'name'.
		elementType := elementDesc at: 'type'.
		element := nil.
		elementType = 'bank' ifTrue: [
			element := WTShaderSignatureBank new
				name: (elementDesc at: 'name');
				maxBindings: (elementDesc at: 'max-bindings');
				elements: ((elementDesc at: 'elements') collect: [ :bankElementDesc |
					WTShaderSignatureBankElement new
						bindingType: (bankElementDesc at: 'type') asSymbol;
						bindingPoints: (bankElementDesc at: 'points' ifAbsent: [0]);
						yourself
				]);
				yourself
		].
	
		element ifNil: [ self error: 'Unsupport shader signature element of type ' , elementType printString ].
		element
	]).
	
	shaderSignatures at: signature name put: signature.