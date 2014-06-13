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
	var delegate: VLNDeviceSelectionDelegate?;
	
// MARK: NSTableViewDataSource
	func numberOfRowsInTableView(tableView: NSTableView!) -> Int
	{
		return 2;
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

@class_protocol protocol VLNDeviceSelectionDelegate
{
	func deviceSelectionView(view:VLNDeviceSelectionView!, selectedIndex:Int);
}