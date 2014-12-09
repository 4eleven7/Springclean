//
//  VLNMobileDeviceManagerMock.swift
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

class VLNMobileDeviceManagerMock : VLNMobileDeviceManagerProtocol
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
	
	func devices() -> [AnyObject]!
	{
		return self.simulatedDevices;
	}
	
	func deviceWithUDID(UDID: String!) -> AnyObject!
	{
		return self.simulatedDevices.filter { $0.UDID == UDID }[0];
	}
	
// MARK: Simulation
	
	var simulatedDevices: [VLNMobileDeviceMock] = [VLNMobileDeviceMock]();
	
	func addSimulatedDevice(type:VLNDeviceType) -> VLNMobileDeviceMock
	{
		var device: VLNMobileDeviceMock = VLNMobileDeviceMock(UDID: getUUID());
		device.name = type.modelName();
		device.productType = type.rawValue;
		
		self.simulatedDevices.append(device);
		
		return device;
	}
	
	func removeSimulatedDevice() -> VLNMobileDeviceMock?
	{
		if (self.simulatedDevices.count > 0) {
			return self.simulatedDevices.removeLast();
		}
		
		return nil;
	}
	
	func simulateDeviceAddedNotification(UDID: String)
	{
		NSNotificationCenter.defaultCenter().postNotificationName(iMDVLNDeviceAddedNotification, object: nil, userInfo: [iMDVLNDeviceNotificationKeyUDID: UDID]);
	}
	
	func simulateDeviceRemovedNotification(UDID: String)
	{
		NSNotificationCenter.defaultCenter().postNotificationName(iMDVLNDeviceRemovedNotification, object: nil, userInfo: [iMDVLNDeviceNotificationKeyUDID: UDID]);
	}
	
	func getUUID() -> String!
	{
		var uuid: String = NSUUID().UUIDString;
		return "fake-\(uuid)";
	}
}

@objc protocol VLNMobileDeviceManagerProtocol
{
	var subscribed: Bool { get }
	
	func subscribeForNotifications(error: NSErrorPointer) -> Bool
	
	func unsubscribeForNotifications(error: NSErrorPointer) -> Bool
	
	func devices() -> [AnyObject]!
	
	func deviceWithUDID(UDID: String!) -> AnyObject!
}
