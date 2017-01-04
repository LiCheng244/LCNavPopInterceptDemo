//
//  LCNavigationController.h
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCNavigationController;

// 定义协议方法
@protocol LCNavigationControllerShouldProtocol <NSObject>

/** 点击返回时触发的方法 */
- (BOOL)lc_navationControllerShouldPopWhenSystemBackBtnselectted:(LCNavigationController *)navigationController;

@end

@interface LCNavigationController : UINavigationController

@end
