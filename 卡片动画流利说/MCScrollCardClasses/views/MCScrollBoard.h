//
//  MCScrollBoard.h
//  MCScrollCard
//
//  Created by mac on 15/9/15.
//  Copyright © 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCardBoardTouchClickDelegate.h"
typedef NS_ENUM(NSInteger,CardBoardStatus){
    CardBoardNone,
    CardBoardFromLeft = -1,
    CardBoardFromRight = 1
};

@class MCPlanModel;

@protocol MCScrollBoardDelegate <NSObject>

-(void)changeBackgroundImg:(nonnull id)data;//自己定义scrollView的协议

@end

@interface MCScrollBoard : UIScrollView <UIScrollViewDelegate>{
   
    NSMutableArray *_boards;//数组里面是每一个数组对象
    CardBoardStatus _cardBoardStauts;
    UIView      *_srvBoard;         ///<  撑开scrollviewcontentsize
    CGFloat _scrollviewSpeed;
    CGPoint _willScroContentOffset;
    NSInteger _befIndex;
    NSArray<MCPlanModel*> *_dataArr;
}


-(void)setDataArr:(nonnull NSArray<MCPlanModel*> *)dataArr responseClickDelegate:(nullable id<MCCardBoardTouchClickDelegate>)delegate;

@property (nonatomic,assign,nonnull) id<MCScrollBoardDelegate> mdelegate;
@end
