//
//  HTStorageSpaceView.m
//  ceshi默认文件夹
//
//  Created by 3D on 16/12/27.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "HTStorageSpaceView.h"

@interface HTStorageSpaceView()

@property (nonatomic, strong) UIImageView *progressImg;
@property (nonatomic, strong) UIImageView *trackImg;
/**
 *  空间所剩标签展示
 */
@property (nonatomic, strong) UILabel *progressLable;
@end

@implementation HTStorageSpaceView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _progressImg           = [[UIImageView alloc]init];
        _trackImg              = [[UIImageView alloc]init];
        
        _progressImg.image     = [self createImageWithColor:[UIColor redColor]];
        _trackImg.image        = [self createImageWithColor:[UIColor yellowColor]];
        
        _progressLable         = [[UILabel alloc]init];
        _progressLable.font    = [UIFont systemFontOfSize:12];
        _progressLable.textColor =  [UIColor grayColor];
        
        
        _progressLable.textAlignment = NSTextAlignmentCenter;
        
        [self loadSpaceWishFrame:frame];
        
        [self addSubview:_progressImg];
        [self addSubview:_trackImg];
        [self addSubview:_progressLable];
    }
    return self;
}
/**
 *  加载剩余空间
 */
- (void)loadSpaceWishFrame:(CGRect)frame{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    //总空间
    float   space     =   [[fattributes objectForKey:NSFileSystemSize] floatValue];
    //所剩空间
    float   freespace =   [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    
    
    float free_m  =  freespace / 1024 / 1024 / 1024;
    float space_m =  space / 1024 / 1024 / 1024;
    float proportion = free_m / space_m;
    
    
    _progressImg.frame      = CGRectMake(0, 0,(1 - proportion) * frame.size.width, frame.size.height);
    _trackImg.frame         = CGRectMake((1 - proportion) * frame.size.width , 0, self.frame.size.width - (1 - proportion) * frame.size.width , frame.size.height);
    _progressLable.text     = [NSString stringWithFormat:@"总空间%.1fG/剩余%.1fG",space_m,free_m];
    _progressLable.frame    = CGRectMake(0, 0, self.frame.size.width, frame.size.height -2);
    
}
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
