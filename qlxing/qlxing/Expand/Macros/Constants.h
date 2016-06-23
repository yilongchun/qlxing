//
//  Constants.h
//  qlxing
//
//  Created by Stephen Chin on 16/6/21.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

//已登录用户
#define LOGINED_USER @"loginedUser"

#define DEFAULT_COLOR RGB(25,218,252)

#define kHost @"http://120.27.112.178/api/v1"


/**
 *  auth
 */
//登录
#define API_AUTH_LOGIN @"/auth/login"
//注册
#define API_AUTH_REGISTER @"/auth/register"
//重置密码
#define API_AUTH_RESETPWD @"/auth/resetpwd"
//发送注册验证码
#define API_AUTH_CODE_REGISTER @"/auth/code/register"
//发送登录验证码
#define API_AUTH_CODE_LOGIN @"/auth/code/login"
//发送重置密码验证码
#define API_AUTH_CODE_RESETPWD @"/auth/code/resetpwd"

/**
*   product
*/
//产品列表
#define API_PRODUCT @"/products/"