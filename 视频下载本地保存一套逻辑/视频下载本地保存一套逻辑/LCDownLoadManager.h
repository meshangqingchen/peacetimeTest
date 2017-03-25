//
//  LCDownLoadManager.h
//  3D打印教育
//
//  Created by 3D on 16/12/24.
//  Copyright © 2016年 3D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSSessionModel.h"
@interface LCDownLoadManager : NSObject
- (void)download:(NSString *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;

@end
