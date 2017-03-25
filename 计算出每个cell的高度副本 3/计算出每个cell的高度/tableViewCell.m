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
//        static int a = 0;
//        NSLog(@"a====%d",a++);
        self.textLb = [[UILabel alloc]init];
        self.textLb.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.textLb];
        self.textLb.font = [UIFont systemFontOfSize:17];
        self.textLb.numberOfLines = 0;
        
        [self.textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            
            make.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

-(CGFloat)cellHeghitWtihString:(NSString *)str{

    NSMutableDictionary *attributes = @{}.mutableCopy;
    
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    // 宽度定死 能算出一个合适的高度
    // 高度定死 呢过算出一个合适的宽
    CGRect rect = [str boundingRectWithSize:CGSizeMake(self.frame.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attributes context:nil];
    
    
   
    
    
//   CGSize cellSize =  [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"==cellSize==%@",NSStringFromCGSize(cellSize));
    
    return rect.size.height+10;
}


//-(CGFloat)cellHeghit{
//    NSLog(@"3");
//    [self layoutIfNeeded];// 在展示到自界面上之前布局好(这是我自己的鉴定理解)
//    return  self.textLb.frame.size.height+10+20;
//}


@end
