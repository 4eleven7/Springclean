//
//  VLNSpringboardIconObject.swift
//  Springclean
//
//  Created by Daniel Love on 21/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNSpringboardAppIconObject: VLNSpringboardIconObject, VLNModelDictionaryRepresentationProtocol
{
	var bundleIdentifier: String!;
	var bundleVersion: String!;
	
	init(displayName: String, displayIdentifier: String, bundleIdentifier: String, bundleVersion: String)
	{
		self.bundleIdentifier = bundleIdentifier;
		self.bundleVersion = bundleVersion;
		
		super.init(displayName: displayName, displayIdentifier: displayIdentifier);
	}
	
// MARK: VLNModelDictionaryRepresentationProtocol
	
	override func dictionaryRepresentation() -> Dictionary<String, String>
	{
		var dict: Dictionary<String, String> = super.dictionaryRepresentation();
		
		dict["bundleIdentifier"] = self.bundleIdentifier;
		dict["bundleVersion"] = self.bundleVersion;
		
		return dict;
	}
}
