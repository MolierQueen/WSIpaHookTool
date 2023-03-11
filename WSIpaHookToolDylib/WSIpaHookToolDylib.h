//
//
//  WSIpaHookToolDylib.h
//  WSIpaHookToolDylib
//
//  Created by Molier on 2023/3/8.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INJECT_SUCCESS "🎉🎉自定义动态库注入成功，可以开始二次开发🎉🎉"

@interface CustomViewController

@property (nonatomic, copy) NSString* newProperty;

+ (void)classMethod;

- (NSString*)getMyName;

- (void)newMethod:(NSString*) output;

@end
