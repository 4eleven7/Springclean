//
//  VLNDeviceTests.swift
//  Springclean
//
//  Created by Daniel Love on 13/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNDeviceTests: XCTestCase
{
	func testDeviceCreation()
	{
		var device: VLNDevice = VLNDevice(name: "name");
		
		XCTAssertNotNil(device == nil, "Device should not be empty")
	}
	
	func testDeviceName()
	{
		var device: VLNDevice = VLNDevice(name: "Dan's iPad");
		
		XCTAssertEqual(device.name as String, "Dan's iPad", "Device name should be my iPad");
		
		device = VLNDevice(name: "Someone's 📱");
		
		XCTAssertEqual(device.name as String, "Someone's 📱", "Device name should be your 📱");
	}
	
	func testDeviceType()
	{
		var device: VLNDevice = VLNDevice(name: "iPhone 5S", type:VLNDeviceType.iPhone5S_n51ap);
		
		XCTAssertEqual(device.type, VLNDeviceType.iPhone5S_n51ap, "Device type should be iPhone 5S");
		XCTAssertNotEqual(device.type, VLNDeviceType.iPhone5S_n53ap, "Device type should not be iPhone 5S varient");
	}
	
	func testDeviceModel()
	{
		var device: VLNDevice = VLNDevice(name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.type.modelName(), "iPad Mini", "Device model name should be iPad Mini");
	}
	
	func testDeviceClass()
	{
		var device: VLNDevice = VLNDevice(name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.type.deviceClass(), VLNDeviceClass.iPad, "Device class should be iPad Mini");
		XCTAssertEqual(device.type.deviceClass().name() as String, "iPad", "Device class should be iPad Mini");
	}
	
	func testDeviceFromRaw()
	{
		var type: VLNDeviceType = VLNDeviceType.fromRaw("iPhone6,1")!;
		
		var device: VLNDevice = VLNDevice(name: "iPhone 5S", type:type);
		
		XCTAssertEqual(device.type.modelName(), "iPhone 5S", "Device model name should be iPhone 5S");
	}
	
	func testFutureDevices()
	{
		var device: VLNDevice = VLNDevice(name: "iWatch", type:VLNDeviceType.unknown);
		
		XCTAssertEqual(device.type.modelName(), "Unknown", "Device model name should be unknown");
		XCTAssertEqual(device.type.deviceClass(), VLNDeviceClass.unknown, "Device class should be unknown");
		XCTAssertEqual(device.type.deviceClass().name() as String, "Unknown", "Device class should be unknown");
	}
	
	func testFutureDeviceFromRaw()
	{
		var type: VLNDeviceType? = VLNDeviceType.fromRaw("iWatch1,1");
		
		if !type {
			type = VLNDeviceType.unknown;
		}
		
		var device: VLNDevice = VLNDevice(name: "iWatch", type:type!);
		
		XCTAssertEqual(device.type.modelName(), "Unknown", "Device model name should be unknown");
	}
}
