//
//  HookClass.m
//  WSIpaHookToolDylib
//
//  Created by Molier on 2023/3/11.
//

#import "HookClass.h"
#import <objc/runtime.h>

@interface HookClass ()
@property (nonatomic, copy) NSString *bundleID;
@end

@implementation HookClass

// 静态对象
static HookClass *_instence = nil;

#pragma mark - 单例初始化
+(instancetype)sharedInstance
{
    if (_instence == nil) {
        _instence = [[HookClass alloc] init];
    }
    return _instence;
}

#pragma mark - HooK 方法
+ (void) hookOriginalClass:(NSString *)classObjectStr
      isClassMetohd:(BOOL)classMethod
   originalSelector:(NSString *)fromSelectorStr
                toClass:(NSString *)toClassStr
           toSelector:(NSString *)toSelectorStr {
    
    Class class = NSClassFromString(classObjectStr);
    Class targetClass = NSClassFromString(toClassStr);
    
    SEL fromSelector = NSSelectorFromString(fromSelectorStr);
    SEL toSelector = NSSelectorFromString(toSelectorStr);

    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    Method toMethod = class_getInstanceMethod(targetClass, toSelector);
    if (classMethod) {
        class = object_getClass(class);
        fromMethod = class_getClassMethod(class, fromSelector);
        toMethod = class_getClassMethod(class, toSelector);
    }
    if(class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    } else {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

#pragma mark -
#pragma mark - 入口函数
-(void) run {
    
}



@end
