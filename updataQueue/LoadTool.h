//
//  LoadTool.h
//  updataQueue
//
//  Created by zidane on 16/6/17.
//  Copyright © 2016年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LoadItem;

typedef void(^ProcessBlock)(double percent, NSError *error, BOOL *stop, BOOL success);
typedef void(^ProcessSuccess)(LoadItem *item);
typedef void(^ProcessFailure)(LoadItem *item, NSError *error);

@interface LoadItem : NSObject
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, assign, readonly) double process;

- (instancetype)loadWithTitle:(NSString*)title
                image:(UIImage*)image
           processing:(ProcessBlock)process
              success:(ProcessSuccess)success
              failure:(ProcessFailure)failure;
@end

@interface LoadTool : NSObject
@property (nonatomic, strong, readonly) NSMutableArray *queue;

+ (instancetype)share;
- (void)addQueue:(LoadItem*)tool;
@end
