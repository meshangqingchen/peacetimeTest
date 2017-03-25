//
//  ViewController.m
//  日历环形CollectionView布局
//
//  Created by 3D on 17/3/11.
//  Copyright © 2017年 3D. All rights reserved.
//
#define W_width (([UIScreen mainScreen].bounds.size.width))
#define ITEM_WH W_width*2/31

#import "ViewController.h"
#import "testCollectionViewCell.h"
#import "ARCLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.view addSubview:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        
        ARCLayout *layout = [[ARCLayout alloc]init];
    
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width*(1-cos(M_PI/6))+ITEM_WH) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[testCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    testCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lable.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


@end
