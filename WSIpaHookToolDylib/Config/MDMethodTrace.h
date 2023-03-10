//
//
//  MDMethodTrace.h
//  Molier
//
//  Created by Molier on 2017/9/7.
//  Copyright ยฉ 2017ๅนด AloneMonkey. All rights reserved.
//

#ifndef MethodTrace_h
#define MethodTrace_h

#define TRACE_README @"\n๐--------------------OCMethodTrace(Usage)-------------------๐\nhttps://github.com/omxcodec/OCMethodTrace/blob/master/README.md\n๐--------------------OCMethodTrace(Usage)-------------------๐"

#import <UIKit/UIKit.h>

@interface MDMethodTrace : NSObject

+ (instancetype)sharedInstance;

- (void)addClassTrace:(NSString *) className;

- (void)addClassTrace:(NSString *)className methodName:(NSString *)methodName;

- (void)addClassTrace:(NSString *)className methodList:(NSArray *)methodList;

@end

#endif /* MethodTrace_h */
