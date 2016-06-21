//
//  LoginViewController.m
//  qlx
//
//  Created by Stephen Chin on 16/3/16.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController (){
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_loginBtn setBackgroundColor:DEFAULT_COLOR];
    [_forgetPassword setTextColor:DEFAULT_COLOR];
    [_toRegister setTextColor:DEFAULT_COLOR];
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
//    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [self.account setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPassword)];
//    [_forgetPassword addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRegisger)];
    [_toRegister addGestureRecognizer:tap2];

    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
     [self.navigationController.navigationBar setTintColor:DEFAULT_COLOR];
//
//    _account.text = @"18671701215";
//    _password.text = @"123456";
}

//登录
-(void)login{
//    if ([_account.text isEqualToString:@""]) {
//        [self showHint:@"请输入手机号码"];
//        [_account becomeFirstResponder];
//        return;
//    }
//    if ([_password.text isEqualToString:@""]) {
//        [self showHint:@"请输入密码"];
//        [_password becomeFirstResponder];
//        return;
//    }
//    [self hideKeyBoard];
//    [self showHudInView:self.view];
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:_account.text forKey:@"phone"];
//    [param setObject:_password.text forKey:@"pwd"];
//    [param setObject:@"0" forKey:@"platform"];
//    
//    [[Client defaultNetClient] POST:API_USER_LOGIN param:param JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"JSONModel: %@", responseObject);
//        Data *res = (Data *)responseObject;
//        if (res.resultcode == ResultCodeSuccess) {
//            [self hideHud];
//            //保存账号密码
//            [[NSUserDefaults standardUserDefaults] setObject:_account.text forKey:LOGINED_PHONE];
//            [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:LOGINED_PASSWORD];
//            
////            NSError *error;
//            NSDictionary *dic = (NSDictionary*)res.result;
////            UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:[dic objectForKey:@"userInfo"] error:&error];
////            if (!error) {
////                DLog(@"%@",userInfo);
////            }else{
////                DLog(@"%@",error.description);
////            }
//            
//            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"userInfo"] forKey:LOGINED_USER];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserRole" object:nil];
//
//        }else {
//            DLog(@"%@",res.reason);
//            [self hideHud];
//            [self showHint:res.reason];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"Error: %@", error);
//        [self hideHud];
//        [self showHint:@"连接服务器失败，请稍后再试!"];
//        return;
//    }];
}

//找回密码
-(void)findPassword{
    
}

//注册
-(void)goToRegisger{
    
    RegisterViewController *regVc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regVc animated:YES];
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
