//
//  LoadTool.m
//  updataQueue
//
//  Created by zidane on 16/6/17.
//  Copyright © 2016年 Ants. All rights reserved.
//

#import "LoadTool.h"

static LoadTool *some = nil;

@interface LoadItem ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) double process;
@property (nonatomic, strong) ProcessBlock processBlock;
@property (nonatomic, strong) ProcessSuccess successBlock;
@property (nonatomic, strong) ProcessFailure failureBlock;

@end

@implementation LoadItem
- (instancetype)loadWithTitle:(NSString*)title
                image:(UIImage*)image
           processing:(ProcessBlock)process
              success:(ProcessSuccess)success
              failure:(ProcessFailure)failure {
    _title = title;
    _image = image;
    _processBlock = process;
    _successBlock = success;
    _failureBlock = failure;
    
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        __strong typeof(self) strongself = weakself;
        strongself.process += .5f;
        NSLog(@"self == %@ time == %s", strongself, __TIME__);
    });

    return self;
}

@end

@interface LoadTool ()
@property (nonatomic, strong) NSMutableArray *queue;
@property (nonatomic, strong) NSSet *runLoopModes;
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation LoadTool
+ (instancetype)share {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        some = [[self alloc] init];
    });
    return some;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        some = [super allocWithZone:zone];
        some.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
        some.queue = [NSMutableArray array];
        some.lock = [NSRecursiveLock new];
    });
    return some;
}

- (id)copy {
    return some;
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"ZIDANE.COM.LOADTOOL"];
        [[NSThread currentThread] setThreadPriority:NSQualityOfServiceUserInteractive];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runloop run];
    }
}

+ (NSThread*)networkRequestThread {
    static NSThread *_networkRequestThread;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    return _networkRequestThread;
}

#pragma mark - Private
- (void)addQueue:(LoadItem*)tool {
    // 开启runloop
    [self performSelector:@selector(operationDidStart:error:) onThread:[[self class] networkRequestThread] withObject:tool waitUntilDone:NO modes:[self.runLoopModes allObjects]];
}

- (NSMutableArray *)queue {
    return _queue ?: [NSMutableArray array];;
}

//
- (void)operationDidStart:(LoadTool*)tool error:(NSError*)error {
    [_lock lock];
    if (_queue.count >= 3) {
        return;
    }
    if (![[self mutableArrayValueForKey:@"queue"] containsObject:tool]) {
        [[self mutableArrayValueForKey:@"queue"] addObject:tool];
        NSLog(@"current thread is %@", [NSThread currentThread]);
    }
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    for (NSString *runLoopMode in self.runLoopModes) {
//        
//    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        LoadItem *item = ((LoadItem*)[self.queue firstObject]);
//        if ([[self mutableArrayValueForKey:@"queue"] containsObject:item]) {
//            item.successBlock(item);
//            [[self mutableArrayValueForKey:@"queue"] removeObject:item];
//        }
    });
    [_lock unlock];
}

@end
