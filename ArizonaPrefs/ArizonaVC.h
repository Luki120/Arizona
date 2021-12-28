#import "../Constants.h"
#import <spawn.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <AudioToolbox/AudioServices.h>
#import <Preferences/PSListController.h>
#import <GcUniversal/HelperFunctions.h>


@interface OBWelcomeController : UIViewController
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)arg1;
@end


@interface _UIBackdropView : UIView
- (id)initWithSettings:(id)arg1;
@end


@interface PSListController (Private)
- (BOOL)containsSpecifier:(PSSpecifier *)arg1;
@end


@interface ArizonaVC : PSListController
@end


@interface ArizonaContributorsVC : PSListController
@end


@interface ArizonaLinksVC : PSListController
@end


@interface PSTableCell ()
- (void)setTitle:(NSString *)t;
@end


@interface ArizonaTintCell : PSTableCell
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
@end
