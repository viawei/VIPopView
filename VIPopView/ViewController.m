//
//  ViewController.m
//  VIPopView
//
//  Created by 天地飘香 on 16/8/31.
//  Copyright © 2016年 VIVI. All rights reserved.
//

#import "ViewController.h"
#import "VIPopView.h"

#define ScreenWidth           [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)btnClicked:(UIButton *)sender {
    [self showPopView];
}

- (void)showPopView {
    CGFloat width = 120;
    CGFloat height = 44 * 3;
    CGFloat sp = 10;
    
    [VIPopView initPopViewWithFrame:CGRectMake(ScreenWidth - width - sp, 64, width, height) titleArr:@[@"分享记录", @"送券记录", @"使用帮助"] imageArr:@[@"coupon_ic_share", @"coupon_ic_record", @"coupon_ic_help"] anchorPoint:CGPointMake(1, 0) didSelectedAction:^(NSInteger index) {
        if (index == 0) {
            
        } else if (index == 1) {
            
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
