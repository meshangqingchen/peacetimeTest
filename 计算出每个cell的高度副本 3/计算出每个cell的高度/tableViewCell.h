//
//  tableViewCell.h
//  计算出每个cell的高度
//
//  Created by 3D on 16/5/12.
//  Copyright © 2016年 3D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *textLb;
@property(nonatomic,strong)NSString *strIng;
-(CGFloat)cellHeghitWtihString:(NSString *)str;
@end
