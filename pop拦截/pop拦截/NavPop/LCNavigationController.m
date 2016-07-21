//
//  LCNavigationController.m
//  pop拦截
//
//  Created by LiCheng on 16/7/21.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "LCNavigationController.h"
#import "LCNavigationControllerShouldProtocol.h"


@interface UINavigationController (UINavigationControllerItem)
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

-(BOOL)navigationBar:(UINavigationBar *)navigationBar
       shouldPopItem:(UINavigationItem *)item
{
    
    
    UIViewController *vc = self.topViewController;
    
    
    if (item != vc.navigationItem) {
        return [super navigationBar:navigationBar
                      shouldPopItem:item];
    }
    
    // 查看是否实现了我们定义的协议
    if ([vc conformsToProtocol:@protocol(LCNavigationControllerShouldProtocol)]) {
        
        BOOL isProtocol = [(id<LCNavigationControllerShouldProtocol>)vc lc_navationControllerShouldPopWhenSystemBackBtnselectted:self];
        
        if (isProtocol) { // vc返回的是yes, 则返回系统默认的实现
            return [super navigationBar:navigationBar
                          shouldPopItem:item];
        
        }else{ // vc返回no, 说明暂时不想pop
            return NO;
        }
        
    }else{ // 没有, 自己返回系统默认的实现
        
        return [super navigationBar:navigationBar
                      shouldPopItem:item];
    }
}

/**
 
 
 好，接下来，我们把上面的过程梳理一遍。我们点击系统的返回按钮，这是，程序会走到图7第35行的方法里。沿着这个方法往下走，我们先取出了导航控制器中栈定的vc，（第40~42行，先跳过，稍后再说其作用）接着我们查看其是否实现了我们定义的那个协议，如果其没实现协议（说明那个vc根本没有要做拦截系统返回按钮的事件的打算），所致直接跳到52行，返回系统默认的实现，也就是UINavigationController类（父类）里面的实现，调super的同名方法。如果实现了这个协议，则说明vc有这个想法，所以就调用协议里的方法（第45行），如果人家返回了NO，我们就给navigationBar传达这个意思（第49行），说vc暂时不想pop，这是navigationBar就不会pop。如果vc返回的时YES，我们就返回系统默认的实现(第46行)。
 
 大家想想这个过程，本来navigationBar不知道是否pop，于是问navigationController，navigationController有自己默认的实现，与外界没有关系。而现在我们定义了个子类，继承navigationController，这样，navigationBar不知道是否pop，就来问这个子类，而这个子类的做法是先看看他栈顶的这个vc是否有改变系统默认实现的这个打算（遵守协议），如果没有，返回navigationController（父类）的默认实现，如果有，我们就具体问问它做的决定，如果这个vc返回YES（说明其对pop是支持的，所以我们返回默认实现）。如果不支持，我们就以vc为主，直接返回NO。
 
 很简单，有没有？还是有一个问题，UINavigationController的接口中并没有放出navigationBar:shouldPopItem:这个方法的接口（其实这只是navigationController要实现的一个协议，是不会放到接口中的），所以我们在子类里是无法直接 调用super 的这个方法的，编译会报错。为了解决这个问题，我们用到了一些小技巧（这个不知道叫其为小技巧合不合适？），就是图7中第12~22行干的事。
 
 我们为UINavigationController添加的了一个类别。为UINavigationController添加了这个方法，但是并没有在类别里实现，这样就把UINavigationController的本来已经实现了的（算是）私有方法暴漏了出来。如果在这个类别里实现了这个方法，则调用的时候到底调用哪个实现是不确定的。我们慢慢来分析一下，我们把navigationBar:shouldPopItem:方法叫a方法，将UINavigationController叫A类。本来A类里有了一个a方法的默认实现。只不过这个a方法没有在A类的接口中暴露出来。而现在给A类增加了一个类别，类别接口里添加了a方法而没有实现，我们知道，OC中调用方法是通过方法名比较（粗浅层面）来调用的，所以这是我们就相当于把A类里的私有方法，在类别的接口里暴漏出来了，即外部可以通过这个分类的接口来调用这个私有方法了。我们再来看，如果我们在分类里实现了这个方法，则分类里的实现最终会加入到A类的方法列表里。所以到时候再调a方法的时候，A类的方法列表里有两份实现，具体调哪个就不确定了。所以我们只在接口中申明，但是不实现。
 */
@end
