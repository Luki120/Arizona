#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSListController.h>




@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end


@interface ArizonaRootListController : PSListController
@property (nonatomic, retain) NSMutableDictionary *savedSpecifiers;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UIImageView *iconView;
@end


@interface PSListController (Private)
-(BOOL)containsSpecifier:(PSSpecifier *)arg1;
@end


@interface ArizonaContributorsRootListController : PSListController
@end


@interface OtherLinksRootListController : PSListController
@end


@interface ArizonaTableCell : PSTableCell
@end