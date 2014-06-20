//
//  VLNMobileDeviceManagerSimulator.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

var iMDVLNDeviceAddedNotification: String = "net.daniellove.iMDVLNDeviceAddedNotification";
var iMDVLNDeviceRemovedNotification: String = "net.daniellove.iMDVLNDeviceRemovedNotification";
var iMDVLNDeviceErrorDomain: String = "net.daniellove.iMDVLNDeviceErrorDomain";
var iMDVLNDeviceNotificationKeyUDID: String = "net.daniellove.iMDVLNDeviceNotificationKeyUDID";

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
		
		return false;
	}
	
	func devices() -> AnyObject[]!
	{
		return self.simulatedDevices;
	}
	
	func deviceWithUDID(UDID: String!) -> AnyObject!
	{
		return self.simulatedDevices.filter { $0.UDID == UDID }[0];
	}
	
	func getDeviceProperty(device: AnyObject!, forKey key: String!, inDomain domain: String!, completion completionHandler: ((AnyObject!, NSError!) -> Void)!)
	{
		var mobile: VLNMobileDevice = device as VLNMobileDevice;
		mobile.loadProperty(key, domain: domain, completion:
		{
			property, error in
				if (completionHandler) {
					completionHandler(property, error);
				}
		});
	}
	
	func getSpringboardWallpaperOnDevice(device: AnyObject!, completion completionHandler: ((NSImage!, NSError!) -> Void)!)
	{
		var rawDevice: VLNMobileDevice = device as VLNMobileDevice;
		rawDevice.loadWallpaperWithCompletion({
			wallpaper, error in
				if (completionHandler) {
					completionHandler(wallpaper, error);
				}
		});
	}
	
	// MARK: Simulation
	
	var simulatedDevices: VLNMobileDevice[] = VLNMobileDevice[]();
	
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

@objc @class_protocol protocol VLNMobileDeviceManagerProtocol
{
	var subscribed: Bool { get };
	
	func subscribeForNotifications(error: NSErrorPointer) -> Bool;
	
	func unsubscribeForNotifications(error: NSErrorPointer) -> Bool;
	
	func devices() -> AnyObject[]!;
	
	func deviceWithUDID(UDID: String!) -> AnyObject!;
	
	func getDeviceProperty(device: AnyObject!, forKey key: String!, inDomain domain: String!, completion completionHandler: ((AnyObject!, NSError!) -> Void)!);
	
	func getSpringboardWallpaperOnDevice(device: AnyObject!, completion completionHandler: ((NSImage!, NSError!) -> Void)!);
}
