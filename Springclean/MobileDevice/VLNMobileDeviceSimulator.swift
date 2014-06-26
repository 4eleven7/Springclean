//
//  VLNMobileDeviceSimulator.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNMobileDevice: VLNMobileDeviceProtocol
{
	var simulatedProperties = ["name" : "Dan's iPhone",
								"productType" : "iPhone6,1",
								"screenHeight" :  "560",
								"screenWidth" :  "320",
								"screenScaleFactor" :  "1"];
	
	var UDID: String!;
	
	var name: String! = "";
	var productType: String! = "";
	var deviceColor: NSColor! = nil;
	
	var screenHeight: CGFloat = 0;
	var screenWidth: CGFloat = 0;
	var screenScaleFactor: CGFloat = 0;
	
	var wallpaper: NSImage!;
	var screenshot: NSImage!;
	
	var springboardIconGridColumns: CGFloat = 0;
	var springboardIconGridRows: CGFloat = 0;
	var springboardIconMaxPages: CGFloat = 0;
	
	var springboardFolderGridColumns: CGFloat = 0;
	var springboardFolderGridRows: CGFloat = 0;
	var springboardFolderMaxPages: CGFloat = 0;
	
	var springboardDockIconMaxCount: CGFloat = 0;
	
	var springboardIconHeight: CGFloat = 0;
	var springboardIconWidth: CGFloat = 0;
	
	var springboardVideosSupported: Bool = false;
	var springboardNewsStandSupported: Bool = false;
	var springboardWillSaveIconStateChanges: Bool = false;
	
	init(UDID: String!)
	{
		self.UDID = UDID;
	}
	
	func loadName()
	{
		self.loadProperty("name", domain: "none", completion: {
			property, error in
				self.name = property as String;
		});
	}
	
	func loadProductType()
	{
		self.loadProperty("productType", domain: "none", completion: {
			property, error in
				self.productType = property as String;
		});
	}
	
	func loadDeviceColor()
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			self.deviceColor = NSColor.blueColor();
		})
	}
	
	func loadScreenHeight()
	{
		self.loadProperty("screenHeight", domain: "none", completion: {
			property, error in
				var result : String = property as String;
				self.screenHeight = CGFloat(result.bridgeToObjectiveC().floatValue);
		});
	}
	
	func loadScreenWidth()
	{
		self.loadProperty("screenWidth", domain: "none", completion: {
			property, error in
				self.screenWidth = property as CGFloat;
		});
	}
	
	func loadScreenScaleFactor()
	{
		self.loadProperty("screenScaleFactor", domain: "none", completion: {
			property, error in
				self.screenScaleFactor = property as CGFloat;
		});
	}
	
	func loadBasicDevicePropertiesWithCompletion(completionHandler: (() -> Void)!)
	{
		dispatch_async(dispatch_get_main_queue(),
		{
			self.name = "Dan's iPhone";
			self.productType = "iPhone6,1";
			self.deviceColor = NSColor.blueColor();
			self.screenHeight = 560.0;
			self.screenWidth = 320.0;
			self.screenScaleFactor = 1.0;
			
			if (completionHandler) {
				completionHandler();
			}
		});
	}
	
	func loadProperty(key: String!, domain: String!, completion completionHandler: ((AnyObject!, NSError!) -> Void)!)
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			var result : AnyObject = self.simulatedProperties[key]!;
			if (completionHandler) {
				completionHandler(result, nil);
			}
		});
	}
	
	func loadWallpaperWithCompletion(completionHandler: ((NSImage!, NSError!) -> Void)!)
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			var wallpaper: NSImage = NSImage(size: NSSize(width: 20, height: 20));
			wallpaper.lockFocus();
			NSColor.grayColor().drawSwatchInRect(NSMakeRect(0.0, 0.0, 20.0, 20.0));
			wallpaper.unlockFocus();
			
			if (completionHandler) {
				completionHandler(wallpaper, nil);
			}
		});
	}
	
	func loadScreenshotWithCompletion(completionHandler: ((NSImage!, NSError!) -> Void)!)
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			var wallpaper: NSImage = NSImage(size: NSSize(width: 20, height: 20));
			wallpaper.lockFocus();
			NSColor.blackColor().drawSwatchInRect(NSMakeRect(0.0, 0.0, 20.0, 20.0));
			wallpaper.unlockFocus();
			
			if (completionHandler) {
				completionHandler(wallpaper, nil);
			}
		});
	}
	
	func getIconStateWithCompletion(completionHandler: ((NSDictionary!, NSError!) -> Void)!)
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			if (completionHandler) {
				completionHandler(["key":"value"], nil);
			}
		});
	}
	
	func setIconState(iconState: NSDictionary!, withCompletion completionHandler: ((Bool, NSError!) -> Void)!)
	{
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			if (completionHandler) {
				completionHandler(true, nil);
			}
		});
	}
	
	func loadSpringboardDisplayPropertiesWithCompletion(completionHandler: (() -> Void)!)
	{
		dispatch_async(dispatch_get_main_queue(),
		{
			self.springboardIconGridColumns = 4;
			self.springboardIconGridRows = 5;
			self.springboardIconMaxPages = 15;
			
			self.springboardFolderGridColumns = 3;
			self.springboardFolderGridRows = 3;
			self.springboardFolderMaxPages = 15;
			
			self.springboardDockIconMaxCount = 4;
			
			self.springboardIconHeight = 60;
			self.springboardIconWidth = 60;
			
			self.springboardVideosSupported = true;
			self.springboardNewsStandSupported = true;
			self.springboardWillSaveIconStateChanges = true;
			
			if (completionHandler) {
				completionHandler();
			}
		});
	}
	
}

@objc @class_protocol protocol VLNMobileDeviceProtocol
{
	var UDID: String! { get };
	
	var name: String! { get };
	var productType: String! { get };
	var deviceColor: NSColor! { get };
	
	var screenHeight: CGFloat { get };
	var screenWidth: CGFloat { get };
	var screenScaleFactor: CGFloat { get };
	
	var wallpaper: NSImage! { get };
	var screenshot: NSImage! { get };
	
	var springboardIconGridColumns: CGFloat { get };
	var springboardIconGridRows: CGFloat { get };
	var springboardIconMaxPages: CGFloat { get };
	
	var springboardFolderGridColumns: CGFloat { get };
	var springboardFolderGridRows: CGFloat { get };
	var springboardFolderMaxPages: CGFloat { get };
	
	var springboardDockIconMaxCount: CGFloat { get };
	
	var springboardIconHeight: CGFloat { get };
	var springboardIconWidth: CGFloat { get };
	var springboardVideosSupported: Bool { get };
	var springboardNewsStandSupported: Bool { get };
	var springboardWillSaveIconStateChanges: Bool { get };
	
	init(UDID: String!);
	
	func loadName();
	func loadProductType();
	func loadDeviceColor();
	
	func loadScreenHeight();
	func loadScreenWidth();
	func loadScreenScaleFactor();
	
	func loadBasicDevicePropertiesWithCompletion(completionHandler: (() -> Void)!);
	func loadProperty(key: String!, domain: String!, completion completionHandler: ((AnyObject!, NSError!) -> Void)!);
	
	func loadWallpaperWithCompletion(completionHandler: ((NSImage!, NSError!) -> Void)!);
	func loadScreenshotWithCompletion(completionHandler: ((NSImage!, NSError!) -> Void)!);
	
	func getIconStateWithCompletion(completionHandler: ((NSDictionary!, NSError!) -> Void)!);
	func setIconState(iconState: NSDictionary!, withCompletion completionHandler: ((Bool, NSError!) -> Void)!);
	
	func loadSpringboardDisplayPropertiesWithCompletion(completionHandler: (() -> Void)!);
}
