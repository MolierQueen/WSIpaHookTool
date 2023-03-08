#line 1 "/Users/molier/Desktop/Myself/WSIpaHookTool/WSIpaManager/theos/vendor/templates/ios/activator_event/Event.x"
#include <dispatch/dispatch.h>
#import <libactivator/libactivator.h>

#define LASendEventWithName(eventName) \
	[LASharedActivator sendEventToListener:[LAEvent eventWithName:eventName mode:[LASharedActivator currentEventMode]]]

static NSString *@@PROJECTNAME@@_eventName = @"@@PROJECTNAME@@Event";

@interface @@PROJECTNAME@@DataSource : NSObject <LAEventDataSource>

+ (instancetype)sharedInstance;

@end

@implementation @@PROJECTNAME@@DataSource

+ (instancetype)sharedInstance {
	static @@PROJECTNAME@@DataSource * sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

+ (void)load {
	[self sharedInstance];
}

- (id)init {
	if ((self = [super init])) {
		
		if (LASharedActivator.isRunningInsideSpringBoard) {
			[LASharedActivator registerEventDataSource:self forEventName:@@PROJECTNAME@@_eventName];
		}
	}
	return self;
}

- (void)dealloc {
	if (LASharedActivator.isRunningInsideSpringBoard) {
		[LASharedActivator unregisterEventDataSourceWithEventName:@@PROJECTNAME@@_eventName];
	}
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
	return @"Event Title";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
	return @"Event Group";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
	return @"Event Description";
}










- (BOOL)eventWithName:(NSString *)eventName isCompatibleWithMode:(NSString *)eventMode {
	return YES;
}






@end
















