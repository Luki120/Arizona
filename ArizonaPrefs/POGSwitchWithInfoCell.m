#import "POGSwitchWithInfoCell.h"




#define tint [UIColor colorWithRed: 0.02 green: 0.79 blue: 0.95 alpha: 1.00]




@implementation POGSwitchWithInfoCell {


    UIButton *_infoButton;


}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {

    self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

    // Add button next to cell

    if(self) {


        _infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        _infoButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_infoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_infoButton];

        [NSLayoutConstraint activateConstraints:@[

            [_infoButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [_infoButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4],
        ]];

    }


    return self;


}

    // Show alert


- (IBAction)infoButtonTapped {

    NSString *title = ([self.specifier propertyForKey:@"infoTitle"]) ?: [self.specifier propertyForKey:@"label"];
    NSString *message = ([self.specifier propertyForKey:@"infoMessage"]) ?: @"No information provided for this cell";

    UIAlertController *infoAlert = [UIAlertController alertControllerWithTitle:title message:[message stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    [infoAlert addAction:cancelAction];

    UIViewController *rootViewController = self._viewControllerForAncestor ?: [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:infoAlert animated:YES completion:nil];


}


    // Tint label

- (void)tintColorDidChange {

    [super tintColorDidChange];

    _infoButton.tintColor = tint;


}


- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {

    [super refreshCellContentsWithSpecifier:specifier];

    if([self respondsToSelector:@selector(tintColor)]) {

        _infoButton.tintColor = tint;

    }

}


@end