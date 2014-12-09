//
//  VLNSpringboardIconObjectTests.swift
//  Springclean
//
//  Created by Daniel Love on 21/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNSpringboardIconObjectTests: XCTestCase
{
	func testCanCreateIconObject()
	{
		var icon: VLNSpringboardIconObject = VLNSpringboardIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone");
		
		XCTAssertNotNil(icon, "Should have an icon");
		
		XCTAssertEqual(icon.displayName!, "Phone", "Display Name should be set");
		XCTAssertEqual(icon.displayIdentifier!, "com.apple.phone", "Display Identifier should be set");
	}

	func testIconModDateStringIsConvertedToDate()
	{
		var icon: VLNSpringboardIconObject = VLNSpringboardIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone");
		icon.iconModDateString = "1983-02-25T16:34:53Z";
		XCTAssertEqual(icon.iconModDateString!, "1983-02-25T16:34:53Z", "Display Mod Date String should be set");
		
		var dateFormatter: NSDateFormatter = NSDateFormatter();
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
		
		var date: NSDate = dateFormatter.dateFromString("1983-02-25T16:34:53Z")!;
		XCTAssertEqual(icon.iconModDate!, date, "Display Mod Date should be set");
	}
	
	func testInstallingIsMonitored()
	{
		var icon: VLNSpringboardIconObject = VLNSpringboardIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone");
		XCTAssertTrue(icon.isInstalling, "Icon should be installing");
		
		icon.iconModDateString = "1983-02-25T16:34:53Z";
		XCTAssertFalse(icon.isInstalling, "Icon should be installed");
		
		icon.iconModDateString = nil;
		XCTAssertTrue(icon.isInstalling, "Icon should be uninstalled");
	}
	
	func testDictionaryRepresentation()
	{
		var icon: VLNSpringboardIconObject = VLNSpringboardIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone");
		icon.iconModDateString = "1983-02-25T16:34:53Z";
		
		var dictionaryRepresentation: Dictionary = icon.dictionaryRepresentation();
		
		XCTAssertEqual(dictionaryRepresentation.count, 3, "Should have 3 keys");
		XCTAssertEqual(dictionaryRepresentation["displayIdentifier"]!, "com.apple.phone", "Display Identifier should be set");
		XCTAssertEqual(dictionaryRepresentation["displayName"]!, "Phone", "Display Name should be set");
		XCTAssertEqual(dictionaryRepresentation["iconModDate"]!, "1983-02-25T16:34:53Z", "Display Identifier should be set");
	}
}
