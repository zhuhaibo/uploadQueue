//
//  XYExtensionHeaderView.m
//  AntsSportApp
//
//  Created by zidane on 16/6/20.
//  Copyright © 2016年 Xiaoyi. All rights reserved.
//

#import "XYExtensionHeaderView.h"
#import "XYLoadCell.h"
#import "XYLoadModel.h"

@interface XYExtensionHeaderView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation XYExtensionHeaderView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        _dataArray = [NSMutableArray arrayWithCapacity:42];
        [self registerClass:[XYLoadCell class] forCellReuseIdentifier:LoadCellIdentifier];
        [self setEstimatedRowHeight:EXTENSION_CELLHEIGHT];
    }
    return self;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellIdentifier forIndexPath:indexPath];
    cell.cancelBlock = ^(XYLoadCell *cell, XYLoadModel *model) {
        
    };
    cell.reloadBlock = ^(XYLoadCell *cell, XYLoadModel *model) {
        
    };
    XYLoadModel *model = _dataArray[indexPath.row];
    [cell setModel:model];
    return nil;
}

@end
