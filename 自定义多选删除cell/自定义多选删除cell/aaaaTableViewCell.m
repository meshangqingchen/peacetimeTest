//
//  aaaaTableViewCell.m
//  自定义多选删除cell
//
//  Created by 3D on 16/4/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "aaaaTableViewCell.h"

@implementation aaaaTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
}


- (void)selectAction:(id)sender {
    
    if (!_customSelected) {
        _customSelected = YES;
        [self.btnSelect setTitle:@"🔴" forState:UIControlStateNormal];
    }else
    {
        _customSelected = NO;
        [self.btnSelect setTitle:@"⭕️" forState:UIControlStateNormal];
    }
    !_customSelectedBlock ?: _customSelectedBlock(_customSelected, _row);
    
}


//- (void)selectAction:(id)sender{
//
//
//    _customSelected = !_customSelected;
//    if ([self.btnSelect.titleLabel.text isEqualToString:@"⭕️"]) {
//        [self.btnSelect setTitle:@"🔴" forState:UIControlStateNormal];
//        
//    }else{
//        [self.btnSelect setTitle:@"⭕️" forState:UIControlStateNormal];
//    }
//    !_customSelectedBlock ?: _customSelectedBlock(_customSelected, _row);
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        self.backgroundView = backgroundView;
        self.contentView.backgroundColor = [UIColor greenColor];
        self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSelect.frame = CGRectMake( 0, 2, 40, 40);
        self.btnSelect.backgroundColor = [UIColor clearColor];
        [backgroundView addSubview:self.btnSelect];
        [self.btnSelect setTitle:@"⭕️" forState:UIControlStateNormal];
        self.btnSelect.titleLabel.font = [UIFont systemFontOfSize:20];
        self.btnSelect.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [self.btnSelect addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        self.textLB = [[UILabel alloc]init];
        [self.contentView addSubview:self.textLB];
        
        self.textLB.frame = CGRectMake(2, 2, 200,40);
        self.textLB.backgroundColor = [UIColor yellowColor];
        
    }
    return self;
}


@end
