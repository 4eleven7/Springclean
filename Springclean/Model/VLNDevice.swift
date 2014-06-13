//
//  VLNDevice.swift
//  Springclean
//
//  Created by Daniel Love on 10/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

struct VLNDevice
{
	let name: String!;
	let type: VLNDeviceType!;
	let classification: VLNDeviceClass!;
	let size: VLNDeviceSize!;
	
	init(name: String, type: VLNDeviceType = VLNDeviceType.unknown)
	{
		self.name = name;
		self.type = type;
		self.classification = type.deviceClass();
		self.size = VLNDeviceSize();
	}
}

struct VLNDeviceSize
{
	var width = 0.0, height = 0.0;
}

enum VLNDeviceClass: Int
{
	case unknown = 1
	case iPad, iPhone, iPod
	
	func name() -> String
	{
		switch self
		{
			case .iPad:
				return "iPad";
			case .iPhone:
				return "iPhone";
			case .iPod:
				return "iPod";
			default:
				return "Unknown";
		}
	}
}

enum VLNDeviceType: String
{
	case unknown = "Unknown"
	case iPhone2G = "iPhone1,1"
	case iPhone3G = "iPhone1,2"
	case iPhone3GS = "iPhone2,1"
	case iPhone4_n90ap = "iPhone3,1"
	case iPhone4_n90bap = "iPhone3,2"
	case iPhone4_n92ap = "iPhone3,3"
	case iPhone4S = "iPhone4,1"
	case iPhone5_n41ap = "iPhone5,1"
	case iPhone5_n42ap = "iPhone5,2"
	case iPhone5C_n48ap = "iPhone5,3"
	case iPhone5C_n49ap = "iPhone5,4"
	case iPhone5S_n51ap = "iPhone6,1"
	case iPhone5S_n53ap = "iPhone6,2"

	case iPod1stG = "iPod1,1"
	case iPod2ndG = "iPod2,1"
	case iPod3rdG = "iPod3,1"
	case iPod4thG = "iPod4,1"
	case iPod5thG = "iPod5,1"

	case iPad_wifi = "iPad1,1"
	case iPad_gsm = "iPad1,2"
	case iPad2_k93ap = "iPad2,1"
	case iPad2_k94ap = "iPad2,2"
	case iPad2_k95ap = "iPad2,3"
	case iPad2_k93aap = "iPad2,4"
	case iPadMini_p105ap = "iPad2,5"
	case iPadMini_p106ap = "iPad2,6"
	case iPadMini_p107ap = "iPad2,7"
	case iPad3_j1ap = "iPad3,1"
	case iPad3_j2ap = "iPad3,2"
	case iPad3_j2aap = "iPad3,3"
	case iPad4_p101ap = "iPad3,4"
	case iPad4_p102ap = "iPad3,5"
	case iPad4_p103ap = "iPad3,6"
	case iPadAir_j71ap = "iPad4,1"
	case iPadAir_j72ap = "iPad4,2"
	case iPadAir_j73ap = "iPad4,3"
	case iPadMiniRetina_j85ap = "iPad4,4"
	case iPadMiniRetina_j86ap = "iPad4,5"
	case iPadMiniRetina_j87ap = "iPad4,6"
	
	func deviceClass() -> VLNDeviceClass
	{
		switch self
		{
			case unknown:
				return VLNDeviceClass.unknown;
			
			// iPhone
			case .iPhone2G, .iPhone3G, .iPhone3GS, .iPhone4_n90ap, .iPhone4_n90bap, .iPhone4_n92ap, .iPhone4S, .iPhone5_n41ap, .iPhone5_n42ap, .iPhone5C_n48ap, .iPhone5C_n49ap, .iPhone5S_n51ap, .iPhone5S_n53ap:
				return VLNDeviceClass.iPhone;
			
			// iPod
			case .iPod1stG, .iPod2ndG, .iPod3rdG, .iPod4thG, .iPod5thG:
				return VLNDeviceClass.iPod;
			
			// iPad
			case .iPad_wifi, .iPad_gsm, .iPad2_k93ap, .iPad2_k94ap, .iPad2_k95ap, .iPad2_k93aap, .iPad3_j1ap, .iPad3_j2ap, .iPad3_j2aap, .iPad4_p101ap, .iPad4_p102ap, .iPad4_p103ap, .iPadAir_j71ap, .iPadAir_j72ap, .iPadAir_j73ap, .iPadMini_p105ap, .iPadMini_p106ap, .iPadMini_p107ap, .iPadMiniRetina_j85ap, .iPadMiniRetina_j86ap, .iPadMiniRetina_j87ap:
				return VLNDeviceClass.iPad;
		}
	}
	
	func modelName() -> String
	{
		switch self
		{
			// iPhones
			case .iPhone2G:
				return "iPhone 2G"
				
			case iPhone3G:
				return "iPhone 3G"
				
			case iPhone3GS:
				return "iPhone 3GS"
				
			case .iPhone4_n90ap, .iPhone4_n90bap, .iPhone4_n92ap:
				return "iPhone 4"
				
			case .iPhone4S:
				return "iPhone 4S"
				
			case .iPhone5_n41ap, .iPhone5_n42ap:
				return "iPhone 5"
				
			case .iPhone5C_n48ap, .iPhone5C_n49ap:
				return "iPhone 5C"
				
			case .iPhone5S_n51ap, .iPhone5S_n53ap:
				return "iPhone 5S"
				
			// iPods
			case .iPod1stG:
				return "iPod 1st Gen"
			
			case .iPod2ndG:
				return "iPod 2nd Gen"
			
			case .iPod3rdG:
				return "iPod 3rd Gen"
			
			case .iPod4thG:
				return "iPod 4th Gen"
			
			case .iPod5thG:
				return "iPod 5th Gen"
			
			// iPads
			case .iPad_wifi, .iPad_gsm:
				return "iPad 1";
				
			case .iPad2_k93ap, .iPad2_k94ap, .iPad2_k95ap, .iPad2_k93aap:
				return "iPad 2";
			
			case .iPadMini_p105ap, .iPadMini_p106ap, .iPadMini_p107ap:
				return "iPad Mini";
				
			case .iPad3_j1ap, .iPad3_j2ap, .iPad3_j2aap:
				return "iPad 3";
				
			case .iPad4_p101ap, .iPad4_p102ap, .iPad4_p103ap:
				return "iPad 4";
			case .iPadAir_j71ap, .iPadAir_j72ap, .iPadAir_j73ap:
				return "iPad Air";
				
			case .iPadMiniRetina_j85ap, .iPadMiniRetina_j86ap, .iPadMiniRetina_j87ap:
				return "iPad Mini"
			
			default:
				return "Unknown";
		}
	}
}
