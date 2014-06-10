//
//  VLNDeviceManager.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

struct VLNDeviceManager
{
	var devices = VLNDevice[]();
	
}

enum VLNDeviceType: Int
{
	case unknowniDevice = 1
	case iPhone4S, iPhone5, iPhone5S, iPhone5C
	case iPad2, iPad3, iPad4, iPadAir, iPadMini, iPadMini2
	case iPodTouch5G
	
	func toString() -> String
	{
		switch self
		{
			case .iPhone4S:
				return "iPhone 4S";
			case .iPhone5:
				return "iPhone 5";
			case .iPhone5S:
				return "iPhone 5S";
			case .iPhone5C:
				return "iPhone 5C";
			
			case .iPad2:
				return "iPad 2";
			case .iPad3:
				return "iPad 3";
			case .iPad4:
				return "iPad 4";
			case .iPadAir:
				return "iPad Air";
			case .iPadMini:
				return "iPad Mini";
			case .iPadMini2:
				return "iPad Mini 2";
			
			case .iPodTouch5G:
				return "iPod Touch 5G";
			
			default:
				return "Unknown";
		}
	}
}

struct VLNDevice
{
	let type: VLNDeviceType = VLNDeviceType.unknowniDevice;
	let name: String?;
}
