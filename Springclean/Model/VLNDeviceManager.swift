//
//  VLNDeviceManager.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNDeviceManager
{
	var devices: NSMutableArray;
	var selectedDevice: VLNDevice?;
	
	init ()
	{
		self.devices = NSMutableArray();
	}
	
	func addDevice(device: VLNDevice)
	{
		self.devices.addObject(device);
	}
	
	func addDevices(devices: NSArray)
	{
		self.devices.addObjectsFromArray(devices);
	}
	
	func removeDevice(device: VLNDevice)
	{
		if let currentDevice = self.selectedDevice
		{
			if (device === currentDevice) {
				self.selectedDevice = nil;
			}
		}
		
		self.devices.removeObject(device);
	}
	
	func removeDevices(devices: NSArray)
	{
		if let currentDevice = self.selectedDevice
		{
			if (devices.containsObject(currentDevice)) {
				self.selectedDevice = nil;
			}
		}
		
		self.devices.removeObjectsInArray(devices);
	}
	
	func indexOfDevice(device: VLNDevice) -> Int?
	{
		return self.devices.indexOfObject(device);
	}
	
	func deviceAtIndex(index: Int) -> VLNDevice
	{
		return self.devices.objectAtIndex(index) as VLNDevice;
	}
	
	func findDeviceByName(name: String) -> VLNDevice?
	{
		for (index, object: AnyObject) in enumerate(self.devices)
		{
			var device: VLNDevice = object as VLNDevice;
			if device.name! == name
			{
				return device;
			}
		}
		
		return nil;
	}
	
	func findDeviceByUUID(uuid: String) -> VLNDevice?
	{
		for (index, object: AnyObject) in enumerate(self.devices)
		{
			var device: VLNDevice = object as VLNDevice;
			if device.uuid! == uuid
			{
				return device;
			}
		}
		
		return nil;
	}
}
