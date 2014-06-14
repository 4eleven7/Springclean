//
//  VLNMobileDeviceConnector.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

var VLNDeviceManagerDeviceListChangedNotification: String = "VLNDeviceManagerDeviceListChangedNotification";

class VLNMobileDeviceConnector: NSObject
{
	let deviceManager: VLNDeviceManager!;
	let deviceConnector: VLNMobileDeviceManagerProtocol;
	
	init (deviceManager: VLNDeviceManager, deviceConnector: VLNMobileDeviceManagerProtocol)
	{
		self.deviceManager = deviceManager;
		self.deviceConnector = deviceConnector;
		
		super.init();
		
		self.subscribeForNotifications();
	}
	
	deinit
	{
		self.unsubscribeForNotifications();
	}
	
	func asyncReloadDeviceList()
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
		{
			self.reloadDeviceList();
			
			dispatch_async(dispatch_get_main_queue(),{
				self.postDeviceListDidChange();
			});
		});
	}
	
	func reloadDeviceList()
	{
		// Any device still left, will be removed
		var oldDevices: NSMutableArray = NSMutableArray(array:self.deviceManager.devices);
		
		// Devices added here, or removed from oldDevices, will be added/kept
		var newDevices: NSMutableArray = NSMutableArray();

		for rawDevice : AnyObject in self.deviceConnector.devices()
		{
			let newDevice = rawDevice as VLNMobileDevice;
			
			// Already exists?
			var currentDevice: VLNDevice? = self.deviceManager.findDeviceByUUID(newDevice.UDID!);
			if (currentDevice != nil)
			{
				oldDevices.removeObject(currentDevice);
				continue;
			}
			
			// Update properties
			if (!newDevice.deviceName)
			{
				var error: NSError?;
				if (newDevice.connect(&error))
				{
					newDevice.loadDeviceName();
					newDevice.disconnect();
				}
				
				if (error) {
					NSLog("error %@", error!);
				}
			}
			
			NSLog("%@", newDevice.deviceName!);
			
			if (!newDevice.productType)
			{
				var error: NSError?;
				if (newDevice.connect(&error))
				{
					newDevice.loadProductType();
					newDevice.disconnect();
				}
				
				if (error) {
					NSLog("error %@", error!);
				}
			}
			
			var deviceType:VLNDeviceType! = VLNDeviceType.unknown;
			if (newDevice.productType) {
				deviceType = VLNDeviceType.fromRaw(newDevice.productType!);
			}
			
			var device: VLNDevice = VLNDevice(uuid: newDevice.UDID, name: newDevice.deviceName, type: deviceType);
			newDevices.addObject(device);
		}

		self.deviceManager.removeDevices(oldDevices);
		self.deviceManager.addDevices(newDevices);
	}
	
// MARK: Notifications
	
	func subscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceAddedNotification:", name: CMDeviceMangerDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRemovedNotification:", name: CMDeviceMangerDeviceRemovedNotification, object: nil);
		
		var error: NSError?;
		var subscribed: Bool = self.deviceConnector.subscribe(&error);
		
		if (error) {
			NSLog("Unable to subscribe (%i) %@", subscribed, error!);
		}
	}
	
	func unsubscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: CMDeviceMangerDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().removeObserver(self, name: CMDeviceMangerDeviceRemovedNotification, object: nil);
		
		var error: NSError?;
		var unsubscribed: Bool = self.deviceConnector.unsubscribe(&error);
		
		if (error) {
			NSLog("Unable to unsubscribe (%i) %@", unsubscribed, error!);
		}
	}
	
	func postDeviceListDidChange()
	{
		NSNotificationCenter.defaultCenter().postNotificationName(VLNDeviceManagerDeviceListChangedNotification, object: nil, userInfo: nil);
	}
	
// MARK: CMDeviceManger Notifications
	
	func deviceAddedNotification(notification: NSNotification)
	{
		self.asyncReloadDeviceList();
	}
	
	func deviceRemovedNotification(notification: NSNotification)
	{
		self.asyncReloadDeviceList();
	}
}
