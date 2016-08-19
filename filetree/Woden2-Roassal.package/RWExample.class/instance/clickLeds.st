as yet unclassified
clickLeds
	" 
	self new clickLeds
	"
	| v e colors cube |
	colors := {  WDColor gray . WDColor red . WDColor green . WDColor blue . WDColor yellow . WDColor white}.
	cube := RWCube new.
	cube color: [ :val | colors at: val ].
	
	v := RWView new.
	
	1 to: 1024 do: [ :i |
		e := cube elementOn: 1.
		e when: RWMouseButtonDown do: [ :ev |
			ev element model: ev element model + 1.
			ev element model > colors size ifTrue: [ ev element model: 1 ].
			ev element changed.
		].
		e when: RWMouseButtonUp do: [ :ev |
			ev element model: ev element model + 1.
			ev element model > colors size ifTrue: [ ev element model: 1 ].
			ev element changed.
		].

		v add: e.
	].
	(RWXZGridLayout gap: 0.05) on: v elements.
	v addInteraction: RWMouseKeyControl.
	v camera position: (WDVector3 x: 0.0 y: 3.0 z: 0.0).
	^ v