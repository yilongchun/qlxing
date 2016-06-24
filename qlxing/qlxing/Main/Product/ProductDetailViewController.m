//
//  ProductDetailViewController.m
//  qlxing
//
//  Created by Stephen Chin on 16/6/24.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "BMAdScrollView.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
}

-(void)loadData{
    
    DLog(@"%@",_productId);
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg", nil];
    //设置标题数组
    NSMutableArray *strArr = [[NSMutableArray alloc]initWithObjects:@"1:我们是一支可以撼动世界的力量",@"2:向前冲吧，小伙伴们", @"3:再不会为任何理由停下脚步",nil];
    
   
    
    BMAdScrollView *adView = [[BMAdScrollView alloc]initWithFrame:CGRectMake(0, -20, Main_Screen_Width, 250) images:arr titles:strArr];
    
    adView.pageCenter = CGPointMake(Main_Screen_Width - 30, 165);
    [_myScrollView addSubview:adView];
    
    
    
    

}

-(void)viewDidLayoutSubviews
{
    _myScrollView.contentSize = CGSizeMake(Main_Screen_Width,1000);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
