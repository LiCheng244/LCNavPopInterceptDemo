//
//  LCNavigationController.m
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "LCNavigationController.h"

// 分类
@interface UINavigationController (UINavigationControllerItem)

/** 重载父类的 navigationBar:shouldPopItem: 方法 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincomplete-implementation"
@implementation UINavigationController (UINavigationControllerItem)
@end

#pragma clang diagnostic pop

@interface LCNavigationController ()<UINavigationBarDelegate>
@end

@implementation LCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 重写父类的方法 */
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    // 取出导航控制器中栈 的 vc
    UIViewController *vc = self.topViewController;
    
    if (item != vc.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
    // 查看是否实现了我们定义的协议
    if ([vc conformsToProtocol:@protocol(LCNavigationControllerShouldProtocol)]) {
        
        // 协议方法的返回值
        BOOL isProtocol = [(id<LCNavigationControllerShouldProtocol>)vc lc_navationControllerShouldPopWhenSystemBackBtnselectted:self];
        
        if (isProtocol) { // vc返回的是yes, 则返回系统默认的实现
            return [super navigationBar:navigationBar shouldPopItem:item];
        
        }else{ // vc返回no, 说明暂时不想pop
            return NO;
        }
        
    }else{ // 没有, 自己返回系统默认的实现
        
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
}
@end
