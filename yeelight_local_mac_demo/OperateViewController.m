//
//  OperateViewController.m
//  yeelight_local_mac_demo
//
//  Created by Tony Peng on 16/6/6.
//  Copyright © 2016年 Tony Peng. All rights reserved.
//

#import "OperateViewController.h"
#import "Device.h"
@interface OperateViewController ()
@property (weak) IBOutlet NSButton *lightSwitch;
@property (weak) IBOutlet NSTextField *ctLabel;
@property (weak) IBOutlet NSSlider *ctSlider;
@property (weak) IBOutlet NSTextField *colorLabel;
@property (weak) IBOutlet NSSlider *colorSlider;
@end

@implementation OperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.device = self.representedObject;
    [self.lightSwitch setState: @(self.device.isOn).integerValue];
    if ([self.device.model isEqualToString:@"mono"]) {
        [self hide];
    }
    if (![self.device connect]) {
        NSLog(@"some things err");
        [self dismissViewController:self];
    }
}

- (void)hide{
    self.ctLabel.hidden = YES;
    self.ctSlider.hidden = YES;
    self.colorLabel.hidden = YES;
    self.colorSlider.hidden = YES;
}

- (IBAction)powerChange:(id)sender {
    NSButton *btn = (NSButton *)sender;
    [self.device swichtLight: btn.state == 1 ? YES:NO];
}

- (IBAction)dismiss:(id)sender {
    [self.device disconnect];
    [self dismissViewController:self];
}

- (IBAction)brightnessChange:(id)sender {
    NSSlider *slider = (NSSlider *)sender;
    [self.device changeBrightness:slider.integerValue];
}

- (IBAction)ctChange:(id)sender {
    NSSlider *slider = (NSSlider *)sender;
    [self.device changeCT:slider.integerValue];
}
- (IBAction)colorChange:(id)sender {
    NSSlider *slider = (NSSlider *)sender;
    [self.device changeColor:slider.integerValue];
}

@end
