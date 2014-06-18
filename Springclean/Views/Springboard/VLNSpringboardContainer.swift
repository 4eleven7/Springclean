//
//  VLNSpringboardContainer.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNSpringboardContainer: NSView
{
	var delegate: VLNSpringboardContainerDelegate?;
	
	@IBOutlet var wallpaper: NSImageView;
	
	@IBOutlet var wallpaperTopConstraint: NSLayoutConstraint;
	@IBOutlet var wallpaperLeftConstraint: NSLayoutConstraint;
	@IBOutlet var wallpaperRightConstraint: NSLayoutConstraint;
	@IBOutlet var wallpaperBottomConstraint: NSLayoutConstraint;
	
	var device: VLNDevice?
	{
		willSet
		{
			self.needsDisplay = true;
		}
	}
	
	override func drawRect(dirtyRect: NSRect)
	{
		NSColor.blackColor().setFill();
		NSRectFill(dirtyRect);
	}
	
	func resizedAndReadyToDisplay()
	{
		self.wallpaper.image = device?.wallpaper;
		self.wallpaper.alphaValue = 0.0;
		
		self.animationDisplayLockscreen();
	}
	
	func animationDisplayLockscreen()
	{
		NSAnimationContext.beginGrouping();
		NSAnimationContext.currentContext().duration = 0.6;
		
		self.wallpaper.animator().alphaValue = 1.0;
		
		self.wallpaperTopConstraint.animator().constant = -20;
		self.wallpaperLeftConstraint.animator().constant = -20;
		self.wallpaperRightConstraint.animator().constant = -40;
		self.wallpaperBottomConstraint.animator().constant = -40;
		
		NSAnimationContext.endGrouping();
	}
}

@class_protocol protocol VLNSpringboardContainerDelegate
{
	func springboardResize(deviceType:VLNDeviceType, deviceSize:VLNDeviceSize);
}
