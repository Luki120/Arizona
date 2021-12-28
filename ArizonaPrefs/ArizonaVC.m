#import "ArizonaVC.h"


@implementation ArizonaVC {

	UILabel *versionLabel;
	UIImageView *iconView;
	UIView *headerView;
	UIImageView *headerImageView;
	NSMutableDictionary *savedSpecifiers;
	OBWelcomeController *changelogController;

}


- (NSArray *)specifiers {

	if(!_specifiers) {

		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

		NSArray *specifiersIDs = @[

			@"GroupCell-1",
			@"SegmentCell",
			@"GroupCell-3",
			@"XAxisID",
			@"XValueID",
			@"YAxisID",
			@"YValueID",
			@"GroupCell-4",
			@"LockXAxis",
			@"LockXValueID",
			@"LockYAxis",
			@"LockYValueID"

		];

		savedSpecifiers = (savedSpecifiers) ?: [NSMutableDictionary new];

		for(PSSpecifier *specifier in _specifiers)

			if([specifiersIDs containsObject:[specifier propertyForKey:@"id"]])

				[savedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"id"]];

	}

	return _specifiers;

}


- (id)init {

	self = [super init];

	if(self) [self setupUI];

	return self;

}


- (void)viewDidLoad {

	[super viewDidLoad];
	[self reloadSpecifiers];

}


- (void)setupUI {

	UIImage *changelogButtonImage = [UIImage systemImageNamed:@"atom"];
	UIImage *iconImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ArizonaPrefs.bundle/Assets/Arizona@2x.png"];
	UIImage *bannerImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ArizonaPrefs.bundle/Assets/ArizonaBanner.png"];

	UIButton *changelogButton = [UIButton new];
	changelogButton.tintColor = AriTintColor;
	[changelogButton setImage : changelogButtonImage forState: UIControlStateNormal];
	[changelogButton addTarget : self action:@selector(showWtfChangedInThisVersion) forControlEvents: UIControlEventTouchUpInside];

	UIBarButtonItem *changelogButtonItem = [[UIBarButtonItem alloc] initWithCustomView: changelogButton];
	self.navigationItem.rightBarButtonItem = changelogButtonItem;

	self.navigationItem.titleView = [UIView new];

	versionLabel = [UILabel new];
	versionLabel.font = [UIFont boldSystemFontOfSize: 17];
	versionLabel.text = @"4.1";
	versionLabel.textAlignment = NSTextAlignmentCenter;
	versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.navigationItem.titleView addSubview: versionLabel];

	iconView = [UIImageView new];
	iconView.alpha = 0;
	iconView.image = iconImage;
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	iconView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.navigationItem.titleView addSubview: iconView];

	headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
	headerImageView = [UIImageView new];
	headerImageView.image = bannerImage;
	headerImageView.contentMode = UIViewContentModeScaleAspectFill;
	headerImageView.clipsToBounds = YES;
	headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[headerView addSubview: headerImageView];

	[self layoutUI];

}


- (void)layoutUI {

	[iconView anchorEqualsToView: self.navigationItem.titleView padding: UIEdgeInsetsZero];
	[versionLabel anchorEqualsToView: self.navigationItem.titleView padding: UIEdgeInsetsZero];
	[headerImageView anchorEqualsToView: headerView padding: UIEdgeInsetsZero];

}


- (void)reloadSpecifiers {

	[super reloadSpecifiers];

	if(![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-1"]] boolValue]) {

		[self removeSpecifier:savedSpecifiers[@"GroupCell-1"] animated:NO];
		[self removeSpecifier:savedSpecifiers[@"SegmentCell"] animated:NO];

	}

	else if(![self containsSpecifier:savedSpecifiers[@"GroupCell-1"]]) {

		[self insertSpecifier:savedSpecifiers[@"GroupCell-1"] afterSpecifierID:@"SWITCH_ID-1" animated:NO];
		[self insertSpecifier:savedSpecifiers[@"SegmentCell"] afterSpecifierID:@"GroupCell-1" animated:NO];

	}

	if(![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-2"]] boolValue])

		[self removeContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-3"], savedSpecifiers[@"XAxisID"], savedSpecifiers[@"XValueID"], savedSpecifiers[@"YAxisID"], savedSpecifiers[@"YValueID"]] animated:NO];

	else if(![self containsSpecifier:savedSpecifiers[@"GroupCell-3"]])

		[self insertContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-3"], savedSpecifiers[@"XAxisID"], savedSpecifiers[@"XValueID"], savedSpecifiers[@"YAxisID"], savedSpecifiers[@"YValueID"]] afterSpecifierID:@"SWITCH_ID-2" animated:NO];

	if(![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-3"]] boolValue])

		[self removeContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-4"], savedSpecifiers[@"LockXAxis"], savedSpecifiers[@"LockXValueID"], savedSpecifiers[@"LockYAxis"], savedSpecifiers[@"LockYValueID"]] animated:NO];

	else if(![self containsSpecifier:savedSpecifiers[@"GroupCell-4"]])

		[self insertContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-4"], savedSpecifiers[@"LockXAxis"], savedSpecifiers[@"LockXValueID"], savedSpecifiers[@"LockYAxis"], savedSpecifiers[@"LockYValueID"]] afterSpecifierID:@"SWITCH_ID-3" animated:NO];

}


- (void)showWtfChangedInThisVersion {

	AudioServicesPlaySystemSound(1521);

	UIImage *tweakIconImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ArizonaPrefs.bundle/Assets/ArizonaHotIcon.png"];
	UIImage *checkmarkImage = [UIImage systemImageNamed:@"checkmark.circle.fill"];

	changelogController = [[OBWelcomeController alloc] initWithTitle:@"Arizona" detailText:@"4.1" icon: tweakIconImage];

	[changelogController addBulletedListItemWithTitle:@"Code" description:@"Refactoring." image: checkmarkImage];

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings: settings];
	backdropView.clipsToBounds = YES;
	backdropView.layer.masksToBounds = YES;
	backdropView.translatesAutoresizingMaskIntoConstraints = NO;	
	[changelogController.viewIfLoaded insertSubview:backdropView atIndex:0];

	[backdropView.topAnchor constraintEqualToAnchor : changelogController.viewIfLoaded.topAnchor].active = YES;
	[backdropView.bottomAnchor constraintEqualToAnchor : changelogController.viewIfLoaded.bottomAnchor].active = YES;
	[backdropView.leadingAnchor constraintEqualToAnchor : changelogController.viewIfLoaded.leadingAnchor].active = YES;
	[backdropView.trailingAnchor constraintEqualToAnchor : changelogController.viewIfLoaded.trailingAnchor].active = YES;

	changelogController.view.tintColor = AriTintColor;
	changelogController.modalInPresentation = NO;
	changelogController.modalPresentationStyle = UIModalPresentationPageSheet;
	changelogController.viewIfLoaded.backgroundColor = UIColor.clearColor;
	[self presentViewController:changelogController animated:YES completion:nil];

}


- (void)shatterThePrefsToPieces {

	AudioServicesPlaySystemSound(1521);

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Arizona" message:@"Do you want to start fresh?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		NSFileManager *fileM = [NSFileManager defaultManager];

		[fileM removeItemAtPath:kPath error:nil];

		[self crossDissolveBlur];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Meh" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction: confirmAction];
	[alertController addAction: cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}


- (void)crossDissolveBlur {

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings:settings];
	backdropView.alpha = 0;
	backdropView.frame = self.view.bounds;
	backdropView.clipsToBounds = YES;
	backdropView.layer.masksToBounds = YES;
	[self.view addSubview:backdropView];

	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

		backdropView.alpha = 1;

	} completion:^(BOOL finished) { [self launchRespring]; }];

}


- (void)launchRespring {

	pid_t pid;
	const char* args[] = {"sbreload", NULL};
	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	CGFloat offsetY = scrollView.contentOffset.y;

	if(offsetY > 150) {

		[UIView animateWithDuration:0.2 animations:^{

			iconView.alpha = 1;
			versionLabel.alpha = 0;

		}];

	}

	else {

		[UIView animateWithDuration:0.2 animations:^{

			iconView.alpha = 0;
			versionLabel.alpha = 1;

		}];

	}

}


- (id)readPreferenceValue:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile: kPath]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:kPath atomically:YES];

	[super setPreferenceValue:value specifier:specifier];

	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"glyphUpdated" object:nil];

	NSString *key = [specifier propertyForKey:@"key"];

	if([key isEqualToString:@"yes"]) {

		if(![value boolValue]) {

			[self removeSpecifier:savedSpecifiers[@"GroupCell-1"] animated:YES];
			[self removeSpecifier:savedSpecifiers[@"SegmentCell"] animated:YES];

		}

		else if(![self containsSpecifier:savedSpecifiers[@"SegmentCell"]]) {

			[self insertSpecifier:savedSpecifiers[@"GroupCell-1"] afterSpecifierID:@"SWITCH_ID-1" animated:YES];
			[self insertSpecifier:savedSpecifiers[@"SegmentCell"] afterSpecifierID:@"GroupCell-1" animated:YES];

		}

	}

	if([key isEqualToString:@"alternatePosition"]) {

		if(![value boolValue])

			[self removeContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-3"], savedSpecifiers[@"XAxisID"], savedSpecifiers[@"XValueID"], savedSpecifiers[@"YAxisID"], savedSpecifiers[@"YValueID"]] animated:YES];

		else if(![self containsSpecifier:savedSpecifiers[@"GroupCell-3"]])

			[self insertContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-3"], savedSpecifiers[@"XAxisID"], savedSpecifiers[@"XValueID"], savedSpecifiers[@"YAxisID"], savedSpecifiers[@"YValueID"]] afterSpecifierID:@"SWITCH_ID-2" animated:YES];

	}

	if([key isEqualToString:@"lockGlyphPosition"]) {

		if(![value boolValue])

			[self removeContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-4"], savedSpecifiers[@"LockXAxis"], savedSpecifiers[@"LockXValueID"], savedSpecifiers[@"LockYAxis"], savedSpecifiers[@"LockYValueID"]] animated:YES];

		else if(![self containsSpecifier:savedSpecifiers[@"GroupCell-4"]])

			[self insertContiguousSpecifiers:@[savedSpecifiers[@"GroupCell-4"], savedSpecifiers[@"LockXAxis"], savedSpecifiers[@"LockXValueID"], savedSpecifiers[@"LockYAxis"], savedSpecifiers[@"LockYValueID"]] afterSpecifierID:@"SWITCH_ID-3" animated:YES];

	}

}


#pragma mark Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = headerView;
	return [super tableView:tableView cellForRowAtIndexPath: indexPath];

}


@end


@implementation ArizonaContributorsVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AriContributors" target:self];

	return _specifiers;

}


@end


@implementation ArizonaLinksVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"AriLinks" target:self];

	return _specifiers;

}


- (void)launchDiscord {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://discord.gg/jbE3avwSHs"] options:@{} completionHandler:nil];

}


- (void)launchGitHub {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://github.com/Luki120/Arizona"] options:@{} completionHandler:nil];

}


- (void)launchPayPal {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://paypal.me/Luki120"] options:@{} completionHandler:nil];

}


- (void)launchApril {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.twickd.com/get/com.twickd.luki120.april"] options:@{} completionHandler:nil];

}


- (void)launchMeredith {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.twickd.com/get/com.twickd.luki120.meredith"] options:@{} completionHandler:nil];

}


@end


@implementation ArizonaTintCell


- (void)setTitle:(NSString *)t {

	[super setTitle:t];

	self.titleLabel.textColor = AriTintColor;

}


@end
