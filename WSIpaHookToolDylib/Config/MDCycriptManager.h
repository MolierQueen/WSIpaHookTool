//
//
//  MDCycriptManager.h
//  Molier
//
//  Created by Molier on 2023/3/8.
//  Copyright © 2023年 Molier. All rights reserved.
//

#ifndef __OPTIMIZE__

#import <Foundation/Foundation.h>

#define PORT            6666

@interface MDCycriptManager : NSObject

+ (instancetype)sharedInstance;


/**
 Download script by config.plist

 @param update Force update of all scripts
 */
-(void)loadCycript:(BOOL) update;

/**
 eval javascript by cycript

 @param cycript javascript string
 @param error error happened
 @return eval result
 */
-(NSString*)evaluateCycript:(NSString*) cycript error:(NSError **) error;

@end

#endif
