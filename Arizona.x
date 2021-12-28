#import "Constants.h"


@interface SBFLockScreenDateView : UIView
@end


@interface SBUIProudLockIconView : UIView
- (void)updateLockGlyphPosition;
@end


@interface NSDistributedNotificationCenter : NSNotificationCenter
@end


static BOOL yes;
static int position;

static BOOL alternatePosition;
static BOOL lockGlyphPosition;

static float coordinatesForX;
static float coordinatesForY;
static float lockCoordinatesForX;
static float lockCoordinatesForY;

static void loadWithoutAFuckingRespring() {

	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: kPath];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];
	yes = prefs[@"yes"] ? [prefs[@"yes"] boolValue] : NO;
	position = prefs[@"position"] ? [prefs[@"position"] integerValue] : 2;
	alternatePosition = prefs[@"alternatePosition"] ? [prefs[@"alternatePosition"] boolValue] : NO;
	lockGlyphPosition = prefs[@"lockGlyphPosition"] ? [prefs[@"lockGlyphPosition"] boolValue] : NO;
	coordinatesForX = prefs[@"coordinatesForX"] ? [prefs[@"coordinatesForX"] floatValue] : 0;
	coordinatesForY = prefs[@"coordinatesForY"] ? [prefs[@"coordinatesForY"] floatValue] : 0;
	lockCoordinatesForX = prefs[@"lockXValue"] ? [prefs[@"lockXValue"] floatValue] : 0;
	lockCoordinatesForY = prefs[@"lockYValue"] ? [prefs[@"lockYValue"] floatValue] : 0;

}


%group Arizona


%hook SBFLockScreenDateView


- (void)setAlignmentPercent:(double)arg1 { // fixed positions

	%orig;

	loadWithoutAFuckingRespring();

	if(yes)

		switch(position) {

			case 0:
		
				%orig(-1); // left
				break;

			case 1:

				%orig(0); // center
				break;

			case 2:

				%orig(1); // right
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

	if(lockGlyphPosition) self.frame = CGRectMake(lockCoordinatesForX, lockCoordinatesForY, self.frame.size.width, self.frame.size.height);

	else self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

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

	if(![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/LatchKey.dylib"])

		%init(ArizonaLockGlyph);

}
