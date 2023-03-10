//
//
//  MDConfigManager.m
//  Molier
//
//  Created by Molier on 2018/4/24.
//  Copyright © 2023年 Molier. All rights reserved.
//

#define CONFIG_FILE_NAME        @"MDConfig"

#import "MDConfigManager.h"

@implementation MDConfigManager{
    NSString* _filepath;
}

+ (instancetype)sharedInstance{
    static MDConfigManager *sharedInstance = nil;
    if (!sharedInstance){
        sharedInstance = [[MDConfigManager alloc] init];
    }
    return sharedInstance;
}

- (BOOL)isActive{
    _filepath = [[NSBundle mainBundle] pathForResource:CONFIG_FILE_NAME ofType:@"plist"];
    if(_filepath == nil){
        return NO;
    }
    return YES;
}

- (NSDictionary*) readConfigByKey:(NSString*) key{
    if([self isActive]){
        NSDictionary* contentDict = [NSDictionary dictionaryWithContentsOfFile:_filepath];
        if([contentDict.allKeys containsObject:key]){
            return contentDict[key];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

@end
