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
    /*
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
	
	func testCanLoadDeviceScreenshot()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertNil(device.screenshot, "Should not have a screenshot");
		
		let expectation = expectationWithDescription("Should have a screenshot");
		device.loadScreenshotWithCompletion(
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
	
	func testCanLoadSpringboardDisplayProperties()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		XCTAssertEqual(device.springboardIconGridColumns, 0, "Springboard property should not be set");
		XCTAssertEqual(device.springboardIconGridRows, 0, "Springboard property should not be set");
		XCTAssertEqual(device.springboardIconMaxPages, 0, "Springboard property should not be set");
		
		XCTAssertEqual(device.springboardFolderGridColumns, 0, "Springboard property should not be set");
		XCTAssertEqual(device.springboardFolderGridRows, 0, "Springboard property should not be set");
		XCTAssertEqual(device.springboardFolderMaxPages, 0, "Springboard property should not be set");
		
		XCTAssertEqual(device.springboardDockIconMaxCount, 0, "Springboard property should not be set");
		
		XCTAssertEqual(device.springboardIconHeight, 0, "Springboard property should not be set");
		XCTAssertEqual(device.springboardIconWidth, 0, "Springboard property should not be set");
		
		XCTAssertEqual(device.springboardVideosSupported, false, "Springboard property should not be set");
		XCTAssertEqual(device.springboardNewsStandSupported, false, "Springboard property should not be set");
		XCTAssertEqual(device.springboardWillSaveIconStateChanges, false, "Springboard property should not be set");
		
		let expectation = expectationWithDescription("Should have properties set");
		
		device.loadSpringboardDisplayPropertiesWithCompletion(
		{
			XCTAssertEqual(device.springboardIconGridColumns, 4, "Springboard property should be set");
			XCTAssertEqual(device.springboardIconGridRows, 5, "Springboard property should be set");
			XCTAssertEqual(device.springboardIconMaxPages, 15, "Springboard property should be set");
			
			XCTAssertEqual(device.springboardFolderGridColumns, 3, "Springboard property should be set");
			XCTAssertEqual(device.springboardFolderGridRows, 3, "Springboard property should be set");
			XCTAssertEqual(device.springboardFolderMaxPages, 15, "Springboard property should be set");
			
			XCTAssertEqual(device.springboardDockIconMaxCount, 4, "Springboard property should be set");
			
			XCTAssertEqual(device.springboardIconHeight, 60, "Springboard property should be set");
			XCTAssertEqual(device.springboardIconWidth, 60, "Springboard property should be set");
			
			XCTAssertEqual(device.springboardVideosSupported, true, "Springboard property should be set");
			XCTAssertEqual(device.springboardNewsStandSupported, true, "Springboard property should be set");
			XCTAssertEqual(device.springboardWillSaveIconStateChanges, true, "Springboard property should be set");
			
			expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanGetDevicesIconState()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		let expectation = expectationWithDescription("Should have a icon state");
		device.getIconStateWithCompletion(
		{
			iconState, error in
				XCTAssertNotNil(iconState, "Result should have an iconState");
				XCTAssertNil(error, "Should not have an error");
			
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testCanSetDevicesIconState()
	{
		var device:VLNMobileDevice = VLNMobileDevice(UDID: "666");
		
		let expectation = expectationWithDescription("Should have a icon state");
		device.setIconState(["key":"value"], withCompletion:
		{
			result, error in
				XCTAssertTrue(result, "Result should be true");
				XCTAssertNil(error, "Should not have an error");
			
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
    */
}
