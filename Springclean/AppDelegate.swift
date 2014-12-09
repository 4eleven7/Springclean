//
//  AppDelegate.swift
//  Springclean
//
//  Created by Daniel Love on 08/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

import Cocoa
import iMobileDevice

class AppDelegate: NSObject, NSApplicationDelegate, VLNDeviceSelectionDelegate
{
	@IBOutlet var window: MainWindow!;
	@IBOutlet var developerMenu: NSMenuItem!;
	
	var deviceManager: VLNDeviceManager!;
	var deviceConnector: VLNMobileDeviceConnector!;
	
	var mockDeviceManager: VLNMobileDeviceManagerMock!;

	override init()
	{
		self.deviceManager = VLNDeviceManager();
		
		super.init();
		
		enableDeveloperMenu(false);
	}
	
	deinit
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: VLNDeviceManagerDeviceListChangedNotification, object: nil);
	}
	
	func applicationDidFinishLaunching(aNotification: NSNotification?)
	{
		self.window.showConnectToDeviceView();
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceListChangedNotification:", name: VLNDeviceManagerDeviceListChangedNotification, object: nil);
	}
	
	func applicationWillTerminate(aNotification: NSNotification?)
	{
		// Insert code here to tear down your application
	}
	
	func deviceListChangedNotification(notification: NSNotification)
	{
		if (self.deviceManager.devices.count < 1)
		{
			self.window.showConnectToDeviceView();
		}
		else
		{
			if (self.deviceManager.devices.count >= 2 && self.deviceManager.selectedDevice == nil)
			{
				self.window.showDeviceSelectionView(delegate: self);
			}
			else
			{
				var device: VLNDevice? = self.deviceManager.selectedDevice;
				if (device == nil) {
					device = self.deviceManager.deviceAtIndex(0);
				}
				
				self.window.showSpringboard(device!);
			}
		}
	}
	
// MARK: VLNDeviceSelectionDelegate
	
	func deviceSelectionView(view: VLNDeviceSelectionView!, selectedIndex: Int)
	{
		if (selectedIndex < 0 && selectedIndex > self.deviceManager.devices.count) {
			return;
		}
		
		self.deviceManager.selectedDevice = self.deviceManager.deviceAtIndex(selectedIndex);
		self.window.showSpringboard(self.deviceManager.selectedDevice!);
	}
	
	func deviceSelectionViewNumberOfDevices(view:VLNDeviceSelectionView!) -> Int
	{
		return self.deviceManager.devices.count;
	}
	
// MARK: Developer actions
	
	func enableDeveloperMenu(debug:Bool)
	{
		if (self.mockDeviceManager == nil) {
			self.mockDeviceManager = VLNMobileDeviceManagerMock();
		}
		
		if (self.deviceConnector != nil)
		{
			// Do nothing, no changes
			var isCurrentlyDebug: Bool = (self.deviceConnector.deviceConnector === self.mockDeviceManager);
			if (debug == isCurrentlyDebug) {
				return
			}
		}
		
		if (debug == false) {
			self.deviceConnector = VLNMobileDeviceConnector(deviceManager: self.deviceManager, deviceConnector: iMDVLNDeviceManager.sharedManager());
		} else {
			self.deviceConnector = VLNMobileDeviceConnector(deviceManager: self.deviceManager, deviceConnector: self.mockDeviceManager);
		}

		self.deviceConnector.reloadDeviceList();
	}
	
	// MARK: IBActions
	
	@IBAction func displaySwitchDeviceMenu(sender: AnyObject)
	{
		self.window.springboard.device = nil;
		self.deviceManager.selectedDevice = nil;
		self.window.showDeviceSelectionView(delegate: self);
	}
	
	@IBAction func disconnectCurrentDevice(sender: AnyObject)
	{
		self.window.springboard.device = nil;
		self.deviceManager.selectedDevice = nil;
		
		if (self.deviceManager.devices.count >= 2) {
			self.window.showDeviceSelectionView(delegate: self);
		}
		else {
			self.window.showConnectToDeviceView();
		}
	}
	
	@IBAction func addSimulatediPhone(sender: AnyObject)
	{
		enableDeveloperMenu(true);
		
		var device:VLNMobileDeviceMock = self.mockDeviceManager.addSimulatedDevice(VLNDeviceType.iPhone5S_n53ap);
		self.mockDeviceManager.simulateDeviceAddedNotification(device.UDID);
	}
	
	@IBAction func addSimulatediPad(sender: AnyObject)
	{
		enableDeveloperMenu(true);
		var device:VLNMobileDeviceMock = self.mockDeviceManager.addSimulatedDevice(VLNDeviceType.iPadAir_j72ap);
		self.mockDeviceManager.simulateDeviceAddedNotification(device.UDID);
	}
	
	@IBAction func deleteSimulatedDevice(sender: AnyObject)
	{
		var device:VLNMobileDeviceMock? = self.mockDeviceManager.removeSimulatedDevice();
		if (device != nil) {
			self.mockDeviceManager.simulateDeviceRemovedNotification(device!.UDID);
		}
		
		if (self.mockDeviceManager.devices().count == 0) {
			enableDeveloperMenu(false);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// MARK: - Core Data stack

	lazy var applicationDocumentsDirectory: NSURL = {
	    // The directory the application uses to store the Core Data store file. This code uses a directory named "net.daniellove.Test" in the user's Application Support directory.
	    let urls = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
	    let appSupportURL = urls[urls.count - 1] as NSURL
	    return appSupportURL.URLByAppendingPathComponent("net.daniellove.Springclean")
	}()

	lazy var managedObjectModel: NSManagedObjectModel = {
	    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
	    let modelURL = NSBundle.mainBundle().URLForResource("Springclean", withExtension: "momd")
	    return NSManagedObjectModel(contentsOfURL: modelURL!)!
	}()

	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
	    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.) This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
	    let fileManager = NSFileManager.defaultManager()
	    var shouldFail = false
	    var error: NSError? = nil
	    var failureReason = "There was an error creating or loading the application's saved data."

	    // Make sure the application files directory is there
	    let propertiesOpt = self.applicationDocumentsDirectory.resourceValuesForKeys([NSURLIsDirectoryKey], error: &error)
	    if let properties = propertiesOpt {
	        if !properties[NSURLIsDirectoryKey]!.boolValue {
	            failureReason = "Expected a folder to store application data, found a file \(self.applicationDocumentsDirectory.path)."
	            shouldFail = true
	        }
	    } else if error!.code == NSFileReadNoSuchFileError {
	        error = nil
	        fileManager.createDirectoryAtPath(self.applicationDocumentsDirectory.path!, withIntermediateDirectories: true, attributes: nil, error: &error)
	    }
	    
	    // Create the coordinator and store
	    var coordinator: NSPersistentStoreCoordinator?
	    if !shouldFail && (error == nil) {
	        coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
	        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Springclean.storedata")
	        if coordinator!.addPersistentStoreWithType(NSXMLStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
	            coordinator = nil
	        }
	    }
	    
	    if shouldFail || (error != nil) {
	        // Report any error we got.
	        let dict = NSMutableDictionary()
	        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
	        dict[NSLocalizedFailureReasonErrorKey] = failureReason
	        if error != nil {
	            dict[NSUnderlyingErrorKey] = error
	        }
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
	        NSApplication.sharedApplication().presentError(error!)
	        return nil
	    } else {
	        return coordinator
	    }
	}()

	lazy var managedObjectContext: NSManagedObjectContext? = {
	    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
	    let coordinator = self.persistentStoreCoordinator
	    if coordinator == nil {
	        return nil
	    }
	    var managedObjectContext = NSManagedObjectContext()
	    managedObjectContext.persistentStoreCoordinator = coordinator
	    return managedObjectContext
	}()

	// MARK: - Core Data Saving and Undo support

	@IBAction func saveAction(sender: AnyObject!) {
	    // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
	    if let moc = self.managedObjectContext {
	        if !moc.commitEditing() {
	            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing before saving")
	        }
	        var error: NSError? = nil
	        if moc.hasChanges && !moc.save(&error) {
	            NSApplication.sharedApplication().presentError(error!)
	        }
	    }
	}

	func windowWillReturnUndoManager(window: NSWindow!) -> NSUndoManager! {
	    // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
	    if let moc = self.managedObjectContext {
	        return moc.undoManager
	    } else {
	        return nil
	    }
	}

	func applicationShouldTerminate(sender: NSApplication!) -> NSApplicationTerminateReply {
	    // Save changes in the application's managed object context before the application terminates.
	    
	    if let moc = managedObjectContext {
	        if !moc.commitEditing() {
	            NSLog("\(NSStringFromClass(self.dynamicType)) unable to commit editing to terminate")
	            return .TerminateCancel
	        }
	        
	        if !moc.hasChanges {
	            return .TerminateNow
	        }
	        
	        var error: NSError? = nil
	        if !moc.save(&error) {
	            // Customize this code block to include application-specific recovery steps.
	            let result = sender.presentError(error!)
	            if (result) {
	                return .TerminateCancel
	            }
	            
	            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
	            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
	            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
	            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
	            let alert = NSAlert()
	            alert.messageText = question
	            alert.informativeText = info
	            alert.addButtonWithTitle(quitButton)
	            alert.addButtonWithTitle(cancelButton)
	            
	            let answer = alert.runModal()
	            if answer == NSAlertFirstButtonReturn {
	                return .TerminateCancel
	            }
	        }
	    }
	    // If we got here, it is time to quit.
	    return .TerminateNow
	}}
