//
//  HookClass.h
//  WSIpaHookToolDylib
//
//  Created by Molier on 2023/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HookClass : NSObject

/// 单利
+(instancetype)sharedInstance;


/// 方法交换
/// @param classObjectStr 原方法所在类名
/// @param classMethodStr 是否是类方法
/// @param fromSelectorStr 原方法
/// @param toClassStr 自定义目标法所在类
/// @param toSelectorStr 自定义目标方法
+ (void) hookOriginalClass:(NSString *)classObjectStr
                   isClassMetohd:(BOOL)classMethodStr
                originalSelector:(NSString *)fromSelectorStr
                              toClass:(NSString *)toClassStr
                         toSelector:(NSString *)toSelectorStr;

/// 入口函数
-(void) run;
@end

NS_ASSUME_NONNULL_END
