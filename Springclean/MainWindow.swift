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
	@IBOutlet var springboard: VLNSpringboardContainer;
	
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
		
		self.animateWindowToSize();
		
		self.hideDeviceSelectionView();
	}
	
	func hideConnectToDeviceView(animate: Bool = false)
	{
		if (!animate)
		{
			self.connectView.removeFromSuperview();
			return;
		}
		
		NSAnimationContext.beginGrouping();
		NSAnimationContext.currentContext().duration = 0.3;
		NSAnimationContext.currentContext().completionHandler = { self.hideConnectToDeviceView(); };
		
		self.connectView.animator().alphaValue = 0.0;
		
		NSAnimationContext.endGrouping();
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
		
		self.animateWindowToSize();
		
		self.hideConnectToDeviceView();
	}
	
	func hideDeviceSelectionView(animate: Bool = false)
	{
		if (!animate)
		{
			self.deviceSelectionView.removeFromSuperview();
			return;
		}
		
		NSAnimationContext.beginGrouping();
		NSAnimationContext.currentContext().duration = 0.3;
		NSAnimationContext.currentContext().completionHandler = { self.hideDeviceSelectionView(); };
		
		self.deviceSelectionView.animator().alphaValue = 0.0;
		
		NSAnimationContext.endGrouping();
	}
	
// MARK: Springboard
	
	func showSpringboard(device: VLNDevice)
	{
		if(self.springboard.device === device) {
			return;
		}
		
		var canRotate:Bool = device.classification == VLNDeviceClass.iPad;
		var deviceSize:VLNDeviceSize = device.size.scaled(canRotate:canRotate)
		
		self.springboard.device = device;
		
		self.animateWindowToSize(size:deviceSize, onResized:
		{
			self.hideDeviceSelectionView(animate: true);
			self.hideConnectToDeviceView(animate: true);
			return;
			var time: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)));
			dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
				self.springboard.resizedAndReadyToDisplay();
			});
		});
	}
	
	func animateWindowToSize(size: VLNDeviceSize = VLNDeviceSize(width: 400, height: 600, scaleFactor: 1.0), onResized:(() -> Void) = {})
	{
		NSAnimationContext.beginGrouping();
		NSAnimationContext.currentContext().duration = 0.1;
		
		self.springboardHeightConstraint.animator().constant = size.height / size.scaleFactor;
		
			NSAnimationContext.beginGrouping();
			NSAnimationContext.currentContext().duration = 0.3;
			NSAnimationContext.currentContext().completionHandler = onResized;
			self.springboardWidthConstraint.animator().constant = size.width / size.scaleFactor;
			NSAnimationContext.endGrouping();
		
		NSAnimationContext.endGrouping();
	}
}
