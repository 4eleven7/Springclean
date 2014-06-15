//
//  iMDVLNDeviceManager.h
//  iMobileDevice
//
//  Created by Daniel Love on 14/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

#import <Foundation/Foundation.h>

@class iMDVLNDevice;

@interface iMDVLNDeviceManager : NSObject

@property (nonatomic, readonly, getter=isSubscribed) BOOL subscribed;

+ (instancetype) sharedManager;

- (BOOL) subscribeForNotifications:(NSError **)error;

- (BOOL) unsubscribeForNotifications:(NSError **)error;

- (NSArray *)devices;

- (id) getDeviceProperty:(id)device forKey:(NSString *)key inDomain:(NSString *)domain error:(NSError **)error;

@end
