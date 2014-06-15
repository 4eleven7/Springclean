//
//  iMDVLNDevice.h
//  iMobileDevice
//
//  Created by Daniel Love on 14/06/2014.
//  Copyright (c) 2014 Daniel Love. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iMDVLNDevice : NSObject

@property (nonatomic, readonly) NSString *udid;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *productType;
@property (nonatomic, readonly) NSColor *deviceColor;
@property (nonatomic, readonly) NSImage *wallpaper;
@property (nonatomic, readonly) CGFloat screenHeight;
@property (nonatomic, readonly) CGFloat screenWidth;
@property (nonatomic, readonly) CGFloat screenScaleFactor;

- (instancetype) initWithUDID:(NSString *)udid;

@end
