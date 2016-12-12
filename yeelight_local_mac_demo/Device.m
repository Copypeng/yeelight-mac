//
//  Device.m
//  yeelight_local_mac_demo
//
//  Created by Tony Peng on 16/6/5.
//  Copyright © 2016年 Tony Peng. All rights reserved.
//

#import "Device.h"
#import "Socket.h"
@interface Device()
@end

@implementation Device

- (BOOL)connect{
    return [[Socket sharedInstance] connect:self];
}

- (void)disconnect{
    [[Socket sharedInstance] disconnect];
}

- (void)swichtLight:(BOOL)isOn{
    NSString *power = @"off";
    if (isOn) {
        power = @"on";
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"set_power" forKey:@"method"];
    [dic setObject:@[power, @"smooth", @500] forKey:@"params"];
    [[Socket sharedInstance] sendDataToDevice:dic];
}

- (void)changeBrightness:(NSInteger)bright{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"set_bright" forKey:@"method"];
    [dic setObject:@[@(bright), @"smooth", @500] forKey:@"params"];
    [[Socket sharedInstance] sendDataToDevice:dic];
}

- (void)changeColor:(NSInteger)hue{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"set_hsv" forKey:@"method"];
    [dic setObject:@[@(hue), @100,@"smooth", @500] forKey:@"params"];
    [[Socket sharedInstance] sendDataToDevice:dic];
}

- (void)changeCT:(NSInteger)ct{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"set_ct_abx" forKey:@"method"];
    [dic setObject:@[@(ct),@"smooth", @500] forKey:@"params"];
    [[Socket sharedInstance] sendDataToDevice:dic];
}

- (void)setLocation:(NSString *)location{
    _location = location;
    NSArray *arr = [location componentsSeparatedByString:@":"];
    self.host = arr[0];
    self.port = [arr[1] integerValue];
}

@end
