initialization
initialize
	super initialize.
	self extent: 300@300.
	self color: Color veryLightGray.
	title := 'New Window'.
	isResizeable := true.
	hand := WTOSWindowHandMorph new.
	hand privateOwner: self.
	needsRendering := false.