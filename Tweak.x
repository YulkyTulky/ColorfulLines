#import "ColorfulLines.h"

//--Handle Scrollbar--//
%hook _UIScrollViewScrollIndicator

- (void)didMoveToWindow {  // Hide (could not find a better method to override)

	%orig;

	if (scrollHidden && enabled) {
		self.hidden = YES;
	}

}

- (id)_colorForStyle:(long long)arg1 { // Set color

	if (scrollColorEnabled && enabled) {
		return scrollColor;
	} else {
		return %orig;
	}

}

%end

//--Handle Cursor--//
%hook UITextSelectionView

- (BOOL)visible {  // Hide

	if (caretHidden && enabled) {
		return NO;
	} else {
		return %orig;
	}

}

- (id)caretViewColor {  // Set color

	if (caretColorEnabled && enabled) {
		return caretColor;
	} else {
		return %orig;
	}

}

%end

static void loadPrefs() {

	NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.colorfullines.plist"];

	enabled = [preferences objectForKey:@"enabled"] ? [[preferences objectForKey:@"enabled"] boolValue] : YES;
	scrollColorEnabled = [preferences objectForKey:@"scrollColorEnabled"] ? [[preferences objectForKey:@"scrollColorEnabled"] boolValue] : YES;
	scrollColor = [SparkColourPickerUtils colourWithString: [preferences objectForKey:@"scrollColor"] withFallback: @"#ffffff:0.5"];
	scrollHidden = [preferences objectForKey:@"scrollHidden"] ? [[preferences objectForKey:@"scrollHidden"] boolValue] : NO;
	caretColorEnabled = [preferences objectForKey:@"caretColorEnabled"] ? [[preferences objectForKey:@"caretColorEnabled"] boolValue] : YES;
	caretColor = [SparkColourPickerUtils colourWithString: [preferences objectForKey:@"caretColor"] withFallback: @"#0984ff:1.0"];
	caretHidden = [preferences objectForKey:@"caretHidden"] ? [[preferences objectForKey:@"caretHidden"] boolValue] : NO;

}

%ctor {

	loadPrefs(); // Load preferences into variables
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.yulkytulky.colorfullines/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce); // Listen for preference changes

}