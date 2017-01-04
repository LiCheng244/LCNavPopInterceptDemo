//
//  ViewController.m
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "ViewController.h"
#import "LCNavigationController.h"

@interface ViewController ()<LCNavigationControllerShouldProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(BOOL)lc_navationControllerShouldPopWhenSystemBackBtnselectted:(LCNavigationController *)navigationController{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要放弃当前编辑吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"放弃编辑" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"留在此页" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.hidesBackButton = NO;
    }];
    [alert addAction:cancle];
    [alert addAction:confirm];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
    return NO;
}


@end
