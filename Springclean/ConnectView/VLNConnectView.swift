//
//  VLNConnectView.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNConnectView: NSView
{
	override func drawRect(dirtyRect: NSRect)
	{
		NSColor.blackColor().setFill();
		NSRectFill(dirtyRect);
	}
}