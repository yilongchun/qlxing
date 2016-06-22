//
//  RegisterViewController.m
//  qlx
//
//  Created by Stephen Chin on 16/3/16.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "RegisterViewController.h"
#import "Util.h"
#import "NSObject+Blocks.h"

@interface RegisterViewController (){
//    UIButton *getCodeBtn;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册";
    
    [_regBtn setBackgroundColor:DEFAULT_COLOR];
    [_codeBtn setTitleColor:DEFAULT_COLOR forState:UIControlStateNormal];
    ViewBorderRadius(_regBtn, 5, 1.0, DEFAULT_COLOR);
    ViewBorderRadius(_codeBtn, 5, 0.5, RGBA(200, 200, 200, 0.8) );
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    [self.view addGestureRecognizer:tap];
//    
//    [self.navigationController setNavigationBarHidden:NO];
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(252, 228, 75,0.0)] forBarMetrics:UIBarMetricsDefault];
//    
//    [_regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_regBtn setBackgroundImage:[UIImage imageNamed:@"btnBg"] forState:UIControlStateNormal];
//    _regBtn.layer.masksToBounds = YES;
//    _regBtn.layer.cornerRadius = 20;
    [_regBtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.account setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.code setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [self.password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    
//    getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 80, 30)];
//    getCodeBtn.layer.masksToBounds = YES;
//    getCodeBtn.layer.cornerRadius = 5;
//    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getCodeBtn setTitleColor:RGB(154, 154, 154) forState:UIControlStateNormal];
//    [getCodeBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateHighlighted];
//    [getCodeBtn setBackgroundImage:[UIImage createImageWithColor:RGB(230, 230, 230)] forState:UIControlStateNormal];
//    [getCodeBtn setBackgroundImage:[UIImage createImageWithColor:RGB(240, 240, 240)] forState:UIControlStateHighlighted];
//    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
//    [rightView addSubview:getCodeBtn];
//    self.code.rightViewMode = UITextFieldViewModeAlways;
//    self.code.rightView = rightView;
//    
//    if (IS_IPHONE4) {
//        _regBtnCenterY.constant +=50;
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setShadowImage:[Util imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [self.navigationController.navigationBar setBackgroundImage:[Util imageWithColor:RGBA(252, 228, 75,0.0)] forBarMetrics:UIBarMetricsDefault];
}

//注册
-(void)reg{
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
    if ([_code.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入验证码"];
        [_code becomeFirstResponder];
        return;
    }
    if ([_nickname.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入昵称"];
        [_nickname becomeFirstResponder];
        return;
    }
    if ([_password.text isEqualToString:@""]) {
        [self showHintInView:self.view hint:@"请输入密码"];
        [_password becomeFirstResponder];
        return;
    }
    [self hideKeyBoard];
    [self showHudInView:self.navigationController.view];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:_account.text forKey:@"phone"];
    [parameters setObject:_password.text forKey:@"password"];
    [parameters setObject:_code.text forKey:@"code"];
//    [parameters setObject:_nickname.text forKey:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_AUTH_REGISTER];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self hideHud];
        DLog(@"%@",responseObject);
//        NSDictionary *dic= [NSDictionary dictionaryWithDictionary:responseObject];
        [self showHintInView:self.view hint:@"注册成功"];
        
        [self performBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        } afterDelay:1.5];
        
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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kHost,API_AUTH_CODE];
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

//隐藏键盘
-(void)hideKeyBoard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 倒计时
-(void)startTime{
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _codeBtn.titleLabel.text = @"获取验证码";
                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                [_codeBtn setBackgroundColor:[UIColor whiteColor]];
                _codeBtn.userInteractionEnabled = YES;
                _codeBtn.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:1];
                _codeBtn.titleLabel.text = [NSString stringWithFormat:@"%@秒后重试",strTime];
                [_codeBtn setTitle:[NSString stringWithFormat:@"%@秒后重试",strTime] forState:UIControlStateNormal];
//                [_codeBtn setBackgroundColor:[UIColor lightGrayColor]];
//                [UIView commitAnimations];
                _codeBtn.userInteractionEnabled = NO;
                _codeBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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
