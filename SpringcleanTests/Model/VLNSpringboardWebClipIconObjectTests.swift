//
//  VLNSpringboardWebClipIconObjectTests.swift
//  Springclean
//
//  Created by Daniel Love on 23/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import XCTest

class VLNSpringboardWebClipIconObjectTests: XCTestCase
{
	func testCanCreateIconObject()
	{
		var icon: VLNSpringboardWebClipIconObject = VLNSpringboardWebClipIconObject(displayName: "TestFlight", displayIdentifier: "com.apple.webapp-BCBC3F654C994183AC0F7263C760677E", webClipURL: "/m/builds")
		
		XCTAssertTrue(icon != nil, "Should have an icon");
		
		XCTAssertEqual(icon.displayName!, "TestFlight", "Display Name should be set");
		XCTAssertEqual(icon.displayIdentifier!, "com.apple.webapp-BCBC3F654C994183AC0F7263C760677E", "Display Identifier should be set");
		
		XCTAssertEqual(icon.webClipURL!, "/m/builds", "WebClip URL should be set");
	}
	
	func testDictionaryRepresentation()
	{
		var icon: VLNSpringboardWebClipIconObject = VLNSpringboardWebClipIconObject(displayName: "TestFlight", displayIdentifier: "com.apple.webapp-BCBC3F654C994183AC0F7263C760677E", webClipURL: "/m/builds")
		icon.iconModDateString = "1983-02-25T16:34:53Z";
		
		var dictionaryRepresentation: Dictionary = icon.dictionaryRepresentation();
		
		XCTAssertEqual(dictionaryRepresentation.count, 4, "Should have 4 keys");
		XCTAssertEqualObjects(dictionaryRepresentation["webClipURL"], "/m/builds", "WebClip URL should be set");
	}
}
