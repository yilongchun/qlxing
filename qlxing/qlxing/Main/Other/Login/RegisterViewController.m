//
//  RegisterViewController.m
//  qlx
//
//  Created by Stephen Chin on 16/3/16.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController (){
    UIButton *getCodeBtn;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册";
    
    [_regBtn setBackgroundColor:DEFAULT_COLOR];
    ViewBorderRadius(_regBtn, 5, 1.0, DEFAULT_COLOR);
    
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
//    [_regBtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
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
//    [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
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
//    if ([_account.text isEqualToString:@""]) {
//        [self showHint:@"请输入手机号码"];
//        [_account becomeFirstResponder];
//        return;
//    }
//    if (![Util isValidateMobile:_account.text]) {
//        [self showHint:@"请输入正确的手机号码"];
//        [_account becomeFirstResponder];
//        return;
//    }
//    if ([_code.text isEqualToString:@""]) {
//        [self showHint:@"请输入验证码"];
//        [_code becomeFirstResponder];
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
//    
//    
//    UserInfo *userinfo = [[UserInfo alloc] init];
//    userinfo.phone = _account.text;
//    userinfo.pwd = _password.text;
//    userinfo.type = [NSNumber numberWithInt:1];
//    
//    NSDictionary *param = @{@"param":userinfo.toJSONString,@"activationCode":_code.text};
//    
//    [[Client defaultNetClient] POST:API_USER_REGISTER param:param JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"JSONModel: %@", responseObject);
//        Data *res = (Data *)responseObject;
//        if (res.resultcode == ResultCodeSuccess) {
//            [self hideHud];
//            [self showHint:res.reason];
//            [self performBlock:^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//                _account.text = @"";
//                _code.text = @"";
//                _password.text = @"";
//            } afterDelay:1.5];
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

//获取验证码
-(void)getCode{
//    if ([_account.text isEqualToString:@""]) {
//        [self showHint:@"请输入手机号码"];
//        [_account becomeFirstResponder];
//        return;
//    }
//    if (![Util isValidateMobile:_account.text]) {
//        [self showHint:@"请输入正确的手机号码"];
//        [_account becomeFirstResponder];
//        return;
//    }
//    [self hideKeyBoard];
//    [self showHudInView:self.view];
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:_account.text forKey:@"phone"];
//    [param setObject:@"1" forKey:@"type"];
//    [[Client defaultNetClient] POST:API_USER_SENDMESSAGE param:param JSONModelClass:[Data class] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"JSONModel: %@", responseObject);
//        Data *res = (Data *)responseObject;
//        if (res.resultcode == ResultCodeSuccess) {
//            [self startTime];
//            [self hideHud];
//            [self showHint:res.reason];
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

//隐藏键盘
-(void)hideKeyBoard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - 倒计时
//-(void)startTime{
//    __block int timeout=30; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                getCodeBtn.userInteractionEnabled = YES;
//                getCodeBtn.enabled = YES;
//            });
//        }else{
//            int seconds = timeout % 60;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                //NSLog(@"____%@",strTime);
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:1];
//                [getCodeBtn setTitle:[NSString stringWithFormat:@"%@后重试",strTime] forState:UIControlStateNormal];
//                [UIView commitAnimations];
//                getCodeBtn.userInteractionEnabled = NO;
//                getCodeBtn.enabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
