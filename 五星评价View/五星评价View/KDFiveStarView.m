//
//  KDFiveStarView.m
//  PetAnimals
//
//  Created by mac on 2016/11/23.
//  Copyright © 2016年 petle. All rights reserved.
//

#import "KDFiveStarView.h"

@interface KDFiveStarView ()

@property (nonatomic, copy) NSString *selectedImgName;
@property (nonatomic, copy) NSString *unselectImgName;
@property (nonatomic, assign, readwrite) int count;
@property (nonatomic, assign) BOOL canChangeStarNum;
@property (nonatomic, assign) CGFloat starWH;
@property (nonatomic, assign) CGFloat starPadding;

@property (nonatomic, strong) UIImageView *starIv1;
@property (nonatomic, strong) UIImageView *starIv2;
@property (nonatomic, strong) UIImageView *starIv3;
@property (nonatomic, strong) UIImageView *starIv4;
@property (nonatomic, strong) UIImageView *starIv5;
@property (nonatomic, strong) UIView *starBgView;
@end

@implementation KDFiveStarView



- (instancetype)initWithStarSelectedImgName:(NSString *)selectedImgName
                            unselectImgName:(NSString *)unselectImgName
                                     starWH:(CGFloat)starWH
                                starPadding:(CGFloat)starPadding
{
    self = [super init];
    if (self) {
        
        _count = -1;
        
        _starWH = starWH;
        _starPadding = starPadding;
        
        _selectedImgName = selectedImgName;
        _unselectImgName = unselectImgName;
        
        [self setupViews];
        
    }
    return self;
}

- (void)setupViews
{
    _starBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _starWH * 5 + _starPadding * 4, _starWH)];
    _starBgView.backgroundColor = [UIColor whiteColor];
    
    _starIv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unselectImgName]];
    _starIv1.frame = CGRectMake(0, 0, _starWH, _starWH);
    
    _starIv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unselectImgName]];
    _starIv2.frame = CGRectMake(_starWH + _starPadding, 0, _starWH, _starWH);
    
    _starIv3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unselectImgName]];
    _starIv3.frame = CGRectMake((_starWH + _starPadding) * 2, 0, _starWH, _starWH);
    
    _starIv4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unselectImgName]];
    _starIv4.frame = CGRectMake((_starWH + _starPadding) * 3, 0, _starWH, _starWH);
    
    _starIv5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_unselectImgName]];
    _starIv5.frame = CGRectMake((_starWH + _starPadding) * 4, 0, _starWH, _starWH);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addSubview:_starBgView];
    [_starBgView addSubview:_starIv1];
    [_starBgView addSubview:_starIv2];
    [_starBgView addSubview:_starIv3];
    [_starBgView addSubview:_starIv4];
    [_starBgView addSubview:_starIv5];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_starBgView];
    
    if (CGRectContainsPoint(_starBgView.bounds, point)) {
        _canChangeStarNum = YES;
        [self changeStarForegroundViewWithPoint:point];
    }else{
        _canChangeStarNum = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_canChangeStarNum) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:_starBgView];
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_canChangeStarNum) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:_starBgView];
        [self changeStarForegroundViewWithPoint:point];
    }
    _canChangeStarNum = NO;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    int count = 0;
    
    count = count + [self changeImg:point.x imageView:_starIv1];
    count = count + [self changeImg:point.x imageView:_starIv2];
    count = count + [self changeImg:point.x imageView:_starIv3];
    count = count + [self changeImg:point.x imageView:_starIv4];
    count = count + [self changeImg:point.x imageView:_starIv5];
    
    if (count == 0) {
        [_starIv1 setImage:[UIImage imageNamed:_unselectImgName]];
    }
    
    self.count = count;
}

-(int)changeImg:(CGFloat)x imageView:(UIImageView *)imageView
{
    if(x > imageView.frame.origin.x)
    {
        [imageView setImage:[UIImage imageNamed:_selectedImgName]];
        return 1;
    }
    else
    {
        [imageView setImage:[UIImage imageNamed:_unselectImgName]];
        return 0;
    }
}

- (void)setCount:(int)count
{
    _count = count;
    
    !_KDFiveStarViewResult ?: _KDFiveStarViewResult(count);
}

- (void)setStarDisabledAndCount:(int)count
{
    self.userInteractionEnabled = NO;
    
    CGFloat x = count * (_starWH + _starPadding) - _starPadding;
    
    [self changeImg:x imageView:_starIv1];
    [self changeImg:x imageView:_starIv2];
    [self changeImg:x imageView:_starIv3];
    [self changeImg:x imageView:_starIv4];
    [self changeImg:x imageView:_starIv5];
}

@end
