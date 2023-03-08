#line 1 "/Users/molier/Desktop/Myself/WSIpaHookTool/WSIpaManager/theos/vendor/templates/ios/tweak_with_simple_preferences/Tweak.x"
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSUserDefaults+Private.h>

static NSString * nsDomainString = @"@@PACKAGENAME@@";
static NSString * nsNotificationString = @"@@PACKAGENAME@@/preferences.changed";
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber * enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
	enabled = (enabledValue)? [enabledValue boolValue] : YES;
}

static __attribute__((constructor)) void _logosLocalCtor_3d22e308(int __unused argc, char __unused **argv, char __unused **envp) {
	
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);

	

}
