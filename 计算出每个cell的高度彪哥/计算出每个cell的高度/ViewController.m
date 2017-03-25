//
//  ViewController.m
//  计算出每个cell的高度
//
//  Created by 3D on 16/5/12.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "tableViewCell.h"
@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)tableViewCell *textCell;
@end

@implementation ViewController

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"1",
                     @"2",
                     @"3不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的不不",
                     @"4asdasfsdfsdfsdfsdf",
                     @"5按时大大大叔的",
                     @"6按时大大的飒飒的",
                     @"7阿萨达是",
                     @"8撒大大大撒是打按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的算打算打打死",
                     @"9按时打算打算打按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的算的撒的撒",
                     @"10是vsfbvdfbvdffdggfgfdgdfgdfhdfsdfs",
                     @"11按时大大发方按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的法法国恢复恢复规划规划和规范公司的瑞特让他退",
                     @"12啊啊啊发斯蒂芬",
                     @"13爱上大沙发沙按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的发沙发沙发发发发",
                     @"14按时发发发发发生时",@"9按时打算打算打按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的算的撒的撒",
                     @"15是vsfbvdfbvdffdggfgfdgdfgdfhdfsdfs",
                     @"16按时大大发方按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的法法国恢复恢复规划规划和规范公司的瑞特让他退",
                     @"17啊啊啊发斯蒂芬",
                     @"18爱上大沙发沙按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的按时大大大叔的发沙发沙发发发发",
                     @"19按时发发发发发生时"];
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[tableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.strIng= self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //这里再下个model就可以吧高度写在model里面做缓存了。
    
    self.textCell.strIng = self.dataArr[indexPath.row];
//    NSLog(@"%f",[self.textCell cellHeghit]);
    return [self.textCell cellHeghit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textCell = [[tableViewCell alloc]initWithStyle:0 reuseIdentifier:@"asd"];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
