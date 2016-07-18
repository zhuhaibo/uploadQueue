//
//  ViewController.m
//  updataQueue
//
//  Created by zidane on 16/6/17.
//  Copyright © 2016年 Ants. All rights reserved.
//

#import "ViewController.h"
#import "LoadTool.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *imageArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(uploadStart) userInfo:nil repeats:YES];
//    [timer fire];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 200, 100, 100)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [[LoadTool share] addObserver:self forKeyPath:@"queue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)click {
    LoadItem *item = [[LoadItem new] loadWithTitle:[NSString stringWithFormat:@"%d", arc4random() % 123] image:[UIImage imageNamed:@"Icon_40"] processing:^(double percent, NSError *error, BOOL *stop, BOOL success) {
        
    } success:^(LoadItem* item){
        
    } failure:^(LoadItem* item, NSError *error){
        
    }];
    
    LoadTool *some = [LoadTool share];
    [some addQueue:item];
}

- (void)uploadStart {
    LoadItem *item = [[LoadItem new] loadWithTitle:[NSString stringWithFormat:@"%d", arc4random() % 123] image:nil processing:^(double percent, NSError *error, BOOL *stop, BOOL success) {
        
    } success:^(LoadItem* item){
        
    } failure:^(LoadItem* item, NSError *error){
    
    }];
    
    LoadTool *some = [LoadTool share];
    [some addQueue:item];
}

- (void)cancelTool:(UIButton*)btn {
    NSInteger tag = btn.tag;
    if (([LoadTool share].queue.count - tag) > 0) {
        if ([[LoadTool share].queue containsObject:[[LoadTool share].queue objectAtIndex:tag]]) {
            [[LoadTool share].queue removeObjectAtIndex:tag];
            NSLog(@"btn.tag == %ld", btn.tag);
        }
    }
}

#pragma mark -NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [LoadTool share].queue.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(200, 0, 40, 40)];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelTool:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexPath.row;
        [button setBackgroundColor:[UIColor redColor]];
        [cell.contentView addSubview:button];
    }
    LoadItem *item = [LoadTool share].queue[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

@end
