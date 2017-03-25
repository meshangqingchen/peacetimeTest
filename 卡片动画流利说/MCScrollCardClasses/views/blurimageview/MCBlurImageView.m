//
//  MCBlurImageView.m
//  imooc
//
//  Created by GJ on 15/10/26.
//  Copyright © 2015年 imooc. All rights reserved.
//

#import "MCBlurImageView.h"
#import "Masonry.h"

@interface MCBlurImageView ()
@property (nonatomic, weak) UIView *blurView; //iOS8+

@property (nonatomic, weak) UIView *cover; //iOS8以下

@property (nonatomic, strong) dispatch_queue_t blurImageQueue;
@end

@implementation MCBlurImageView

//重写设置这么多的初始化方法就看神马用哪一个初始化方法了
-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"0");
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        NSLog(@"1");
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self setup];
        NSLog(@"2");
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setup];
        NSLog(@"3");
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
    NSLog(@"4");
}




- (void)setup {
    
    _blurImageQueue = dispatch_queue_create("com.imooc.MCBlurImageView", NULL);//创建一个队列
    self.contentMode = UIViewContentModeScaleAspectFill;//图片把视图充满的样式
    self.clipsToBounds = YES;//是否限制与父视图的边界 就是如果有个view 加到自己身上 如果他比自己大，大的部分不显示就设置为yes
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.f) {
       
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
      
        [self addSubview:blurView];
        _blurView = blurView;
        [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
    } else {
        // 加模糊层的处理会导致tableView不刷新。原因待查。
        // 现对setImage方法进行重写，直接处理image
//        FXBlurView *blurView = [[FXBlurView alloc] init];
//        blurView.tintColor = [UIColor blackColor];
//        [self addSubview:blurView];
//        _blurView = blurView;
        
        // 遮盖层，防止太亮
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubview:cover];
        _cover = cover;
        
        [cover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
    }
}

/**
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    if (_blurView) _blurView.frame = self.bounds;
    if (_cover) _cover.frame = self.bounds;
}

//重写image的set方法
- (void)setImage:(UIImage *)image {
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.f) {
        NSLog(@"系统小于8.0");
        dispatch_async(_blurImageQueue, ^{
            UIImage *blurredImage = [self blur:image];
            if (blurredImage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [super setImage:blurredImage];
                });
            }
        });
    }
    else {
        NSLog(@"系统大于8.0");
        [super setImage:image];
    }
}


@end

static CIContext *_context;
@implementation MCBlurImageView(iOS7)
- (UIImage*) blur:(UIImage*)theImage{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    if (_context==nil) {
        _context = [CIContext contextWithOptions:nil];
    }
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [_context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
    
    // *************** if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}
@end
