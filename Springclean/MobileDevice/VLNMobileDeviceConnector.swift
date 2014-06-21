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
	let deviceConnector: VLNMobileDeviceManagerProtocol!;
	
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
	
	/**
	* Returns true if changes, false if no changes
	*/
	func reloadDeviceList(completionHandler handler: ((Bool) -> Void)? = nil)
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
		{
			// Any device still left, will be removed
			var oldDevices: NSMutableArray = NSMutableArray(array:self.deviceManager.devices);
			
			// Devices added here, or removed from oldDevices, will be added/kept
			var newDevices: NSMutableArray = NSMutableArray();
			
			for rawDevice : AnyObject in self.deviceConnector.devices()
			{
				var newDevice: VLNMobileDeviceProtocol;
				if (rawDevice.isKindOfClass(VLNMobileDevice)) {
					newDevice = rawDevice as VLNMobileDevice;
				} else {
					newDevice = rawDevice as VLNMobileDeviceProtocol;
				}
				
				// Already exists?
				var currentDevice: VLNDevice? = self.existingDevice(newDevice.UDID) as? VLNDevice;
				if (currentDevice != nil)
				{
					oldDevices.removeObject(currentDevice);
					continue;
				}
				
				var device: VLNDevice = self.addDevice(newDevice.UDID) as VLNDevice;
				newDevices.addObject(device);
			}

			self.deviceManager.removeDevices(oldDevices);
			self.deviceManager.addDevices(newDevices);
			
			var result: Bool = (newDevices.count != 0 || oldDevices.count != 0);
			dispatch_async(dispatch_get_main_queue(),
			{
				if (handler) {
					handler!(result);
				}
				
				self.postDeviceListDidChange();
			});
		});
	}
	
	func existingDevice(UDID: String) -> AnyObject?
	{
		return self.deviceManager.findDeviceByUUID(UDID);
	}
	
	func addDevice(UDID: String, addAndNotify: Bool = false) -> AnyObject
	{
		let rawDevice: AnyObject = self.deviceConnector.deviceWithUDID(UDID);
		var newDevice: VLNMobileDeviceProtocol;
		if (rawDevice.isKindOfClass(VLNMobileDevice)) {
			newDevice = rawDevice as VLNMobileDevice;
		} else {
			newDevice = rawDevice as VLNMobileDeviceProtocol;
		}
		
		var device: VLNDevice = VLNDevice(uuid: newDevice.UDID);
		
		if (addAndNotify)
		{
			self.deviceManager.addDevice(device);
			self.postDeviceListDidChange();
		}
		
		return device;
	}
	
	func removeDevice(UDID: String, removeAndNotify: Bool = false) -> AnyObject
	{
		var device: VLNDevice = self.existingDevice(UDID) as VLNDevice;
		
		if (removeAndNotify)
		{
			self.deviceManager.removeDevice(device);
			self.postDeviceListDidChange();
		}
		
		return device as AnyObject;
	}
	
// MARK: Notifications
	
	func subscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceAddedNotification:", name: iMDVLNDeviceAddedNotification, object: self.deviceConnector);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRemovedNotification:", name: iMDVLNDeviceRemovedNotification, object: self.deviceConnector);
		
		var error: NSError?;
		var subscribed: Bool = self.deviceConnector.subscribeForNotifications(&error);
		
		if (error) {
			NSLog("Unable to subscribe (%i) %@", subscribed, error!);
		}
	}
	
	func unsubscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: iMDVLNDeviceAddedNotification, object: self.deviceConnector);
		NSNotificationCenter.defaultCenter().removeObserver(self, name: iMDVLNDeviceRemovedNotification, object: self.deviceConnector);
		
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
		var UDID: String = notification.userInfo.objectForKey(iMDVLNDeviceNotificationKeyUDID) as String;
		if (UDID != nil && !UDID.isEmpty)
		{
			if (self.existingDevice(UDID) == nil) {
				self.addDevice(UDID, addAndNotify: true);
			}
			return
		}
		
		self.reloadDeviceList();
	}
	
	func deviceRemovedNotification(notification: NSNotification)
	{
		var UDID: String = notification.userInfo.valueForKey(iMDVLNDeviceNotificationKeyUDID) as String;
		if (UDID != nil && !UDID.isEmpty)
		{
			if (self.existingDevice(UDID) != nil) {
				self.removeDevice(UDID, removeAndNotify: true);
			}
			return
		}
		
		self.reloadDeviceList();
	}
}
