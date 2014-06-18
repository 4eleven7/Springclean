//
//  VLNMobileDeviceSimulator.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

var iMDVLNDeviceAddedNotification: String = "net.daniellove.iMDVLNDeviceAddedNotification";
var iMDVLNDeviceRemovedNotification: String = "net.daniellove.iMDVLNDeviceRemovedNotification";

class VLNMobileDeviceSimulator: VLNMobileDeviceManagerProtocol
{
	var subscribed: Bool = false;
	
	func subscribeForNotifications(error: NSErrorPointer) -> Bool
	{
		self.subscribed = true;
		return true;
	}
	
	func unsubscribeForNotifications(error: NSErrorPointer) -> Bool
	{
		self.subscribed = false;
		return true;
	}
	
	func getDeviceProperty(device: AnyObject!, forKey key: String!, inDomain domain: String!, error: NSErrorPointer) -> AnyObject!
	{
		return "";
	}
	
	var simulatedDevices: VLNMobileDevice[] = VLNMobileDevice[]();
	
	func deviceWithUiud(udid: String) -> AnyObject!
	{
		for (VLNMobileDevice in)
	}
	
	func devices() -> AnyObject[]!
	{
		return self.simulatedDevices;
	}
	
	func addSimulatedDevice(type:VLNDeviceType) -> VLNMobileDevice
	{
		var device: VLNMobileDevice = VLNMobileDevice(UDID: getUUID());
		device.name = type.modelName();
		device.productType = type.toRaw();
		
		self.simulatedDevices.append(device);
		
		return device;
	}
	
	func removeSimulatedDevice()
	{
		if self.simulatedDevices.count > 0 {
			self.simulatedDevices.removeLast();
		}
	}
	
	func simulateDeviceAddedNotification()
	{
		NSNotificationCenter.defaultCenter().postNotificationName(iMDVLNDeviceAddedNotification, object: nil, userInfo: nil);
	}
	
	func simulateDeviceRemovedNotification()
	{
		NSNotificationCenter.defaultCenter().postNotificationName(iMDVLNDeviceRemovedNotification, object: nil, userInfo: nil);
	}
	
	func getUUID() -> String
	{
		var uuidRef:        CFUUIDRef?
		var uuidStringRef:  CFStringRef?
		
		uuidRef = CFUUIDCreate(kCFAllocatorDefault)
		uuidStringRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
		
		if uuidRef {
			uuidRef = nil
		}
		
		if uuidStringRef {
			return CFBridgingRelease(uuidStringRef!) as String;
		}
		
		return "";
	}
}

class VLNMobileDevice: VLNMobileDeviceProtocol
{
	var udid: String!;
	
	var name: String! = "Dan's iPhone";
	
	var productType: String! = "iPhone6,1";
	
	var deviceColor: NSColor! = NSColor.blueColor();
	
	var screenHeight: CGFloat = 560.0;
	
	var screenWidth: CGFloat = 320.0;
	
	var screenScaleFactor: CGFloat = 1.0;
	
	var wallpaper: NSImage!;
	
	init(UDID udid: String!)
	{
		self.udid = udid;
	}
}

@class_protocol protocol VLNMobileDeviceManagerProtocol
{
	var subscribed: Bool { get };
	
	func subscribeForNotifications(error: NSErrorPointer) -> Bool;
	
	func unsubscribeForNotifications(error: NSErrorPointer) -> Bool;
	
	func devices() -> AnyObject[]!;
	
	func deviceWithUiud(udid: String) -> AnyObject!;

	func getDeviceProperty(device: AnyObject!, forKey key: String!, inDomain domain: String!, error: NSErrorPointer) -> AnyObject!;
}

@objc @class_protocol protocol VLNMobileDeviceProtocol
{
	var udid: String! { get };
	var name: String! { get };
	var productType: String! { get };
	var deviceColor: NSColor! { get };
	var screenHeight: CGFloat { get };
	var screenWidth: CGFloat { get };
	var screenScaleFactor: CGFloat { get };
	var wallpaper: NSImage! { get };
	
	init(UDID udid: String!);
}
