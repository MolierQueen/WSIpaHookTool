#line 1 "/Users/molier/Desktop/Myself/WSIpaHookTool/WSIpaManager/theos/vendor/templates/ios/activator_listener/Listener.x"
#include <objc/runtime.h>
#include <dlfcn.h>
#import <libactivator/libactivator.h>
#import <HBLog.h>

static NSString *bundleID = @"@@PACKAGENAME@@Listener";
static LAActivator *_LASharedActivator;

@interface @@PROJECTNAME@@Listener : NSObject <LAListener>

+ (id)sharedInstance;

@end

@implementation @@PROJECTNAME@@Listener

+ (instancetype)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

+ (void)load {
	void *la = dlopen("/usr/lib/libactivator.dylib", RTLD_LAZY);
	if (!la) {
		HBLogDebug(@"Failed to load libactivator");
		_LASharedActivator = nil;
	} else {
		_LASharedActivator = [objc_getClass("LAActivator") sharedInstance];
	}

	[self sharedInstance];
}

- (instancetype)init {
	if ([super init]) {
		
		if (_LASharedActivator) {
			if (![_LASharedActivator hasSeenListenerWithName:bundleID]) {
				[_LASharedActivator assignEvent:[objc_getClass("LAEvent") eventWithName:@"libactivator.volume.both.press"] toListenerWithName:bundleID];
			}
			if (_LASharedActivator.isRunningInsideSpringBoard) {
				[_LASharedActivator registerListener:self forName:bundleID];
			}
		}
	}
	return self;
}

- (void)dealloc {
	if (_LASharedActivator) {
		if (_LASharedActivator.runningInsideSpringBoard) {
			[_LASharedActivator unregisterListenerWithName:bundleID];
		}
	}
}



- (BOOL)present {
	return NO;
}

- (BOOL)dismiss {
	return NO;
}



- (void)activator:(LAActivator *)activator didChangeToEventMode:(NSString *)eventMode {
	[self dismiss];

}




- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
	
	if ([self present]) {
		[event setHandled:YES];
	}
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
	
	
	[self dismiss];
}

- (BOOL)activator:(LAActivator *)activator receiveUnlockingDeviceEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
	
	return NO;
}

- (void)activator:(LAActivator *)activator receiveDeactivateEvent:(LAEvent *)event {
	
	
	if ([self dismiss]) {
		[event setHandled:YES];
	}
}

- (void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event {
	
	[self dismiss];
}

- (void)activator:(LAActivator *)activator receivePreviewEventForListenerName:(NSString *)listenerName {

}



- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
	return @"Example Listener";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
	return @"Example code for Activator";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
	return @"Example Group";
}

- (NSNumber *)activator:(LAActivator *)activator requiresRequiresAssignmentForListenerName:(NSString *)listenerName {
	
	return [NSNumber numberWithBool:NO];
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
	return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application", nil];
}

- (NSNumber *)activator:(LAActivator *)activator requiresIsCompatibleWithEventName:(NSString *)eventName listenerName:(NSString *)listenerName {
	return [NSNumber numberWithBool:YES];
}

- (NSArray *)activator:(LAActivator *)activator requiresExclusiveAssignmentGroupsForListenerName:(NSString *)listenerName {
	return [NSArray array];
}

- (id)activator:(LAActivator *)activator requiresInfoDictionaryValueOfKey:(NSString *)key forListenerWithName:(NSString *)listenerName {
	HBLogDebug(@"requiresInfoDictionaryValueOfKey: %@", key);
	return nil;
}

- (BOOL)activator:(LAActivator *)activator requiresNeedsPoweredDisplayForListenerName:(NSString *)listenerName {
	
	
	return YES;
}




- (NSData *)activator:(LAActivator *)activator requiresIconDataForListenerName:(NSString *)listenerName scale:(CGFloat *)scale {
	return nil;
}
- (NSData *)activator:(LAActivator *)activator requiresSmallIconDataForListenerName:(NSString *)listenerName scale:(CGFloat *)scale {
	return nil;
}

- (NSData *)activator:(LAActivator *)activator requiresIconDataForListenerName:(NSString *)listenerName {
	return nil;
}
- (NSData *)activator:(LAActivator *)activator requiresSmallIconDataForListenerName:(NSString *)listenerName {
	return nil;
}

- (UIImage *)activator:(LAActivator *)activator requiresIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale {
	return nil;
}
- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale {
	return nil;
}

- (id)activator:(LAActivator *)activator requiresGlyphImageDescriptorForListenerName:(NSString *)listenerName {
	return nil;
}



- (BOOL)activator:(LAActivator *)activator requiresSupportsRemovalForListenerWithName:(NSString *)listenerName {
	
	return NO;
}
- (void)activator:(LAActivator *)activator requestsRemovalForListenerWithName:(NSString *)listenerName {
	
	return;
}



- (NSString *)activator:(LAActivator *)activator requiresConfigurationViewControllerClassNameForListenerWithName:(NSString *)listenerName bundle:(NSBundle **)outBundle {
	*outBundle = [NSBundle bundleWithPath:@"/this/should/not/exist.bundle"];
	return nil;
}
- (id)activator:(LAActivator *)activator requestsConfigurationForListenerWithName:(NSString *)listenerName {
	return nil;
}
- (void)activator:(LAActivator *)activator didSaveNewConfiguration:(id)configuration forListenerWithName:(NSString *)listenerName {
	return;
}

@end
