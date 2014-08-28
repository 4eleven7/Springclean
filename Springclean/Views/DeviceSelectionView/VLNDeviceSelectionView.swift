//
//  VLNDeviceSelectionView.swift
//  Springclean
//
//  Created by Daniel Love on 09/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa

class VLNDeviceSelectionView: NSView, NSTableViewDataSource, NSTableViewDelegate
{
	@IBOutlet var tableView: NSTableView!;
	
	var delegate: VLNDeviceSelectionDelegate?
	{
		didSet
		{
			self.tableView.reloadData();
		}
	}
	
// MARK: NSTableViewDataSource
	func numberOfRowsInTableView(tableView: NSTableView!) -> Int
	{
		var numberOfDevices = 0
		if (self.delegate != nil) {
			numberOfDevices = self.delegate!.deviceSelectionViewNumberOfDevices(self);
		}
		return numberOfDevices;
	}
	
// MARK: NSTableViewDelegate
	func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView!
	{
		var view: NSView = tableView.makeViewWithIdentifier(tableColumn.identifier, owner: self) as NSView;
		
		return view;
	}
	
	func tableViewSelectionDidChange(aNotification: NSNotification!)
	{
		var tableView:NSTableView = aNotification.object as NSTableView;
		self.delegate?.deviceSelectionView(self, selectedIndex: tableView.selectedRow);
	}
}

protocol VLNDeviceSelectionDelegate
{
	func deviceSelectionView(view:VLNDeviceSelectionView!, selectedIndex:Int);
	func deviceSelectionViewNumberOfDevices(view:VLNDeviceSelectionView!) -> Int;
}