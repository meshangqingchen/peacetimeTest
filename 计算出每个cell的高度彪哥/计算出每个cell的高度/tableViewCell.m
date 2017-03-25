//
//  tableViewCell.m
//  计算出每个cell的高度
//
//  Created by 3D on 16/5/12.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "tableViewCell.h"
#import "Masonry.h"
@implementation tableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        static int a = 0;
        NSLog(@"a====%d",a++);
        self.textLb = [[UILabel alloc]init];
        self.textLb.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.textLb];
//        self.textLb.numberOfLines = 0;
    }
    return self;
}

-(void)setStrIng:(NSString *)strIng{
    
    NSLog(@"1");
    _strIng = strIng;
    self.textLb.text = strIng;
    self.textLb.font = [UIFont systemFontOfSize:17];
    self.textLb.numberOfLines = 0;
//    NSLog(@"=================1111%@",NSStringFromCGRect(self.textLb.frame));

    [self setNeedsUpdateConstraints];
//    NSLog(@"=================2222%@",NSStringFromCGRect(self.textLb.frame));
}

-(void)updateConstraints{
    NSLog(@"2");
    [self.textLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
    }];
    
    
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.textLb.preferredMaxLayoutWidth = w - 20;
    
    [super updateConstraints];
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    NSLog(@"2");
//    [self.textLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(10);
//        //        make.bottom.mas_equalTo(-10);
//    }];
//
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    // 应该始终要加上这一句
//    // 不然在6/6plus上就不准确了
//    self.textLb.preferredMaxLayoutWidth = w - 20;
//    
//}
//
-(CGFloat)cellHeghit{
    NSLog(@"3");
    [self layoutIfNeeded];// 在view在自界面上之前布局好
    return  self.textLb.frame.size.height+10;
}


@end
