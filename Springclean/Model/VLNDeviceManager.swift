//
//  VLNDeviceManager.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

var VLNDeviceManagerDeviceListChangedNotification: NSString!

class VLNDeviceManager: NSObject
{
	var devices: VLNDevice[];
	/*
	{
		didSet
		{
			self.postDeviceListDidChange();
		}
	}
	*/
	
	var selectedDevice: VLNDevice?;
	var selectedDeviceIndex: Int?
	{
		didSet
		{
			self.selectedDevice = self.devices[selectedDeviceIndex!];
		}
	}
	
	init ()
	{
		self.devices = [];
		
		super.init();
		
		self.subscribeForNotifications();
	}
	
	deinit
	{
		self.unsubscribeForNotifications();
	}
	
	func reloadDeviceList()
	{
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
		{
			self.devices.removeAll();
			
			let rawDevices: NSArray = CMDeviceManger.sharedManager().devices();
			
			for rawDevice:CMDevice! in rawDevices
			{
				if (!rawDevice.deviceName)
				{
					var error: NSError?;
					if (rawDevice.connect(&error))
					{
						rawDevice.loadDeviceName();
						rawDevice.disconnect();
					}
					
					if (error) {
						NSLog("error %@", error!);
					}
				}
				
				NSLog("%@", rawDevice.deviceName);
				
				if (!rawDevice.productType)
				{
					var error: NSError?;
					if (rawDevice.connect(&error))
					{
						rawDevice.loadProductType();
						rawDevice.disconnect();
					}
					
					if (error) {
						NSLog("error %@", error!);
					}
				}
				
				var deviceType:VLNDeviceType!;
				if (rawDevice.deviceName == "LovePad-Mini")
				{
					deviceType = VLNDeviceType.iPadMini_p106ap;
				}
				else if (rawDevice.productType)
				{
					deviceType = VLNDeviceType.fromRaw(rawDevice.productType);
				}
				else
				{
					deviceType = VLNDeviceType.unknown;
				}
				
				var device: VLNDevice = VLNDevice(name: rawDevice.deviceName, type: deviceType);
				self.devices.append(device);
				self.devices.append(device);
			}
			
			dispatch_async(dispatch_get_main_queue(),
			{
				self.postDeviceListDidChange();
			});
		});
	}
	
// MARK: Notifications
	
	func subscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceAddedNotification:", name: CMDeviceMangerDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceRemovedNotification:", name: CMDeviceMangerDeviceRemovedNotification, object: nil);
		
		CMDeviceManger.sharedManager().subscribe(nil);
	}
	
	func unsubscribeForNotifications()
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: CMDeviceMangerDeviceAddedNotification, object: nil);
		NSNotificationCenter.defaultCenter().removeObserver(self, name: CMDeviceMangerDeviceRemovedNotification, object: nil);
		
		CMDeviceManger.sharedManager().unsubscribe(nil);
	}
	
	func postDeviceListDidChange()
	{
		NSNotificationCenter.defaultCenter().postNotificationName(VLNDeviceManagerDeviceListChangedNotification, object: nil, userInfo: nil);
	}
	
// MARK: CMDeviceManger Notifications
	
	func deviceAddedNotification(notification: NSNotification)
	{
		self.reloadDeviceList();
	}
	
	func deviceRemovedNotification(notification: NSNotification)
	{
		self.reloadDeviceList();
	}
}
