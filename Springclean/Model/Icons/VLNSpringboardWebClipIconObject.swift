//
//  VLNSpringboardWebClipIconObject.swift
//  Springclean
//
//  Created by Daniel Love on 21/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNSpringboardWebClipIconObject: VLNSpringboardIconObject, VLNModelDictionaryRepresentationProtocol
{
	var webClipURL: String!;
	
	init(displayName: String, displayIdentifier: String, webClipURL: String)
	{
		self.webClipURL = webClipURL;
		
		super.init(displayName: displayName, displayIdentifier: displayIdentifier);
	}
	
// MARK: VLNModelDictionaryRepresentationProtocol
	
	override func dictionaryRepresentation() -> Dictionary<String, String>
	{
		var dict: Dictionary<String, String> = super.dictionaryRepresentation();
		
		dict["webClipURL"] = self.webClipURL;
		
		return dict;
	}
}
