//
//  ProductDetailViewController.m
//  qlxing
//
//  Created by Stephen Chin on 16/6/24.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "BMAdScrollView.h"
#import "YYLabel.h"

@interface ProductDetailViewController ()<UIWebViewDelegate>{
    NSDictionary *info;
}

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
}

//加载数据
-(void)loadData{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",kHost,API_PRODUCT,_productId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@",responseObject);
        info = responseObject;
        [self setContent];
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

//设置内容
-(void)setContent{
    
    //图片
    NSArray *images = [info objectForKey:@"images"];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    NSMutableArray *strArr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < images.count; i++) {
        [arr addObject:[[images objectAtIndex:i] objectForKey:@"url"]];
        [strArr addObject:[[images objectAtIndex:i] objectForKey:@"id"]];
    }
    BMAdScrollView *adView = [[BMAdScrollView alloc] initWithFrame:CGRectMake(0, -20, Main_Screen_Width, 250) images:arr titles:strArr];
    [_myScrollView addSubview:adView];
    
    //标题
    NSString *title = [info objectForKey:@"title"];
    YYLabel *titleLabel = [YYLabel new];
    CGRect titleRect = CGRectMake(15, adView.frame.size.height - 60, Main_Screen_Width - 50, 30);
    [titleLabel setFrame:titleRect];
    titleLabel.backgroundColor =[UIColor clearColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor=[UIColor whiteColor];
    [_myScrollView addSubview:titleLabel];
    
    //副标题
    NSString *subTitle = [info objectForKey:@"subTitle"];
    
    //价格
    NSNumber *price = [info objectForKey:@"price"];
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",[price doubleValue]];
    
    [_view1 setFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, Main_Screen_Width, _view1.frame.size.height)];
    _subTitleLabel.text = subTitle;
    _priceLabel.text = priceStr;
    [_myScrollView addSubview:_view1];
    
    
    
    
    
    //notice
    NSDictionary *details = [info objectForKey:@"details"];
    NSString *notice = [details objectForKey:@"notice"];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_view1.frame) + 10, Main_Screen_Width, 100)];
    web.delegate = self;
    [web loadHTMLString:notice baseURL:nil];
    web.userInteractionEnabled = NO;
    [_myScrollView addSubview:web];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '100%%'",i];
        [webView stringByEvaluatingJavaScriptFromString:str];
    }
    CGSize websize = [webView sizeThatFits:CGSizeZero];
    [webView setFrame:CGRectMake(0, webView.frame.origin.y, Main_Screen_Width, websize.height)];
    
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
