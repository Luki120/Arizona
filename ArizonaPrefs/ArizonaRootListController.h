#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSListController.h>
#import <AudioToolbox/AudioServices.h>


UIBarButtonItem *changelogButtonItem;


@interface OBButtonTray : UIView
@property (nonatomic,retain) UIVisualEffectView * effectView;
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;;
@end


@interface OBBoldTrayButton : UIButton
- (void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+ (id)buttonWithType:(long long)arg1;
@end


@interface OBWelcomeController : UIViewController
@property (nonatomic, retain) UIView * viewIfLoaded;
@property (nonatomic, strong) UIColor * backgroundColor;
@property (assign, nonatomic) BOOL _shouldInlineButtontray;
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(long long)arg1;
@end

@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
- (id)initWithSettings:(id)arg1;
@property (assign, nonatomic) BOOL blurRadiusSetOnce;
@property (assign, nonatomic) double _blurRadius;
@property (nonatomic, copy) NSString * _blurQuality;
@end


@interface ArizonaRootListController : PSListController
@property (nonatomic, strong) NSMutableDictionary *savedSpecifiers;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) OBWelcomeController *changelogController;
- (void)showWtfChangedInThisVersion:(UIButton *)sender;
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


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end