//
//  MCMastorBoard.m
//  MCScrollCard
//
//  Created by mac on 15/9/18.
//  Copyright © 2015年 mc. All rights reserved.
//

#import "MCMastorBoard.h"
#import "MCScrollBoard.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "MCPlanModel.h"
#import "MCBlurImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define MC_CHANGE_BACKGROUND_IMG_DEBUG 0

@interface MCMastorBoard ()<MCScrollBoardDelegate>{
    MCPlanModel *_justModel;
}

@property (nonatomic,strong) MCBlurImageView *blurImgView; //模糊曾
@property (nonatomic,strong,nonnull)  MCScrollBoard* scBoard;//滚动图
@end
@implementation MCMastorBoard

-(instancetype)init{
    if (self = [super init]) {
        
        //设置模糊层
        _blurImgView = [[MCBlurImageView alloc] init];
        
        [self addSubview:_blurImgView];
       
        [_blurImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self);
        }];
        _blurImgView.image = [UIImage imageNamed:@"jobroadbg_default"];
        
        
        
        
        
        _scBoard = [[MCScrollBoard alloc] init];
        
        _scBoard.mdelegate = self;
        [self addSubview:_scBoard];
        
        [_scBoard mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(60);
//            make.left.equalTo(self).with.offset(20);
//            make.right.equalTo(self).with.offset(-20);
//            make.bottom.equalTo(self).with.offset(0);
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(0);
            
        }];

    }
    return self;
}


-(void)setDataArr:(NSArray *)dataArr responseClickDelegate:(id<MCCardBoardTouchClickDelegate>)delegate{
    
    [_scBoard setDataArr:dataArr responseClickDelegate:delegate];//这里的delegate是viewController
}

#pragma mark - changeDelegate
-(void)changeBackgroundImg:(id)data{
    //LSLog(@"调用了0");
    if ([data isKindOfClass:[MCPlanModel class]]&&_justModel!=data) {
        LSLog(@"调用了1");
        MCPlanModel *model = data;
        
        [_blurImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"jobroadbg_default"]];
        _justModel = data;
    }
#if MC_CHANGE_BACKGROUND_IMG_DEBUG
    _blurImgView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",data]];
#endif
}

/**
 * 滚动视图的contentoffset
 */
-(CGPoint)contentOffset{
    return _scBoard.contentOffset;
}
@end
