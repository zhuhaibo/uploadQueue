//
//  XYLoadCell.h
//  AntsSportApp
//
//  Created by zidane on 16/6/20.
//  Copyright © 2016年 Xiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYLoadModel.h"

static NSString *LoadCellIdentifier = @"LoadCellIdentifier";

static int LOADCELL_HEIGHT = 46;
static int LOADCELL_HEIGHT_BUTTON_WIDTH = 20, LOADCELL_HEIGHT_BUTTON_HEIGHT = 20;;

@interface XYLoadCell : UITableViewCell
@property (nonatomic, strong) XYLoadModel *model;
@property (nonatomic, copy) void (^reloadBlock) (XYLoadCell *cell, XYLoadModel *item) ;
@property (nonatomic, copy) void (^cancelBlock) (XYLoadCell *cell, XYLoadModel *item);
@end
