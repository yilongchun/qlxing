//
//  LoginViewController.m
//  qlx
//
//  Created by Stephen Chin on 16/3/16.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "ForgetPwdViewController.h"
#import "LoginForCodeViewController.h"

@interface LoginViewController (){
    RegisterViewController *regVc;
    ForgetPwdViewController *forgetPwdVc;
    LoginForCodeViewController *msgVc;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_loginBtn setBackgroundColor:DEFAULT_COLOR];
    [_forgetPassword setTextColor:DEFAULT_COLOR];
    [_toRegister setTextColor:DEFAULT_COLOR];
    [_msgLogin setTextColor:DEFAULT_COLOR];
    ViewBorderRadius(_loginBtn, 5, 1.0, DEFAULT_COLOR);
    
    // Do any additional setup after loading the view from its nib.
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    [self.view addGestureRecognizer:tap];
//    
//    [self.navigationController setNavigationBarHidden:YES];
//    
//    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"btnBg"] forState:UIControlStateNormal];
//    _loginBtn.layer.masksToBounds = YES;
//    _loginBtn.layer.cornerRadius = 20;
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
  
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPassword)];
    [_forgetPassword addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRegisger)];
    [_toRegister addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginForMsg)];
    [_msgLogin addGestureRecognizer:tap3];
    

    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
     [self.navigationController.navigationBar setTintColor:DEFAULT_COLOR];

    _account.text = @"18671701215";
    _password.text = @"123456";
}

//登录
-(void)login{
    if ([_account.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入手机号码" ];
        [_account becomeFirstResponder];
        return;
    }
    if ([_password.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入密码"];
        [_password becomeFirstResponder];
        return;
    }
    [self hideKeyBoard];
    [self showHudInView:self.navigationController.view];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:_account.text forKey:@"identity"];
    [parameters setObject:_password.text forKey:@"password"];

    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_AUTH_LOGIN];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self hideHud];
        NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:dic forKey:LOGINED_USER];
        DLog(@"%@",dic);
        
        HomeViewController *homeVc = [[HomeViewController alloc] init];
        [homeVc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:homeVc];
//        nc.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
        
        [self presentViewController:nc animated:YES completion:^{
            
        }];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self hideHud];
        
        NSData *data =[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *result  =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSString *message = [dic objectForKey:@"message"];
        [self showHintInView:self.view hint:NSLocalizedString(message, nil)];
        DLog(@"%@",dic);
        
    }];

}

//找回密码
-(void)findPassword{
    if (forgetPwdVc == nil) {
        forgetPwdVc = [[ForgetPwdViewController alloc] init];
    }
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}

//注册
-(void)goToRegisger{
    if (regVc == nil) {
        regVc = [[RegisterViewController alloc] init];
    }
    [self.navigationController pushViewController:regVc animated:YES];
}

//短信登录
-(void)loginForMsg{
    if (msgVc == nil) {
        msgVc = [[LoginForCodeViewController alloc] init];
        msgVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:msgVc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//隐藏键盘
-(void)hideKeyBoard{
    [self.view endEditing:YES];
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
