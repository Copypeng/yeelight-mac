//
//  ViewController.m
//  yeelight_local_mac_demo
//
//  Created by Tony Peng on 16/6/3.
//  Copyright © 2016年 Tony Peng. All rights reserved.
//

#import "ViewController.h"
#import "OperateViewController.h"
#import "Socket.h"
#import "Device.h"
@interface ViewController()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *tableView;
@property (strong,nonatomic)NSArray *dataSource;
@property (weak) IBOutlet NSProgressIndicator *loading;
@property (weak) IBOutlet NSTextField *tips;
@property (strong,nonatomic)Device *selectDevice;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.dataSource = @[];
    [self.loading startAnimation:nil];
    self.tips.hidden = YES;
    [[Socket sharedInstance] searchDevice];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(getDevices) userInfo:nil repeats:NO];
}

- (void)getDevices{
    NSDictionary *devices = [[Socket sharedInstance] getDevices];
    self.dataSource = [devices allValues];
    [self.tableView reloadData];
    [self.loading stopAnimation:nil];
    [self.loading removeFromSuperview];
    self.loading = nil;
    if (self.dataSource.count< 1) {
        self.tips.hidden = NO;
    }
}

- (void)viewWillAppear{
    [super viewWillAppear];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


#pragma mark -- tableview delegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataSource.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    Device *device = [self.dataSource objectAtIndex:row];
    NSString *content=@"";
    NSString *cellIdentifier=@"";
    if (tableColumn == tableView.tableColumns[0]) {
        if ([device.model isEqualToString: @"color"]) {
            content = @"彩光灯泡";
        }else if ([device.model isEqualToString:@"mono"]){
            content = @"白光灯泡";
        }else{
            content = @"其他设备";
        }
        cellIdentifier = @"NameCellID";
    }else if(tableColumn == tableView.tableColumns[1]){
        cellIdentifier = @"DidID";
        content = [NSString stringWithFormat:@"%d",device.did];
    }else if (tableColumn == tableView.tableColumns[2]){
        cellIdentifier = @"ModelID";
        content = device.model;
    }else if (tableColumn == tableView.tableColumns[3]){
        cellIdentifier = @"LocationID";
        content = device.location;
    }
    NSTableCellView *view = [tableView makeViewWithIdentifier:cellIdentifier owner:nil];
    if (content) {
        view.textField.stringValue = content;
    }
    return view;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSTableView *tableView = notification.object;
    if (tableView.selectedRow > -1) {
        self.selectDevice = [self.dataSource objectAtIndex:tableView.selectedRow];
        [self performSegueWithIdentifier:@"openDevice" sender:self];
    }
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"openDevice"]) {
        NSViewController *vc = segue.destinationController;
        vc.representedObject = self.selectDevice;
    }
}


@end
