//
//  ViewController.m
//  聊天界面qq微信
//
//  Created by 3D on 17/1/26.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "LeftCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITextView *textView;

@end

static CGFloat view_H = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = [UITextView new];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.backgroundColor = [UIColor yellowColor];
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(20);
        make.height.mas_equalTo(40);
        make.right.mas_offset(-60);
    }];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LeftCell class] forCellReuseIdentifier:@"leftCell"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.bottom.mas_equalTo(self.textView.mas_top).mas_equalTo(0);
    }];
    
    view_H = self.view.frame.size.height;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(changeKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)openKeyBoard:(NSNotification *)notification{

}

-(void)closeKeyboard:(NSNotification *)notification{
    
}

-(void)changeKeyboard:(NSNotification *)notification{
    
    NSLog(@"%@",notification);
    CGFloat keyBoard_Y =  [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 从通知的userInfo中取得动画的时长
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-(view_H-keyBoard_Y));
    }];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view setNeedsLayout];
    } completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.textView resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView{

    NSLog(@"%@====",textView.text);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];

    CGRect  rect =   [textView.text boundingRectWithSize:CGSizeMake(view_H-80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    NSLog(@"========%@",NSStringFromCGRect(rect));
    if (rect.size.height>44 && rect.size.height < 80) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect.size.height);
        }];
    }
    
}
@end



