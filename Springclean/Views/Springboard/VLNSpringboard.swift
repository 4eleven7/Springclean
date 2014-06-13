//
//  VLNSpringboard.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNSpringboard: NSView
{
	var delegate: VLNSpringboardDelegate?;
	
	override func drawRect(dirtyRect: NSRect)
	{
		NSColor.blackColor().setFill();
		NSRectFill(dirtyRect);
	}
}

@class_protocol protocol VLNSpringboardDelegate
{
	func springboardResize(deviceType:VLNDeviceType, deviceSize:VLNDeviceSize);
}