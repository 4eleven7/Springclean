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
		
		let expectation = expectationWithDescription("Should not have any devices");
		self.deviceConnector.reloadDeviceList(
		{
			result in
				XCTAssertFalse(result, "Result should be false as no new changes");
				XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testReloadingDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		let expectation1st = expectationWithDescription("Should have 1 device");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceConnector.reloadDeviceList(
		{
			result in
				XCTAssertTrue(result, "Result should be true as there were changes");
				XCTAssertEqual(self.deviceManager.devices.count, 1, "Should have 1 device");
				expectation1st.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testReloadingManyDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		let expectation1st = expectationWithDescription("Should have 1 device");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceConnector.reloadDeviceList(
		{
			result in
				XCTAssertTrue(result, "Result should be true as there were changes");
				XCTAssertEqual(self.deviceManager.devices.count, 1, "Should have 1 device");
				expectation1st.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
			
				let expectation2nd = self.expectationWithDescription("Should have three devices");
				
				self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPod2ndG);
				self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n49ap);
			
				self.deviceConnector.reloadDeviceList(
				{
					result in
						XCTAssertTrue(result, "Result should be true as there were changes");
						XCTAssertEqual(self.deviceManager.devices.count, 3, "Should have three devices");
						expectation2nd.fulfill();
				});
			
				self.waitForExpectationsWithTimeout(2, handler: nil);
		});
	}
	
	func testReloadingRemovedDevices()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		let expectation1st = expectationWithDescription("Should have three devices");
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPod2ndG);
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n49ap);
		self.deviceConnector.reloadDeviceList(
		{
			result in
				XCTAssertTrue(result, "Result should be true as there were changes");
				XCTAssertEqual(self.deviceManager.devices.count, 3, "Should have three devices");
				expectation1st.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
			
				let expectation2nd = self.expectationWithDescription("Should have two devices");
				
				self.deviceSimulator.removeSimulatedDevice();
				self.deviceConnector.reloadDeviceList(
				{
					result in
						XCTAssertTrue(result, "Result should be true as there were changes");
						XCTAssertEqual(self.deviceManager.devices.count, 2, "Should have two devices");
						expectation2nd.fulfill();
				});
			
				self.waitForExpectationsWithTimeout(2, handler: nil);
		});
	}
	
	func testNotificationAddDevice()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		var device: VLNMobileDevice = self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPhone5C_n49ap);
		
		self.expectationForNotification(VLNDeviceManagerDeviceListChangedNotification, object:nil, handler:
		{
			notification in
				XCTAssertNotNil(notification, "Notfication should not be empty");
				return true;
		});
		
		self.expectationForNotification(iMDVLNDeviceAddedNotification, object:nil, handler:
		{
			notification in
				XCTAssertNotNil(notification, "Notfication should not be empty");
				XCTAssertEqual(notification.userInfo.objectForKey(iMDVLNDeviceNotificationKeyUDID) as String, device.UDID, "Notification UDID should be same as the device");
				return true;
		});
		
		self.deviceConnector.addDevice(device.UDID, addAndNotify: true);
		self.deviceSimulator.simulateDeviceAddedNotification(device.UDID);
		
		self.waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
	
	func testNotificationPostedOnUpdate()
	{
		XCTAssertEqual(self.deviceManager.devices.count, 0, "Should not have any devices");
		
		let expectation = expectationWithDescription("Should have one device");
		self.expectationForNotification(VLNDeviceManagerDeviceListChangedNotification, object:nil, handler:
		{
			notification in
				XCTAssertNotNil(notification, "Notfication should not be empty");
				return true;
		});
		
		self.deviceSimulator.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.deviceConnector.reloadDeviceList(
		{
			result in
				XCTAssertTrue(result, "Result should be true as there were changes");
				XCTAssertEqual(self.deviceManager.devices.count, 1, "Should have one device");
				expectation.fulfill();
		});
		
		waitForExpectationsWithTimeout(2, handler:
		{
			error in
				XCTAssertNil(error, "There should be no error");
		});
	}
}
