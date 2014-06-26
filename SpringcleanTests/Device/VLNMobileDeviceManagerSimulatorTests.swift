//
//  VLNMobileDeviceManagerSimulatorTests.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest
import Cocoa

class VLNMobileDeviceManagerSimulatorTests: XCTestCase
{
	var deviceSimulator: VLNMobileDeviceSimulator!;
	
	override func setUp()
	{
		super.setUp()
		
		self.deviceSimulator = VLNMobileDeviceSimulator();
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
	
	func testCanRetrieveDeviceByUDID()
	{
		var deviceA:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		var deviceB:VLNMobileDevice = VLNMobileDevice(UDID: "665");
		
		self.deviceSimulator.simulatedDevices = [deviceA, deviceB];
		
		var retreivedDevice:VLNMobileDevice = self.deviceSimulator.deviceWithUDID("665") as VLNMobileDevice;
		
		XCTAssertEqualObjects(deviceB.UDID, retreivedDevice.UDID, "Should be device b");
	}
	
	func testSimulatorCanGetDeviceProperty()
	{
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		XCTAssertNil(device.wallpaper, "Should not have a wallpaper");
		
		let expectation = expectationWithDescription("Should have a wallpaper");
		
		self.deviceSimulator.getDeviceProperty(device, forKey: "name", inDomain: "none", completion:
		{
			property, error in
				XCTAssertNotNil(property, "Property should not be empty");
				XCTAssertEqual(property as String, "Dan's iPhone", "Should be dan's iphone");
				XCTAssertNil(error, "Should not have an error");
				
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testSimulatorCanSimulateWallpaper()
	{
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		XCTAssertNil(device.wallpaper, "Should not have a wallpaper");
		
		let expectation = expectationWithDescription("Should have a wallpaper");
		
		self.deviceSimulator.getSpringboardWallpaperOnDevice(device,
		{
			wallpaper, error in
				XCTAssertNotNil(wallpaper, "Result should have a wallpaper");
				XCTAssertNil(error, "Should not have an error");
				
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testSimulatorCanSimulateScreenshot()
	{
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		XCTAssertNil(device.wallpaper, "Should not have a screenshot");
		
		let expectation = expectationWithDescription("Should have a screenshot");
		
		self.deviceSimulator.getDeviceScreenshot(device,
		{
			screenshot, error in
				XCTAssertNotNil(screenshot, "Result should have a screenshot");
				XCTAssertNil(error, "Should not have an error");
				
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testSimulatorCanGetIconState()
	{
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		let expectation = expectationWithDescription("Should have an icon state");
		
		self.deviceSimulator.getSpringboardIconStateOnDevice(device, completion:
		{
			iconState, error in
				XCTAssertNotNil(iconState, "Should have an icon state");
				XCTAssertNil(error, "Should not have an error");
			
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testSimulatorCanSetIconState()
	{
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n48ap);
		
		let expectation = expectationWithDescription("Should have an icon state");
		
		self.deviceSimulator.setSpringboardIconStateOnDevice(device, iconState: ["key":"value"], completion:
		{
			result, error in
				XCTAssertTrue(result, "Should have succeeded");
				XCTAssertNil(error, "Should not have an error");
			
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
}
