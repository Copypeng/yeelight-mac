//
//  Model.h
//  yeelight_local_mac_demo
//
//  Created by Tony Peng on 16/6/5.
//  Copyright © 2016年 Tony Peng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"

@interface Socket : NSObject
+ (instancetype) sharedInstance;
+ (instancetype) alloc  __attribute__((unavailable("alloc not available, call sharedInstance instead")));
- (instancetype) init   __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new    __attribute__((unavailable("new not available, call sharedInstance instead")));
- (void)searchDevice;
- (NSDictionary *)getDevices;
- (BOOL)connect:(Device *)device;
- (void)disconnect;
- (void)sendDataToDevice:(NSMutableDictionary *)data;
@end
