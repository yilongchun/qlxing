//
//  HomeViewController.m
//  qlxing
//
//  Created by Stephen Chin on 16/6/23.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "Util.h"
#import "ProductActivityTableViewCell.h"
#import "ProductListViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate>{
    NSMutableArray *dataSource;
    SDCycleScrollView *banner;
    UIImage *shadowImage;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.navigationController setNavigationBarHidden:YES];
    
//    shadowImage = self.navigationController.navigationBar.shadowImage;
//    self.navigationController.navigationBar.translucent = YES;
//    //去黑线
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(255, 255, 255, 0.0)] forBarMetrics:UIBarMetricsDefault];
    
    
    _myNavigationBar.translucent = YES;
    //去黑线
    [_myNavigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
    [_myNavigationBar setBackgroundImage:[Util imageWithColor:RGBA(255, 255, 255, 0.0)] forBarMetrics:UIBarMetricsDefault];
    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action1)];
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Combined Shape"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action2)];
    
//    _barButtonItem1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action1)];
//    
//    _barButtonItem2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action2)];
    
    _barButtonItem1.image = [[UIImage imageNamed:@"Combined Shape"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _barButtonItem2.image = [[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.myTableView setTableFooterView:v];
    
    _myTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self setTableHeaderView];
    
    [self loadData];
    
}

//-(void)action1{
//    
//}
//
//-(void)action2{
//    
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    self.navigationController.navigationBar.translucent = YES;
//    //去黑线
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(255, 255, 255, 0.0)] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
//    //去黑线
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(255, 255, 255, 0.0)] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置头部
 */
-(void)setTableHeaderView{
    banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) delegate:self placeholderImage:nil];
    //    banner2.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    //    banner2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    banner2.imageURLStringsGroup = imagesURLStrings;
    //    banner2.titlesGroup = titles;
    //    _myTableView.tableHeaderView = banner;
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 300)];
    [tableHeaderView addSubview:banner];
    
    
    [_selectTpyeBtnView setFrame:CGRectMake(0, 200, Main_Screen_Width, 90)];
    [tableHeaderView addSubview:_selectTpyeBtnView];
    ViewRadius(_btn1, 3.0);
    ViewRadius(_btn2, 3.0);
    ViewRadius(_btn3, 3.0);
    [_btn1 addTarget:self action:@selector(toAction1) forControlEvents:UIControlEventTouchUpInside];
    
    
    _myTableView.tableHeaderView = tableHeaderView;
}

/**
 *  找住宿
 */
-(void)toAction1{
    ProductListViewController *vc = [[ProductListViewController alloc] init];
    vc.title = @"精品住宿";
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
    self.navigationController.navigationBar.translucent = NO;
}

/**
 *  加载数据
 */
-(void)loadData{
    
    [self loadScrollImage];
    
//    page = 1;
//    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%d",page],@"pageSize":kPAGE_SIZE,@"status":_status};
//    [[Client defaultNetClient] POST:API_SIGNING_SIGNINGLIST param:parameters JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"JSONModel: %@", responseObject);
//        Data *res = (Data *)responseObject;
//        if (res.resultcode == ResultCodeSuccess) {
//            
//            if (dataSource==nil) {
                dataSource = [NSMutableArray new];
    [dataSource addObject:@"1"];
    [dataSource addObject:@"1"];
    [dataSource addObject:@"1"];
    [dataSource addObject:@"1"];
//            }else{
//                [dataSource removeAllObjects];
//            }
//            
//            NSError *error;
//            NSArray *arr = (NSArray*)res.result;
//            for (NSDictionary *dic in arr) {
//                error = nil;
//                Signing *signing = [[Signing alloc] initWithDictionary:dic error:&error];
//                DLog(@"%@",signing);
//                if (error) {
//                    DLog(@"%@",error.userInfo);
//                    continue;
//                }
//                [dataSource addObject:signing];
//            }
            [_myTableView reloadData];
            [_myTableView.mj_header endRefreshing];
//        }else {
//            DLog(@"%@",res.reason);
//            [_myTableView.mj_header endRefreshing];
//            [self showHint:res.reason];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"Error: %@", error);
//        [_myTableView.mj_header endRefreshing];
//        [self showHint:@"获取失败，请重试!"];
//        return;
//    }];
}

/**
 * 顶部轮播图
 */
- (void)loadScrollImage{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    banner.imageURLStringsGroup = imagesURLStrings;
}

#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"%ld",(long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//    DLog(@"%ld",(long)index);
}

#pragma mark - UITableView UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"activityCell";
    ProductActivityTableViewCell *cell = (ProductActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell= (ProductActivityTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ProductActivityTableViewCell" owner:self options:nil]  lastObject];
        
        
    }
//    static NSString *CellIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LViewControllerDetail *vc = [[LViewControllerDetail alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
