//
//  VLNMobileDeviceSimulatorTests.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNMobileDeviceSimulatorTests: XCTestCase
{
	var deviceSimulator: VLNMobileDeviceSimulator!;
	
	override func setUp()
	{
		super.setUp()
		
		self.deviceSimulator = VLNMobileDeviceSimulator();
	}
	
	func testCanSimulateDevices()
	{
		var mobile:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(mobile.UDID!, "666", "Mobile device UDID should be 666");
	}
	
	func testCanSimulateDeviceName()
	{
		var mobile:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(mobile.deviceName!, "", "Mobile device should not have a name");
		
		mobile.loadDeviceName();
		
		XCTAssertEqual(mobile.deviceName!, "Dan's iPhone", "Mobile device should have a name");
	}
	
	func testCanSimulateProductType()
	{
		var mobile:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(mobile.productType!, "", "Mobile device should not have a product type");
		
		mobile.loadProductType();
		
		XCTAssertEqual(mobile.productType!, "iPhone6,1", "Mobile device should have a product type");
	}
	
	func testSimulatorCanSetDevicesToReturn()
	{
		XCTAssertEqual(self.deviceSimulator.devices().count, 0, "Should not have any devices");
		
		var deviceA:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		var deviceB:VLNMobileDevice = VLNMobileDevice(UDID: "665");
		
		self.deviceSimulator.simulatedDevices = [deviceA, deviceB];
		
		XCTAssertEqual(self.deviceSimulator.devices().count, 2, "Should have 2 devices");
	}
	
	func testSimulatorCanSimulateDeviceAdded()
	{
		XCTAssertEqual(self.deviceSimulator.devices().count, 0, "Should not have any devices");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPad3_j2aap);
		
		XCTAssertEqual(self.deviceSimulator.devices().count, 2, "Should have 2 devices");
		
		var deviceA:VLNMobileDevice = self.deviceSimulator.devices()[0] as VLNMobileDevice;
		var deviceB:VLNMobileDevice = self.deviceSimulator.devices()[1] as VLNMobileDevice;
		
		XCTAssertEqual(deviceA.productType, VLNDeviceType.iPhone5C_n48ap.toRaw(), "Should be an iPhone 5C");
		XCTAssertEqual(deviceB.productType, VLNDeviceType.iPad3_j2aap.toRaw(), "Should be an iPad");
	}
	
	func testSimulatorCanSimulateDeviceRemoved()
	{
		XCTAssertEqual(self.deviceSimulator.devices().count, 0, "Should not have any devices");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		XCTAssertEqual(self.deviceSimulator.devices().count, 1, "Should have 2 devices");
		
		self.deviceSimulator.removeSimulatedDevice();
		
		XCTAssertEqual(self.deviceSimulator.devices().count, 0, "Should not have any devices");
	}
}
