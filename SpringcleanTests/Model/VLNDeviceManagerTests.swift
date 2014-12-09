//
//  VLNDeviceManagerTests.swift
//  SpringcleanTests
//
//  Created by Daniel Love on 08/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNDeviceManagerTests: XCTestCase
{
	var deviceManager: VLNDeviceManager!;
	
	override func setUp()
	{
		super.setUp()
		
		self.deviceManager = VLNDeviceManager();
	}
	
	func testCount()
	{
		NSLog("%i", self.deviceManager.devices.count);
		XCTAssertTrue(true);
	}
	
	func testCanAddDeviceToDeviceManager()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "There should be no devices");
		
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(device);
		
		XCTAssertEqual(self.deviceManager.devices.count, 1, "There should be one devices");
	}
	
	func testCanRemoveDeviceFromDeviceManager()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(device);
		
		XCTAssertEqual(self.deviceManager.devices.count, 1, "There should be one devices");
		
		self.deviceManager.removeDevice(device);
		
		XCTAssertEqual(self.deviceManager.devices.count, 0, "There should be no devices");
	}
	
	func testCanAddDevicesFromDeviceManager()
	{
		var deviceA: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		var deviceB: VLNDevice = VLNDevice(uuid: "667", name: "iPod", type: VLNDeviceType.iPod3rdG);
		var deviceC: VLNDevice = VLNDevice(uuid: "668", name: "iPad", type: VLNDeviceType.iPad3_j1ap);
		
		XCTAssertEqual(self.deviceManager.devices.count, 0, "There should be no devices");
		
		self.deviceManager.addDevices([deviceA, deviceB, deviceC]);
		
		XCTAssertEqual(self.deviceManager.devices.count, 3, "There should be three devices");
	}
	
	func testCanRemoveDevicesFromDeviceManager()
	{
		var deviceA: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(deviceA);
		
		var deviceB: VLNDevice = VLNDevice(uuid: "667", name: "iPod", type: VLNDeviceType.iPod3rdG);
		self.deviceManager.addDevice(deviceB);
		
		var deviceC: VLNDevice = VLNDevice(uuid: "668", name: "iPad", type: VLNDeviceType.iPad3_j1ap);
		self.deviceManager.addDevice(deviceC);
		
		XCTAssertEqual(self.deviceManager.devices.count, 3, "There should be three devices");
		
		self.deviceManager.removeDevices([deviceA, deviceC]);
		
		XCTAssertEqual(self.deviceManager.devices.count, 1, "There should be one devices");
		XCTAssertEqual(self.deviceManager.deviceAtIndex(0), deviceB, "There should be two devices");
	}
	
	func testCanFindDeviceByIndex()
	{
		var deviceA: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(deviceA);
		
		var deviceB: VLNDevice = VLNDevice(uuid: "667", name: "iPod", type: VLNDeviceType.iPod3rdG);
		self.deviceManager.addDevice(deviceB);
		
		var deviceC: VLNDevice = VLNDevice(uuid: "668", name: "iPad", type: VLNDeviceType.iPad3_j1ap);
		self.deviceManager.addDevice(deviceC);
		
		XCTAssertEqual(self.deviceManager.deviceAtIndex(0), deviceA, "Device 1 should be A");
		XCTAssertEqual(self.deviceManager.deviceAtIndex(1), deviceB, "Device 2 should be B");
		XCTAssertEqual(self.deviceManager.deviceAtIndex(2), deviceC, "Device 3 should be C");
	}
	
	func testCanFindDeviceByName()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(device);
		
		var deviceResult: VLNDevice? = self.deviceManager.findDeviceByName("iPhone");
		XCTAssertNotNil(deviceResult, "Device should exist");
		XCTAssertEqual(device, deviceResult!, "Device should have been returned");
		
		deviceResult = self.deviceManager.findDeviceByName("iPad");
		XCTAssertNil(deviceResult, "Device should not exist");
	}
	
	func testCanFindDeviceByUUID()
	{
		var device: VLNDevice = VLNDevice(uuid: "3d6ad3e5d74f6dd90381fa13910fef0c30858269", name: "iPhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(device);
		
		var deviceResult: VLNDevice? = self.deviceManager.findDeviceByUUID("3d6ad3e5d74f6dd90381fa13910fef0c30858269");
		XCTAssertNotNil(deviceResult, "Device should exist");
		XCTAssertEqual(device, deviceResult!, "Device should have been returned");
		
		deviceResult = self.deviceManager.findDeviceByUUID("666");
		XCTAssertNil(deviceResult, "Device should not exist");
	}
	
	func testSetSelectedDevice()
	{
		var myDevice: VLNDevice = VLNDevice(uuid: "3d6ad3e5d74f6dd90381fa13910fef0c30858269", name: "LovePhone", type: VLNDeviceType.iPhone5S_n53ap);
		self.deviceManager.addDevice(myDevice);
		
		var yourDevice: VLNDevice = VLNDevice(uuid: "fa13910fef0c308582693d6ad3e5d74f6dd90381", name: "Steve's iPhone 4", type: VLNDeviceType.iPhone4_n92ap);
		self.deviceManager.addDevice(yourDevice);
		
		XCTAssertEqual(self.deviceManager.devices.count, 2, "Should have two devices");
		XCTAssertNil(self.deviceManager.selectedDevice, "There should not be a selected device");
		
		self.deviceManager.selectedDevice = myDevice;
		
		XCTAssertNotNil(self.deviceManager.selectedDevice!, "There should be a selected device");
		XCTAssertEqual(self.deviceManager.selectedDevice!, myDevice, "Selected device should be my device");
	}
}
