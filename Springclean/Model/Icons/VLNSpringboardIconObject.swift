//
//  VLNSpringboardIconObject.swift
//  Springclean
//
//  Created by Daniel Love on 21/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNSpringboardIconObject: VLNModelDictionaryRepresentationProtocol
{
	var displayName: String!;
	var displayIdentifier: String!;
	
	var iconModDate: NSDate?;
	var iconModDateString: String?
	{
		willSet
		{
			var dateFormatter: NSDateFormatter = NSDateFormatter();
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
			
			self.iconModDate = dateFormatter.dateFromString(newValue);
		}
	}
	
	var isInstalling: Bool
	{
		get
		{
			return (self.iconModDateString == nil);
		}
	}
	
	init (displayName: String, displayIdentifier: String)
	{
		self.displayName = displayName;
		self.displayIdentifier = displayIdentifier;
	}
	
// MARK: VLNModelDictionaryRepresentationProtocol
	
	func dictionaryRepresentation() -> Dictionary<String, String>
	{
		return [
				"displayName" : self.displayName!,
				"iconModDate" : self.iconModDateString!,
				"displayIdentifier" : self.displayIdentifier!
				];
	}
}
