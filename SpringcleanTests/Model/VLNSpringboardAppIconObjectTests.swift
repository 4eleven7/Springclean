//
//  VLNSpringboardAppIconObjectTests.swift
//  Springclean
//
//  Created by Daniel Love on 23/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNSpringboardAppIconObjectTests: XCTestCase
{
	func testCanCreateIconObject()
	{
		var icon: VLNSpringboardAppIconObject = VLNSpringboardAppIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone", bundleIdentifier: "com.apple.mobile", bundleVersion: "11.0");
		
		XCTAssertNotNil(icon, "Should have an icon");
		
		XCTAssertEqual(icon.displayName!, "Phone", "Display Name should be set");
		XCTAssertEqual(icon.displayIdentifier!, "com.apple.phone", "Display Identifier should be set");
		
		XCTAssertEqual(icon.bundleIdentifier!, "com.apple.mobile", "Bundle Identifier should be set");
		XCTAssertEqual(icon.bundleVersion!, "11.0", "Bundle Version should be set");
	}
	
	func testDictionaryRepresentation()
	{
		var icon: VLNSpringboardAppIconObject = VLNSpringboardAppIconObject(displayName: "Phone", displayIdentifier: "com.apple.phone", bundleIdentifier: "com.apple.mobile", bundleVersion: "11.0");
		icon.iconModDateString = "1983-02-25T16:34:53Z";
		
		var dictionaryRepresentation: Dictionary = icon.dictionaryRepresentation();
		
		XCTAssertEqual(dictionaryRepresentation.count, 5, "Should have 5 keys");
		XCTAssertEqual(dictionaryRepresentation["bundleIdentifier"]!, "com.apple.mobile", "Bundle Identifier should be set");
		XCTAssertEqual(dictionaryRepresentation["bundleVersion"]!, "11.0", "Bundle Version should be set");
	}
}
