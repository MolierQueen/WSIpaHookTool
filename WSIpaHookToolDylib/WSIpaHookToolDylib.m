//
//
//  WSIpaHookToolDylib.m
//  WSIpaHookToolDylib
//
//  Created by Molier on 2023/3/8.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

#import "WSIpaHookToolDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import "HookClass.h"

CHConstructor{
    printf(INJECT_SUCCESS);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //        程序入口函数.....
        
        [[HookClass sharedInstance] run];

        NSLog(@"bd == %@",[[NSBundle mainBundle] bundleIdentifier]);
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        
    }];
}
/*****************以下所有OC Hook相关操作也可以在“HookClass” 中的 “run”函数中编写，不必一定使用下面方法*********************/

//步骤1：声明要Hook的类
CHDeclareClass(CustomViewController)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

//可选功能1:添加一个（只有一个参数的）新方法
//参数依次为函数返回值、所在类、函数名，参数类型，参数名
CHDeclareMethod1(void, CustomViewController, newMethod, NSString*, output){
    NSLog(@"This is a new method : %@", output);
}


//可选功能2: 添加一个属性
//参数依次为所在类、属性类型 get方法、Set方法
CHPropertyRetainNonatomic(CustomViewController, NSString*, newProperty, setNewProperty);

#pragma clang diagnostic pop

//可选功能3: Hook 类方法，且此方法只包含0个参数
//参数依次为target 、函数返回值、所在类、函数名
CHOptimizedClassMethod0(self, void, CustomViewController, classMethod){
    NSLog(@"hook class method");
    CHSuper0(CustomViewController, classMethod);
}

//可选功能4: Hook 实例方法，且此方法只包含0个参数
//参数依次为target 、函数返回值、所在类、函数名
CHOptimizedMethod0(self, NSString*, CustomViewController, getMyName){
    //调用原始函数
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"原始返回值为:%@",originName);
    
    //获取该类的属性
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password = %@",password);
    
    //    调用上面添加的新方法
    [self newMethod:@"output"];
    
    //     设置上面新加的属性
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty = : %@", self.newProperty);
    
    //     改变原方法的返回值
    return @"Molier";
    
}


CHConstructor{
    //步骤2：加载要处理的的类
    CHLoadLateClass(CustomViewController);
    
    //步骤3：进行方法交换（只有涉及到方法hook的时候才需要此步骤，添加函数或者熟悉不需要此步骤）
    //    类方法
    CHClassHook0(CustomViewController, getMyName);
    CHClassHook0(CustomViewController, classMethod);
    //    实例方法
    CHHook0(CustomViewController, newProperty);
    CHHook1(CustomViewController, setNewProperty);
}

