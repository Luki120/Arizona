@import UIKit;


@interface SBFLockScreenDateView : UIView
@end


@interface SBUIProudLockIconView : UIView
- (void)updateLockGlyphPosition;
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSString *)name object:(NSString *)object userInfo:(NSDictionary *)userInfo;
@end


static NSString *plistPath = @"/var/mobile/Library/Preferences/me.luki.arizonaprefs.plist";

static BOOL yes;
static int style;

static BOOL alternatePosition;
static BOOL lockGlyphPosition;


CGFloat coordinatesForX;
CGFloat coordinatesForY;
CGFloat lockCoordinatesForX;
CGFloat lockCoordinatesForY;


static void loadWithoutAFuckingRespring() {


	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	yes = prefs[@"yes"] ? [prefs[@"yes"] boolValue] : NO;
	style = prefs[@"style"] ? [prefs[@"style"] integerValue] : 2;
	alternatePosition = prefs[@"alternatePosition"] ? [prefs[@"alternatePosition"] boolValue] : NO;
	lockGlyphPosition = prefs[@"lockGlyphPosition"] ? [prefs[@"lockGlyphPosition"] boolValue] : NO;
	int xValue = prefs[@"xValue"] ? [prefs[@"xValue"] intValue] : 1;
	coordinatesForX = (float)xValue;
	int yValue = prefs[@"yValue"] ? [prefs[@"yValue"] intValue] : 1;
	coordinatesForY = (float)yValue;
	lockCoordinatesForX = prefs[@"lockXValue"] ? [prefs[@"lockXValue"] intValue] : 1;
	lockCoordinatesForY = prefs[@"lockYValue"] ? [prefs[@"lockYValue"] intValue] : 1;


}


%group Arizona


%hook SBFLockScreenDateView


- (void)setAlignmentPercent:(double)arg1 { // fixed positions


	%orig;

	loadWithoutAFuckingRespring();

	if(yes)

		switch(style) {

			case 0:
		
				%orig(1); // right
				break;

			case 1:

				%orig(0); // center
				break;

			case 2:

				%orig(-1); // left
				break;

		}


}


- (void)setFrame:(CGRect)frame { // custom position


	%orig;
	
	loadWithoutAFuckingRespring();

	if(alternatePosition) {

		CGRect newFrame = CGRectMake(coordinatesForX, coordinatesForY, frame.size.width, frame.size.height);

		%orig(newFrame);

	}


}


%end
%end




%group ArizonaLockGlyph


%hook SBUIProudLockIconView


%new


- (void)updateLockGlyphPosition { // self explanatory


	loadWithoutAFuckingRespring();

	if(lockGlyphPosition) {
		
		self.frame = CGRectMake(lockCoordinatesForX, lockCoordinatesForY, self.frame.size.width, self.frame.size.height);
	
	} else self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);


}


- (void)didMoveToSuperview { // add notification observers && call the function we need


	%orig;

	[self updateLockGlyphPosition];

	[NSDistributedNotificationCenter.defaultCenter removeObserver:self];
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateLockGlyphPosition) name:@"glyphUpdated" object:nil];


}


- (void)layoutSubviews { // I don't like this either, but just updating a view.


	%orig;

	[self updateLockGlyphPosition];


}


%end
%end




%ctor {


	loadWithoutAFuckingRespring();

	%init(Arizona);

	if(![[NSFileManager defaultManager] fileExistsAtPath:@"Library/MobileSubstrate/DynamicLibraries/LatchKey.dylib"])

		%init(ArizonaLockGlyph);


}