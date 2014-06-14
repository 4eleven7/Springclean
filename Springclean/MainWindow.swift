//
//  MainWindow.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class MainWindow: NSWindow
{
	@IBOutlet var sidebar: NSVisualEffectView;
	@IBOutlet var springboard: NSView;
	
	@IBOutlet var springboardWidthConstraint: NSLayoutConstraint;
	@IBOutlet var springboardHeightConstraint: NSLayoutConstraint;
	
	@IBOutlet var _connectView: VLNConnectView;
	@IBOutlet var _deviceSelectionView: VLNDeviceSelectionView;
	
	var connectView: VLNConnectView
	{
		get
		{
			if (!self._connectView) {
				self.instantiateViewFromNib("VLNConnectView");
				self.connectView.translatesAutoresizingMaskIntoConstraints = false;
			}
			
			return self._connectView;
		}
	}
	
	var deviceSelectionView: VLNDeviceSelectionView
	{
		get
		{
			if (!self._deviceSelectionView) {
				self.instantiateViewFromNib("VLNDeviceSelectionView");
				self.deviceSelectionView.translatesAutoresizingMaskIntoConstraints = false;
			}
			
			return self._deviceSelectionView;
		}
	}
	
// MARK: Helpers
	
	func instantiateViewFromNib(name:String)
	{
		var nib = NSNib(nibNamed:name, bundle: nil);
		nib.instantiateWithOwner(self, topLevelObjects: nil);
	}
	
// MARK: Connect To Device View
	
	func showConnectToDeviceView()
	{
		if (self.connectView.superview != self.contentView as NSView)
		{
			self.contentView.addSubview(self.connectView);
			
			var views: Dictionary<String, NSView> = ["connectView": self.connectView];
			self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[connectView]|", options: nil, metrics: nil, views: views));
			self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[connectView]|", options: nil, metrics: nil, views: views));
		}
		
		self.connectView.updateConstraints();
		
		self.hideDeviceSelectionView();
	}
	
	func hideConnectToDeviceView()
	{
		self.connectView.removeFromSuperview();
	}
	
// MARK: Multiple Device Selection
	
	func showDeviceSelectionView(delegate:VLNDeviceSelectionDelegate? = nil)
	{
		if (self.deviceSelectionView.superview != self.contentView as NSView)
		{
			self.contentView.addSubview(self.deviceSelectionView);
			
			var views: Dictionary<String, NSView> = ["deviceSelectionView": self.deviceSelectionView];
			self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[deviceSelectionView]|", options: nil, metrics: nil, views: views));
			self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[deviceSelectionView]|", options: nil, metrics: nil, views: views));
		}
		
		self.deviceSelectionView.delegate = delegate;
		self.deviceSelectionView.updateConstraints();
		
		self.hideConnectToDeviceView();
	}
	
	func hideDeviceSelectionView()
	{
		self.deviceSelectionView.removeFromSuperview();
	}
	
// MARK: Springboard
	
	func showSpringboard()
	{
		self.hideDeviceSelectionView();
		self.hideConnectToDeviceView();
		/*
		self.springboardHeightConstraint.constant = 600;
		self.springboardWidthConstraint.constant = 600;
		
		self.updateConstraintsIfNeeded();
		*/
	}
}
