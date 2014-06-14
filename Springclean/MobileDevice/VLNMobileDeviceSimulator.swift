//
//  VLNMobileDeviceSimulator.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

var CMDeviceMangerDeviceAddedNotification: String = "CMDeviceMangerDeviceAddedNotification";
var CMDeviceMangerDeviceRemovedNotification: String = "CMDeviceMangerDeviceRemovedNotification";

class VLNMobileDeviceSimulator: VLNMobileDeviceManagerProtocol
{
	func readConnectedDeviceUDIDs() -> AnyObject[]!
	{
		return NSArray();
	}
	
	var simulatedDevices: VLNMobileDevice[] = VLNMobileDevice[]();
	
	func devices() -> AnyObject[]!
	{
		return self.simulatedDevices;
	}
	
	var subscribed: Bool = false;
	
	func subscribe(error: NSErrorPointer) -> Bool
	{
		//error = nil;
		return true;
	}
	
	func unsubscribe(error: NSErrorPointer) -> Bool
	{
		//error = nil;
		return true;
	}
	
	func addSimulatedDevice(type:VLNDeviceType) -> VLNMobileDevice
	{
		var device: VLNMobileDevice = VLNMobileDevice(UDID: getUUID());
		device.productType = type.toRaw();
		device.deviceName = type.modelName();
		
		self.simulatedDevices.append(device);
		
		NSNotificationCenter.defaultCenter().postNotificationName(CMDeviceMangerDeviceAddedNotification, object: nil, userInfo: nil);
		
		return device;
	}
	
	func removeSimulatedDevice()
	{
		if self.simulatedDevices.count > 0 {
			self.simulatedDevices.removeLast();
		}
		
		NSNotificationCenter.defaultCenter().postNotificationName(CMDeviceMangerDeviceRemovedNotification, object: nil, userInfo: nil);
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
	var UDID: String!;
	
	init(UDID: String!)
	{
		self.UDID = UDID;
	}
	
	var connected: Bool = false;
	
	func connect(error: NSErrorPointer) -> Bool
	{
		return false;
	}
	
	func disconnect() -> Bool
	{
		return false;
	}
	
	func loadDeviceName() -> Bool
	{
		self.deviceName = "Dan's iPhone";
		return true;
	}
	
	var deviceName: String! = "";
	
	func loadProductType() -> Bool
	{
		self.productType = "iPhone6,1";
		return false;
	}
	
	var productType: String! = "";
	
	func readDomain(domain: String!, error: NSErrorPointer) -> AnyObject!
	{
		return nil;
	}
	
	func readDomain(domain: String!, key: String!, error: NSErrorPointer) -> AnyObject!
	{
		return nil;
	}
	
	func writeValue(value: AnyObject!, toDomain domain: String!, forKey key: String!, error: NSErrorPointer) -> Bool
	{
		return false;
	}
	
	func getScreenshot(error: NSErrorPointer) -> NSData!
	{
		return nil;
	}
	
	class func knownDomains() -> AnyObject[]!
	{
		return nil;
	}
	
	class func isDomainKnown(domain: String!) -> Bool
	{
		return false;
	}
}

@class_protocol protocol VLNMobileDeviceManagerProtocol
{
	func readConnectedDeviceUDIDs() -> AnyObject[]!;
	func devices() -> AnyObject[]!;
	
	var subscribed: Bool { get };
	
	func subscribe(error: NSErrorPointer) -> Bool;
	func unsubscribe(error: NSErrorPointer) -> Bool;
}

@class_protocol protocol VLNMobileDeviceProtocol
{
	var UDID: String! { get };
	
	init(UDID: String!);
	
	var connected: Bool { get };
	
	func connect(error: NSErrorPointer) -> Bool;
	func disconnect() -> Bool;
	
	func loadDeviceName() -> Bool;
	var deviceName: String! { get };
	
	func loadProductType() -> Bool;
	var productType: String! { get };
	
	func readDomain(domain: String!, error: NSErrorPointer) -> AnyObject!;
	func readDomain(domain: String!, key: String!, error: NSErrorPointer) -> AnyObject!;
	
	func writeValue(value: AnyObject!, toDomain domain: String!, forKey key: String!, error: NSErrorPointer) -> Bool;
	
	func getScreenshot(error: NSErrorPointer) -> NSData!;
	
	class func knownDomains() -> AnyObject[]!;
	class func isDomainKnown(domain: String!) -> Bool;
}
