//
//  ViewController.m
//  自定义多选删除cell
//
//  Created by 3D on 16/4/11.
//  Copyright © 2016年 3D. All rights reserved.
//

#import "ViewController.h"
#import "aaaaTableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *titlebt;

@property(nonatomic,strong)NSMutableArray *selectRos;//选中的ros
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *selectData;//要删除的cell

@property(nonatomic,strong)UIButton *allSelectBt;

@end

@implementation ViewController


-(NSMutableArray *)selectRos{
    if (!_selectRos) {
        _selectRos = [[NSMutableArray alloc]init];
    }
    return _selectRos;
}


-(NSMutableArray *)data{
    if (!_data) {
        _data =[NSMutableArray arrayWithArray:@[@"科比·布莱恩特1",@"德里克·罗斯2",@"勒布朗·詹姆斯3",@"凯文·杜兰特4",@"德怀恩·韦德5",@"克里斯·保罗6",@"德怀特·霍华德7",@"德克·诺维斯基8",@"德隆·威廉姆斯9",@"斯蒂夫·纳什10",@"保罗·加索尔11",@"布兰顿·罗伊12",@"奈特·阿奇博尔德13",@"鲍勃·库西14",@"埃尔文·约翰逊15",@"科比·布莱恩特16",@"德里克·罗斯17",@"勒布朗·詹姆斯18",@"凯文·杜兰特19",@"德怀恩·韦德20",@"克里斯·保罗21",@"德怀特·霍华德22",@"德克·诺维斯基23",@"德隆·威廉姆斯24",@"斯蒂夫·纳什25",@"保罗·加索尔26",@"布兰顿·罗伊27",@"奈特·阿奇博尔德28",@"鲍勃·库西29",@"埃尔文·约翰逊30",@"科比·布莱恩特31",@"德里克·罗斯",@"勒布朗·詹姆斯",@"凯文·杜兰特",@"德怀恩·韦德",@"克里斯·保罗",@"德怀特·霍华德",@"德克·诺维斯基",@"德隆·威廉姆斯",@"斯蒂夫·纳什",@"保罗·加索尔",@"布兰顿·罗伊",@"奈特·阿奇博尔德",@"鲍勃·库西",@"埃尔文·约翰逊",@"科比·布莱恩特",@"德里克·罗斯",@"勒布朗·詹姆斯",@"凯文·杜兰特",@"德怀恩·韦德",@"克里斯·保罗",@"德怀特·霍华德",@"德克·诺维斯基",@"德隆·威廉姆斯",@"斯蒂夫·纳什",@"保罗·加索尔",@"布兰顿·罗伊",@"奈特·阿奇博尔德",@"鲍勃·库西",@"埃尔文·约翰逊"]];
    
    }
    return _data;
}


-(NSMutableArray*)selectData{
    if (!_selectData) {
        _selectData = [[NSMutableArray alloc]init];
    }
    return _selectData;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStylePlain];
    
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[aaaaTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = [UIColor yellowColor];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    aaaaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLB.text = self.data[indexPath.row];
    
    
    cell.row = indexPath.row;
    __weak typeof (self)waakself = self;
    cell.customSelectedBlock = ^(BOOL selected,NSInteger row){
        if (selected) {
            
                [waakself.selectRos addObject:@(row)];
                [waakself.selectData addObject:waakself.data[row]];

                NSLog(@"家里面");
                NSLog(@"%@",_selectRos);
           
            
        }else{
            [waakself.selectRos removeObject:@(row)];
            [waakself.selectData removeObject:waakself.data[row]];
        
            NSLog(@"删除");
            NSLog(@"%@",_selectRos);

        }
    
    };

    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(aaaaTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectRos containsObject:@(cell.row)]) {
        [cell.btnSelect setTitle:@"🔴" forState:UIControlStateNormal];
       cell.customSelected = YES; //当第一点击的时候 变成🔴 但是上下滑动 只保证第一个是🔴但并不是相同的一个cell 他跑到了下面 他的customSelected 是yes但是它得是NO 才能保证block里面正确。els下面让他变成no
        
    }else
    {
        [cell.btnSelect setTitle:@"⭕️" forState:UIControlStateNormal];
        cell.customSelected = NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return UITableViewCellEditingStyleDelete & UITableViewCellEditingStyleInsert;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    
    UIButton *tion = [[UIButton alloc]init];
    
    [self.view addSubview:tion];
    tion.frame = CGRectMake(0, 0, 50, 50);
    tion.backgroundColor = [UIColor yellowColor];
    [tion setTitle:@"编辑" forState:0];
    
    [tion setTitleColor:[UIColor blackColor] forState:0];
    
    self.titlebt = tion;
    [tion addTarget:self action:@selector(claick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteBT = [[UIButton alloc]init];
    [self.view addSubview:deleteBT];
    deleteBT.frame = CGRectMake(self.view.frame.size.width-50, 0, 50, 50);
    deleteBT.backgroundColor = [UIColor yellowColor];
    [deleteBT setTitle:@"删除" forState:0];
    [deleteBT setTitleColor:[UIColor blackColor] forState:0];
    
    [deleteBT addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *allSelect = [[UIButton alloc]init];
    allSelect.frame = CGRectMake(self.view.frame.size.width/2-25, 0, 50, 50);
    [self.view addSubview:allSelect];
    [allSelect setTitle:@"全选" forState:0];
    [allSelect setTitleColor:[UIColor blackColor] forState:0];
    allSelect.backgroundColor = [UIColor yellowColor];
    
    [allSelect addTarget:self action:@selector(allselect:) forControlEvents:UIControlEventTouchUpInside];
    allSelect.selected = NO;
    self.allSelectBt = allSelect;
}

-(void)allselect:(UIButton *)sender{
    if (!sender.selected) {
        NSArray *arr = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in arr) {
            //根据索引，获取cell 然后就可以做你想做的事情啦
            aaaaTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            //我这里要隐藏cell 的图片
            [cell.btnSelect setTitle:@"🔴" forState:0];
            self.allSelectBt.selected = !self.allSelectBt.selected;
            cell.customSelected = YES;
        }
        for (int i = 0; i<self.data.count; i++) {
//            [self.selectData addObjectsFromArray:self.data];
            [self.selectData addObject:self.data[i]];
            [self.selectRos addObject:@(i)];
        }

    }else{
    
        NSArray *arr = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in arr) {
            //根据索引，获取cell 然后就可以做你想做的事情啦
            aaaaTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            //我这里要隐藏cell 的图片
            [cell.btnSelect setTitle:@"⭕️" forState:0];
            cell.customSelected = NO;
            self.allSelectBt.selected = !self.allSelectBt.selected;
        }
            [self.selectData removeAllObjects];
            [self.selectRos removeAllObjects];
        
    }
    
}


-(void)delete:(id)sender{
    [self.data removeObjectsInArray:self.selectData];
//    [self.selectData removeAllObjects];
    [self.selectRos removeAllObjects];
    [self.tableView reloadData];
}

-(void)claick:(UIButton *)sebder{
[self.tableView setEditing:!self.tableView.isEditing animated:NO];
    
//    NSString *titit = (self.tableView.isEditing) ? @"完成",@"编辑";
    if (self.tableView.isEditing) {
        [self.titlebt setTitle:@"完成" forState:0];
    }else{
    [self.titlebt setTitle:@"编辑" forState:0];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
