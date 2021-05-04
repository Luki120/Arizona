#include "ARIRootListController.h"




static NSString *plistPath = @"/var/mobile/Library/Preferences/com.luki.arizonaprefs.plist";


#define tint [UIColor colorWithRed: 0.02 green: 0.79 blue: 0.95 alpha: 1.00]


@implementation ARIRootListController


- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		NSArray *chosenIDs = @[@"GroupCell-1", @"SegmentCell", @"GroupCell-3", @"XAxisID", @"XValueID", @"YAxisID", @"YValueID", @"GroupCell-4", @"LockXAxis", @"LockXValueID", @"LockYAxis", @"LockYValueID"];
		self.savedSpecifiers = (self.savedSpecifiers) ?: [[NSMutableDictionary alloc] init];
		for(PSSpecifier *specifier in _specifiers) {
			if([chosenIDs containsObject:[specifier propertyForKey:@"id"]]) {
				[self.savedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"id"]];
			}
		}
    }

return _specifiers;

}


-(void)reloadSpecifiers {

    [super reloadSpecifiers];

    if (![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-1"]] boolValue]) {
        [self removeSpecifier:self.savedSpecifiers[@"GroupCell-1"] animated:NO];
        [self removeSpecifier:self.savedSpecifiers[@"SegmentCell"] animated:NO];
    } 
    else if (![self containsSpecifier:self.savedSpecifiers[@"GroupCell-1"]]) {
        [self insertSpecifier:self.savedSpecifiers[@"GroupCell-1"] afterSpecifierID:@"SWITCH_ID-1" animated:NO];
        [self insertSpecifier:self.savedSpecifiers[@"SegmentCell"] afterSpecifierID:@"GroupCell-1" animated:NO];
    
    }  
    if (![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-2"]] boolValue]) {
        [self removeContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-3"], self.savedSpecifiers[@"XAxisID"], self.savedSpecifiers[@"XValueID"], self.savedSpecifiers[@"YAxisID"], self.savedSpecifiers[@"YValueID"]] animated:NO];
    } 
    else if (![self containsSpecifier:self.savedSpecifiers[@"GroupCell-3"]]) {
        [self insertContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-3"], self.savedSpecifiers[@"XAxisID"], self.savedSpecifiers[@"XValueID"], self.savedSpecifiers[@"YAxisID"], self.savedSpecifiers[@"YValueID"]] afterSpecifierID:@"SWITCH_ID-2" animated:NO];
    }

    if (![[self readPreferenceValue:[self specifierForID:@"SWITCH_ID-3"]] boolValue]) {
        [self removeContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-4"], self.savedSpecifiers[@"LockXAxis"], self.savedSpecifiers[@"LockXValueID"], self.savedSpecifiers[@"LockYAxis"], self.savedSpecifiers[@"LockYValueID"]] animated:NO];
    } 
    else if (![self containsSpecifier:self.savedSpecifiers[@"GroupCell-4"]]) {
        [self insertContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-4"], self.savedSpecifiers[@"LockXAxis"], self.savedSpecifiers[@"LockXValueID"], self.savedSpecifiers[@"LockYAxis"], self.savedSpecifiers[@"LockYValueID"]] afterSpecifierID:@"SWITCH_ID-3" animated:NO];
    }
}


-(void)viewDidLoad {

	[super viewDidLoad];
	[self reloadSpecifiers];
	UIImage *banner = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ArizonaPrefs.bundle/pogbanner.png"];
	
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.width * banner.size.height / banner.size.width)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.image = banner;
    self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;

	self.navigationItem.titleView = [UIView new];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"3.3";
    if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark) self.titleLabel.textColor = [UIColor whiteColor];
	else if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleLight) self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationItem.titleView addSubview:self.titleLabel];

    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ArizonaPrefs.bundle/icon@2x.png"];
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconView.alpha = 0.0;
    [self.navigationItem.titleView addSubview:self.iconView];
    

    [self.headerView addSubview:self.headerImageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
        [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
        [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],   
        [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
		[self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
        [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
        [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
        [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
    ]];

}



-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;

    //self.navigationController.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 200) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    }

    if (offsetY > 0) offsetY = 0;
    self.headerImageView.frame = CGRectMake(0, offsetY, self.headerView.frame.size.width, 200 - offsetY);
}


-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

  
    if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark)

        [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

	else if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleLight)

        [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];	

}


-(id)readPreferenceValue:(PSSpecifier*)specifier {
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:plistPath]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}


-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:plistPath]];
    [settings setObject:value forKey:specifier.properties[@"key"]];
    [settings writeToFile:plistPath atomically:YES];
	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"glyphUpdated" object:NULL];
    

    NSString *key = [specifier propertyForKey:@"key"];

    if([key isEqualToString:@"yes"]) {
        
        if (![value boolValue]) {
            [self removeSpecifier:self.savedSpecifiers[@"GroupCell-1"] animated:YES];
            [self removeSpecifier:self.savedSpecifiers[@"SegmentCell"] animated:YES];
        } 
        else if (![self containsSpecifier:self.savedSpecifiers[@"SegmentCell"]]) {
            [self insertSpecifier:self.savedSpecifiers[@"GroupCell-1"] afterSpecifierID:@"SWITCH_ID-1" animated:YES];
            [self insertSpecifier:self.savedSpecifiers[@"SegmentCell"] afterSpecifierID:@"GroupCell-1" animated:YES];
        }
    }

    if([key isEqualToString:@"alternatePosition"]) {
        
        if (![value boolValue]) {
            [self removeContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-3"], self.savedSpecifiers[@"XAxisID"], self.savedSpecifiers[@"XValueID"], self.savedSpecifiers[@"YAxisID"], self.savedSpecifiers[@"YValueID"]] animated:YES];
        } 
        else if (![self containsSpecifier:self.savedSpecifiers[@"GroupCell-3"]]) {
            [self insertContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-3"], self.savedSpecifiers[@"XAxisID"], self.savedSpecifiers[@"XValueID"], self.savedSpecifiers[@"YAxisID"], self.savedSpecifiers[@"YValueID"]] afterSpecifierID:@"SWITCH_ID-2" animated:YES];
        }
    }

    if([key isEqualToString:@"lockGlyphPosition"]) {
        
        if (![value boolValue]) {
            [self removeContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-4"], self.savedSpecifiers[@"LockXAxis"], self.savedSpecifiers[@"LockXValueID"], self.savedSpecifiers[@"LockYAxis"], self.savedSpecifiers[@"LockYValueID"]] animated:YES];
        } 
        else if (![self containsSpecifier:self.savedSpecifiers[@"GroupCell-4"]]) {
            [self insertContiguousSpecifiers:@[self.savedSpecifiers[@"GroupCell-4"], self.savedSpecifiers[@"LockXAxis"], self.savedSpecifiers[@"LockXValueID"], self.savedSpecifiers[@"LockYAxis"], self.savedSpecifiers[@"LockYValueID"]] afterSpecifierID:@"SWITCH_ID-3" animated:YES];
        }
    }
}

-(void)discord {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://discord.gg/3ktkSq5ACK"] options:@{} completionHandler:nil];


}


-(void)paypal {


    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://paypal.me/Luki120"] options:@{} completionHandler:nil];


}


-(void)github {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/Luki120/Arizona"] options:@{} completionHandler:nil];


}


-(void)april {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://repo.twickd.com/package/com.twickd.luki120.april"] options:@{} completionHandler:nil];


}


-(void)meredith {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://parcility.co/package/com.twickd.luki120.meredith"] options:@{} completionHandler:nil];


}


-(void)perfectSpotify {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://parcility.co/package/com.twickd.luki120.perfectspotify/twickd"] options:@{} completionHandler:nil];


}


@end




@implementation ContributorsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"AriContributors" target:self];
	}

	return _specifiers;
}


-(void)luki {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/Lukii120"] options:@{} completionHandler:nil];


}


-(void)wizard {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/RuntimeOverflow"] options:@{} completionHandler:nil];


}


-(void)ben {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/BenOwl3"] options:@{} completionHandler:nil];


}


-(void)lacertosus {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/lacertosusdeus"] options:@{} completionHandler:nil];


}


-(void)miguelaka {


	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.reddit.com/user/Miguelaka95/"] options:@{} completionHandler:nil];


}


@end




@implementation OtherLinksRootListController


- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Other Links" target:self];
	}

	return _specifiers;
}

@end




@implementation ArizonaTableCell


- (void)tintColorDidChange {

	[super tintColorDidChange];

	self.textLabel.textColor = tint;
	self.textLabel.highlightedTextColor = tint;
}


- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {

	[super refreshCellContentsWithSpecifier:specifier];

	if ([self respondsToSelector:@selector(tintColor)]) {
		self.textLabel.textColor = tint;
		self.textLabel.highlightedTextColor = tint;
	}
}


@end