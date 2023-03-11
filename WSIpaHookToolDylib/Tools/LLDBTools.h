//
//
//  LLDBTools.h
//  Molier
//
//  Created by Molier on 2023/3/8.
//  Copyright © 2023年 Molier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach/vm_types.h>

//(lldb) po pviews()

NSString* pvc(void);

NSString* pviews(void);

NSString* pactions(vm_address_t address);

NSString* pblock(vm_address_t address);

NSString* methods(const char * classname);

NSString* ivars(vm_address_t address);

NSString* choose(const char* classname);

NSString* vmmap();
