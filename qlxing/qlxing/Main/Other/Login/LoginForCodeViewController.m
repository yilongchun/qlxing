//
//  LoginForCodeViewController.m
//  qlxing
//
//  Created by Stephen Chin on 16/6/23.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "LoginForCodeViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "Util.h"

@interface LoginForCodeViewController (){
    RegisterViewController *regVc;
    ForgetPwdViewController *forgetPwdVc;
    LoginViewController *loginVc;
    UIButton *getCodeBtn;
}

@end

@implementation LoginForCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_loginBtn setBackgroundColor:DEFAULT_COLOR];
    [_forgetPassword setTextColor:DEFAULT_COLOR];
    [_toRegister setTextColor:DEFAULT_COLOR];
    [_pwdLogin setTextColor:DEFAULT_COLOR];
    ViewBorderRadius(_loginBtn, 5, 1.0, DEFAULT_COLOR);
    
    getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 7, 120, 41)];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:DEFAULT_COLOR forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:RGB(5,198,232) forState:UIControlStateHighlighted];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 55)];
    [rightView addSubview:getCodeBtn];
    self.password.rightViewMode = UITextFieldViewModeAlways;
    self.password.rightView = rightView;
    
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPassword)];
    [_forgetPassword addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRegisger)];
    [_toRegister addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginForMsg)];
    [_pwdLogin addGestureRecognizer:tap3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录
-(void)login{
    if ([_account.text isEqualToString:@""]) {
        [self showHintInView:self.navigationController.view hint:@"请输入手机号码" ];
        [_account becomeFirstResponder];
        return;
    }
    if ([_password.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入验证码"];
        [_password becomeFirstResponder];
        return;
    }
    [self hideKeyBoard];
    [self showHudInView:self.navigationController.view];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:_account.text forKey:@"identity"];
    [parameters setObject:_password.text forKey:@"code"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_AUTH_LOGIN_CODE];
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
    if (loginVc == nil) {
        loginVc = [[LoginViewController alloc] init];
        loginVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginVc];
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

//获取验证码
-(void)getCode{
    if ([_account.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入手机号码"];
        [_account becomeFirstResponder];
        return;
    }
    if (![Util isValidateMobile:_account.text]) {
        [self showHintInView:self.view hint:@"请输入正确的手机号码"];
        [_account becomeFirstResponder];
        return;
    }
    [self hideKeyBoard];
    [self showHudInView:self.view];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:_account.text forKey:@"phone"];
    [parameters setObject:@"1" forKey:@"type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_AUTH_CODE_LOGIN];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self hideHud];
        [self showHintInView:self.view hint:@"验证码发送成功"];
        [self startTime];
        DLog(@"%@",responseObject);
        //        NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
        
        
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

#pragma mark - 倒计时
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                getCodeBtn.titleLabel.text = @"获取验证码";
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //                [_codeBtn setBackgroundColor:[UIColor whiteColor]];
                getCodeBtn.userInteractionEnabled = YES;
                getCodeBtn.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                //                [UIView beginAnimations:nil context:nil];
                //                [UIView setAnimationDuration:1];
                getCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%@秒后重试",strTime];
                [getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重试",strTime] forState:UIControlStateNormal];
                //                [_codeBtn setBackgroundColor:[UIColor lightGrayColor]];
                //                [UIView commitAnimations];
                getCodeBtn.userInteractionEnabled = NO;
                getCodeBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
