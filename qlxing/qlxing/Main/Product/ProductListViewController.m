//
//  ProductListViewController.m
//  qlxing
//
//  Created by Stephen Chin on 16/6/23.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "ProductListViewController.h"
#import "MJRefresh.h"
#import "ProductTableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ProductDetailViewController.h"


@interface ProductListViewController (){
    NSMutableArray *dataSource;
    
}

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    
//    self.fd_interactivePopDisabled = YES;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action1)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Combined Shape"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(action2)];
    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.myTableView setTableFooterView:v];
    
    
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    //去黑线
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(255, 255, 255, 0.0)] forBarMetrics:UIBarMetricsDefault];
}

-(void)action1{
    
}

-(void)action2{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  加载数据
 */
-(void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_PRODUCT];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:10] forKey:@"limit"];
    [parameters setObject:[NSNumber numberWithInt:0] forKey:@"offset"];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@",responseObject);
        NSArray *array = responseObject;
        dataSource = [NSMutableArray arrayWithArray:array];
        [_myTableView reloadData];
        [_myTableView.mj_header endRefreshing];

    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {

        NSData *data =[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *result  =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSString *message = [dic objectForKey:@"message"];
        [self showHintInView:self.view hint:NSLocalizedString(message, nil)];
        DLog(@"%@",error);
        DLog(@"%@",result);
     
    }];
}



#pragma mark - UITableView UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"productCell";
    ProductTableViewCell *cell = (ProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell= (ProductTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ProductTableViewCell" owner:self options:nil]  lastObject];
        ViewBorderRadius(cell.headImage, cell.headImage.frame.size.height/2, 1.0, [UIColor whiteColor]);
    }
    
    NSDictionary *product = [dataSource objectAtIndex:indexPath.row];
//    NSNumber *price = [product objectForKey:@"price"];//价格
    NSString *subTitle = [product objectForKey:@"subTitle"];
    NSString *title = [product objectForKey:@"title"];
    NSArray *images = [product objectForKey:@"images"];
    
    cell.titleLabel.text = title;
    
    cell.titleLabel.shadowColor = [UIColor lightGrayColor];
    cell.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    
    cell.subTitleLabel.text = subTitle;
    if (images.count > 0) {
        NSString *url = [[images objectAtIndex:0] objectForKey:@"url"];
        [cell.backgroundImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageTransformAnimatedImage];
    }
    
    DLog(@"%@",product);
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    NSDictionary *product = [dataSource objectAtIndex:indexPath.row];
    vc.productId = [product objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
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
