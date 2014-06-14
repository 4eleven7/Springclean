//
//  VLNMobileDeviceConnectorTests.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNMobileDeviceConnectorTests: XCTestCase
{
	var deviceConnector: VLNMobileDeviceConnector!;
	var deviceSimulator: VLNMobileDeviceSimulator!;
	var deviceManager: VLNDeviceManager!;
	
	override func setUp()
	{
		super.setUp()
		
		self.deviceSimulator = VLNMobileDeviceSimulator();
		self.deviceManager = VLNDeviceManager();
		self.deviceConnector = VLNMobileDeviceConnector(deviceManager: self.deviceManager, deviceConnector: self.deviceSimulator);
	}
	
	func testReloadingNoDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		self.deviceConnector.reloadDeviceList();
		expectationForNotification(<#notificationName: String?#>, object: <#AnyObject?#>, handler: <#XCNotificationExpectationHandler?#>)
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
	}
	
	func testReloadingManyDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceConnector.reloadDeviceList();
		
		XCTAssertEqual(self.deviceManager.devices.count, 1, "Should have one device");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPod2ndG);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n49ap);
		self.deviceConnector.reloadDeviceList();
		
		XCTAssertEqual(self.deviceManager.devices.count, 3, "Should have three devices");
	}
	
	func testReloadingRemovedDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPod2ndG);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n49ap);
		self.deviceConnector.reloadDeviceList();
		
		XCTAssertEqual(self.deviceManager.devices.count, 3, "Should have three devices");
		
		self.deviceSimulator.removeSimulatedDevice();
		self.deviceConnector.reloadDeviceList();
		
		XCTAssertEqual(self.deviceManager.devices.count, 2, "Should have two devices");
	}
}
