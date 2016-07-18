//
//  XYLoadCell.m
//  AntsSportApp
//
//  Created by zidane on 16/6/20.
//  Copyright © 2016年 Xiaoyi. All rights reserved.
//

#import "XYLoadCell.h"

@interface XYLoadCell ()
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation XYLoadCell
- (void)setItem:(XYLoadModel *)model {
    if (nil == model) {
        return;
    }
    _model = model;
    [self.imageView setImage:model.image];
    [self.textLabel setText:model.title];
    [_reloadButton setHidden:model.status == LoadFailuer];
    [_cancelButton setHidden:model.status == LoadFailuer];

    [model addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [model addObserver:self forKeyPath:@"process" options:NSKeyValueObservingOptionNew context:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    style = UITableViewCellStyleDefault;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self uiconfig];
        [self setEvent];
    }
    return self;
}

- (void)uiconfig {
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_reloadButton setFrame:CGRectMake(0, 0, LOADCELL_HEIGHT_BUTTON_WIDTH, LOADCELL_HEIGHT_BUTTON_HEIGHT)];
    [_cancelButton setFrame:CGRectMake(0, 0, LOADCELL_HEIGHT_BUTTON_WIDTH, LOADCELL_HEIGHT_BUTTON_HEIGHT)];
    
    [self.contentView addSubview:_progressView];
    [self.contentView addSubview:_reloadButton];
    [self.contentView addSubview:_cancelButton];
}

- (void)setEvent {
    [_reloadButton addTarget:self action:@selector(reloadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadButtonClicked {
    if (self.reloadBlock) {
        self.reloadBlock(self, _model);
    }
}

- (void)cancelButtonClicked {
    if (self.cancelBlock) {
        self.cancelBlock(self, _model);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        
    }else if ([keyPath isEqualToString:@"status"]) {
        
    }
}

@end
