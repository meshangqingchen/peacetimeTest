//
//  SDImageCache.m
//  对比
//
//  Created by 3D on 17/1/16.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "SDImageCache.h"
#import <UIKit/UIKit.h>

@interface AutoPurgeCache : NSCache
@end

@implementation AutoPurgeCache

- (id)init
{
    self = [super init];
    if (self) {
        // 创建一个 NSCache 当内存警告的时候自动执行 removeAllObjects 方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
}

@end

@interface SDImageCache ()

@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (strong, nonatomic) NSMutableArray *customPaths;
//@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end



@implementation SDImageCache
+ (SDImageCache *)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns {
    NSString *path = [self makeDiskCachePath:ns];
    
    NSLog(@"path = %@",path);

    return [self initWithNamespace:ns diskCacheDirectory:path];
}

- (id)initWithNamespace:(NSString *)ns diskCacheDirectory:(NSString *)directory {
    if (self = [super init]) {
    NSString *fullNamespace = [@"com.hackemist.SDWebImageCache." stringByAppendingString:ns];
        _memCache = [[AutoPurgeCache alloc]init];
        _memCache.name = fullNamespace;
        
    }
    return self;
}

-(NSString *)makeDiskCachePath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"paths = %@",paths);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}
@end
