//
//  aaaaTableViewCell.h
//  自定义多选删除cell
//
//  Created by 3D on 16/4/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomSelectBlock)(BOOL selected, NSInteger row);



@interface aaaaTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *btnSelect;
@property (nonatomic, assign) NSInteger row;

//@property (nonatomic, strong) UIButton *btnSelect;

@property (nonatomic, getter=isCustomSelected) BOOL customSelected;

@property (nonatomic, copy) CustomSelectBlock customSelectedBlock;

@property(nonatomic,strong)UILabel *textLB;
@end
