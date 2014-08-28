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
		var device: VLNDevice = VLNDevice(uuid: "666");
		
		XCTAssertNotNil(device == nil, "Device should not be empty")
	}
	
	func testDeviceUUID()
	{
		var device: VLNDevice = VLNDevice(uuid: "3d6ad3e5d74f6dd90381fa13910fef0c30858269");
		XCTAssertEqual(device.uuid as String, "3d6ad3e5d74f6dd90381fa13910fef0c30858269", "Device uuid should be device uuid");
	}
	
	func testDeviceName()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "Dan's iPad");
		
		XCTAssertEqual(device.name!, "Dan's iPad", "Device name should be my iPad");
		
		device = VLNDevice(uuid: "665", name: "Someone's 📱");
		
		XCTAssertEqual(device.name!, "Someone's 📱", "Device name should be your 📱");
	}
	
	func testDeviceType()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPhone 5S", type:VLNDeviceType.iPhone5S_n51ap);
		
		XCTAssertEqual(device.type, VLNDeviceType.iPhone5S_n51ap, "Device type should be iPhone 5S");
		XCTAssertNotEqual(device.type, VLNDeviceType.iPhone5S_n53ap, "Device type should not be iPhone 5S varient");
	}
	
	func testDeviceModel()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.type.modelName(), "iPad Mini", "Device model name should be iPad Mini");
	}
	
	func testDeviceClass()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.type.deviceClass(), VLNDeviceClass.iPad, "Device class should be iPad Mini");
		XCTAssertEqual(device.type.deviceClass().name() as String, "iPad", "Device class should be iPad Mini");
	}
	
	func testDeviceFromRaw()
	{
		var type: VLNDeviceType = VLNDeviceType.fromRaw("iPhone6,1")!;
		
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPhone 5S", type:type);
		
		XCTAssertEqual(device.type.modelName(), "iPhone 5S", "Device model name should be iPhone 5S");
	}
	
	func testFutureDevices()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iWatch", type:VLNDeviceType.unknown);
		
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
		
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iWatch", type:type!);
		
		XCTAssertEqual(device.type.modelName(), "Unknown", "Device model name should be unknown");
	}
	
	func testDeviceSize()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.size.width, 320.0, "Device width should be the default of 320");
		XCTAssertEqual(device.size.height, 560.0, "Device height should be the default of 560");
		XCTAssertEqual(device.size.scaleFactor, 1.0, "Device scale should be the default of 1");
		
		device.size = VLNDeviceSize(width: 500.0, height: 400.0, scaleFactor:2.0);
		
		XCTAssertEqual(device.size.width, 500.0, "Device width should be set to 500");
		XCTAssertEqual(device.size.height, 400.0, "Device height shouldd be set to 400");
		XCTAssertEqual(device.size.scaleFactor, 2.0, "Device scale should be set to 2");
	}
	
	func testDeviceSizeScaled()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		device.size = VLNDeviceSize(width: 400.0, height: 500.0, scaleFactor:2.0);
		
		var scaledSize: VLNDeviceSize = device.size.scale();
		
		XCTAssertEqual(scaledSize.width, 200.0, "Device width should be set to 200");
		XCTAssertEqual(scaledSize.height, 250.0, "Device height shouldd be set to 250");
		XCTAssertEqual(scaledSize.scaleFactor, 1.0, "Device scale should be set to 1");
	}
	
	func testDeviceSizeRotated()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		device.size = VLNDeviceSize(width: 400.0, height: 800.0, scaleFactor:2.0);
		
		var scaledSize: VLNDeviceSize = device.size.rotate();
		
		XCTAssertEqual(scaledSize.width, 800.0, "Device width should be set to 400");
		XCTAssertEqual(scaledSize.height, 400.0, "Device height shouldd be set to 200");
		XCTAssertEqual(scaledSize.scaleFactor, 2.0, "Device scale should be set to 1");
	}
	
	func testDeviceSizeScaledAndRotated()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		device.size = VLNDeviceSize(width: 400.0, height: 800.0, scaleFactor:2.0);
		
		var scaledAndRotatedSize: VLNDeviceSize = device.size.scaleAndRotate();
		
		XCTAssertEqual(scaledAndRotatedSize.width, 400.0, "Device width should be set to 200");
		XCTAssertEqual(scaledAndRotatedSize.height, 200.0, "Device height shouldd be set to 200");
		XCTAssertEqual(scaledAndRotatedSize.scaleFactor, 1.0, "Device scale should be set to 1");
	}
	
	func testDeviceSpringboardProperties()
	{
		var device: VLNDevice = VLNDevice(uuid: "666", name: "iPad Mini", type:VLNDeviceType.iPadMini_p106ap);
		
		XCTAssertEqual(device.properties.iconGridColumns, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconGridRows, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.maxPages, 0, "Device properties should not be set");
		
		XCTAssertEqual(device.properties.folderGridColumns, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.folderGridRows, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.folderMaxPages, 0, "Device properties should not be set");
		
		XCTAssertEqual(device.properties.dockMaxIcons, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconWidth, 0, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconHeight, 0, "Device properties should not be set");
		
		XCTAssertFalse(device.properties.supportsVideos, "Device properties should not be set");
		XCTAssertFalse(device.properties.supportsNewsStand, "Device properties should not be set");
		XCTAssertFalse(device.properties.willSaveChanges, "Device properties should not be set");
		
		device.properties.iconGridColumns = 4;
		device.properties.iconGridRows = 5;
		device.properties.maxPages = 15;
		
		device.properties.folderGridColumns = 3;
		device.properties.folderGridRows = 3;
		device.properties.folderMaxPages = 15;
		
		device.properties.dockMaxIcons = 4;
		
		device.properties.iconWidth = 60;
		device.properties.iconHeight = 60;
		
		device.properties.supportsVideos = true;
		device.properties.supportsNewsStand = true;
		device.properties.willSaveChanges = true;
		
		XCTAssertEqual(device.properties.iconGridColumns, 4, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconGridRows, 5, "Device properties should not be set");
		XCTAssertEqual(device.properties.maxPages, 15, "Device properties should not be set");
		
		XCTAssertEqual(device.properties.folderGridColumns, 3, "Device properties should not be set");
		XCTAssertEqual(device.properties.folderGridRows, 3, "Device properties should not be set");
		XCTAssertEqual(device.properties.folderMaxPages, 15, "Device properties should not be set");
		
		XCTAssertEqual(device.properties.dockMaxIcons, 4, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconWidth, 60, "Device properties should not be set");
		XCTAssertEqual(device.properties.iconHeight, 60, "Device properties should not be set");
		
		XCTAssertTrue(device.properties.supportsVideos, "Device properties should not be set");
		XCTAssertTrue(device.properties.supportsNewsStand, "Device properties should not be set");
		XCTAssertTrue(device.properties.willSaveChanges, "Device properties should not be set");
	}
}
