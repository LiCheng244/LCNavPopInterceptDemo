//
//  LCNavigationControllerShouldProtocol.h
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCNavigationController;

@protocol LCNavigationControllerShouldProtocol <NSObject>

- (BOOL)lc_navationControllerShouldPopWhenSystemBackBtnselectted:(LCNavigationController *)navigationController;
@end
