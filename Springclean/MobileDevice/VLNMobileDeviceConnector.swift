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
		self.reloadDeviceList(completionHandler:
		{
			result in
				if (result)
				{
					dispatch_async(dispatch_get_main_queue(),{
						self.postDeviceListDidChange();
					});
				}
		});
	}
	/**
	* Returns true if changes, false if no changes
	*/
	func reloadDeviceList(completionHandler handler: ((Bool) -> Void)?)
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
		{
			// Any device still left, will be removed
			var oldDevices: NSMutableArray = NSMutableArray(array:self.deviceManager.devices);
			
			// Devices added here, or removed from oldDevices, will be added/kept
			var newDevices: NSMutableArray = NSMutableArray();

			for rawDevice : AnyObject in self.deviceConnector.devices()
			{
				//let newDevice: VLNMobileDevice = rawDevice as VLNMobileDevice;
				var newDevice: VLNMobileDeviceProtocol;
				if (rawDevice.isKindOfClass(VLNMobileDevice)) {
					newDevice = rawDevice as VLNMobileDevice;
				} else {
					newDevice = rawDevice as VLNMobileDeviceProtocol;
				}
				
				// Already exists?
				var currentDevice: VLNDevice? = self.deviceManager.findDeviceByUUID(newDevice.UDID!);
				if (currentDevice != nil)
				{
					oldDevices.removeObject(currentDevice);
					continue;
				}
				
				// Create new device
				var deviceType:VLNDeviceType! = VLNDeviceType.unknown;
				if (newDevice.productType) {
					deviceType = VLNDeviceType.fromRaw(newDevice.productType!);
				}
				
				var device: VLNDevice = VLNDevice(uuid: newDevice.UDID, name: newDevice.name!, type: deviceType);
				device.size = VLNDeviceSize(width: newDevice.screenWidth, height: newDevice.screenHeight, scaleFactor: newDevice.screenScaleFactor);
				device.wallpaper = newDevice.wallpaper;
				newDevices.addObject(device);
			}

			self.deviceManager.removeDevices(oldDevices);
			self.deviceManager.addDevices(newDevices);
			
			var result: Bool = (newDevices.count != 0 || oldDevices.count != 0);
			if (handler) {
				handler!(result);
			}
		});
	}
	
	func addDevice(udid: String) -> AnyObject
	{
		let rawDevice :AnyObject = self.deviceConnector.deviceWithUDID(udid);
		var newDevice: VLNMobileDeviceProtocol;
		if (rawDevice.isKindOfClass(VLNMobileDevice)) {
			newDevice = rawDevice as VLNMobileDevice;
		} else {
			newDevice = rawDevice as VLNMobileDeviceProtocol;
		}
		
		return newDevice as AnyObject;
	}
	
	func removeDevice(udid: String) -> AnyObject
	{
		let rawDevice :AnyObject = self.deviceConnector.deviceWithUDID(udid);
		var newDevice: VLNMobileDeviceProtocol;
		if (rawDevice.isKindOfClass(VLNMobileDevice)) {
			newDevice = rawDevice as VLNMobileDevice;
		} else {
			newDevice = rawDevice as VLNMobileDeviceProtocol;
		}
		
		return newDevice as AnyObject;
	}
	
// MARK: Notifications
	
	func subscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceAddedNotification:", name: iMDVLNDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRemovedNotification:", name: iMDVLNDeviceRemovedNotification, object: nil);
		
		var error: NSError?;
		var subscribed: Bool = self.deviceConnector.subscribeForNotifications(&error);
		
		if (error) {
			NSLog("Unable to subscribe (%i) %@", subscribed, error!);
		}
	}
	
	func unsubscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: iMDVLNDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().removeObserver(self, name: iMDVLNDeviceRemovedNotification, object: nil);
		
		var error: NSError?;
		var unsubscribed: Bool = self.deviceConnector.unsubscribeForNotifications(&error);
		
		if (error) {
			NSLog("Unable to unsubscribe (%i) %@", unsubscribed, error!);
		}
	}
	
	func postDeviceListDidChange()
	{
		NSNotificationCenter.defaultCenter().postNotificationName(VLNDeviceManagerDeviceListChangedNotification, object: nil, userInfo: nil);
	}
	
// MARK: iMDVLNDeviceManager Notifications
	
	func deviceAddedNotification(notification: NSNotification)
	{
		var udid: String = notification.userInfo.valueForKey(iMDVLNDeviceNotificationKeyUDID) as String;
		if (udid != nil && !udid.isEmpty)
		{
			self.addDevice(udid);
			return
		}
		
		self.asyncReloadDeviceList();
	}
	
	func deviceRemovedNotification(notification: NSNotification)
	{
		var udid: String = notification.userInfo.valueForKey(iMDVLNDeviceNotificationKeyUDID) as String;
		if (udid != nil && !udid.isEmpty)
		{
			self.removeDevice(udid);
			return
		}
		
		self.asyncReloadDeviceList();
	}
}
