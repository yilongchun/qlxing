//
//  ProductDetailViewController.h
//  qlxing
//
//  Created by Stephen Chin on 16/6/24.
//  Copyright © 2016年 Stephen Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) NSString *productId;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
