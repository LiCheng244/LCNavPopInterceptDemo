//
//  ViewController.m
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "ViewController.h"
#import "LCNavigationControllerShouldProtocol.h"

@interface ViewController ()<UIAlertViewDelegate, LCNavigationControllerShouldProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(BOOL)lc_navationControllerShouldPopWhenSystemBackBtnselectted:(LCNavigationController *)navigationController{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前编辑的内容么?" delegate:self cancelButtonTitle:@"留在此页" otherButtonTitles:@"放弃编辑", nil];
    [al show];
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 只要alertView的btn一点击就会调用
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (!buttonIndex) { // 为了恢复<按钮的颜色 越快越好
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.hidesBackButton = NO;
    }
}
#pragma mark - 等alertView消失完在调用
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
