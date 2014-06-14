//
//  iMDVLNDevice.h
//  iMobileDevice
//
//  Created by Daniel Love on 14/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iMDVLNDevice : NSObject

@property (nonatomic, copy, readonly) NSString *udid;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *productType;
@property (nonatomic, strong, readonly) NSColor *deviceColor;
@property (nonatomic, readonly) CGFloat screenHeight;
@property (nonatomic, readonly) CGFloat screenWidth;
@property (nonatomic, readonly) CGFloat screenScaleFactor;


- (instancetype) initWithUDID:(NSString *)udid name:(NSString *)name productType:(NSString *)productType;

#pragma mark - Properties

- (id) getProperty:(NSString *)key inDomain:(NSString *)domain;

#pragma mark - Manual connection

- (BOOL) connect:(NSError **)error;
- (BOOL) disconnect:(NSError **)error;

@end
