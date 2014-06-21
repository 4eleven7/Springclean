//
//  VLNMobileDeviceSimulatorTests.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest
import Cocoa

class VLNMobileDeviceSimulatorTests: XCTestCase
{
	func testCanCreateDevices()
	{
		var mobile:VLNMobileDevice = VLNMobileDevice(UDID: "999");
		
		XCTAssertEqual(mobile.UDID!, "999", "Mobile device UDID should be 999");
		
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(device.UDID!, "666", "Mobile device UDID should be 666");
	}
	
	func testCanLoadDeviceName()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(device.name!, "", "Mobile device should not have a name");
		
		device.loadName();
		
		let expectation = expectationWithDescription("Device should have a name");
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			XCTAssertEqual(device.name!, "Dan's iPhone", "Device should have a name");
			expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanLoadDeviceScreenHeight()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(device.screenHeight, 0, "Mobile device should not have a screenheight");
		
		device.loadScreenHeight();
		
		let expectation = expectationWithDescription("Device should have a screenheight");
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_current_queue(),
		{
			XCTAssertEqual(device.screenHeight, 560, "Device should have a screenheight");
			expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanLoadDeviceProperties()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(device.name!, "", "Mobile device should not have a name");
		XCTAssertEqual(device.productType!, "", "Mobile device should not have a product type");
		
		let expectation = expectationWithDescription("Device should have a product type");
		device.loadBasicDevicePropertiesWithCompletion(
		{
			XCTAssertEqual(device.name!, "Dan's iPhone", "Device should have a name");
			XCTAssertEqual(device.productType!, "iPhone6,1", "Device should have a product type");
			
			expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanSimulateDeviceProperties()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		device.simulatedProperties["numberOfAudioPorts"] = "20";
		
		let expectation = expectationWithDescription("Device should have a numberOfAudioPorts");
		device.loadProperty("numberOfAudioPorts", domain: "none", completion:
		{
			property, error in
				XCTAssertEqual(property as String, "20", "Device should have 20 audio ports");
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanLoadDeviceWallpaper()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertNil(device.wallpaper, "Should not have a wallpaper");
		
		let expectation = expectationWithDescription("Should have a wallpaper");
		device.loadWallpaperWithCompletion(
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
}
