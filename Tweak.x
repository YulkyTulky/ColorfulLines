#import "ColorfulLines.h"

%group iOS13 // Open iOS13 Group

//--Handle Scrollbar--//
%hook _UIScrollViewScrollIndicator

- (void)didMoveToWindow {  // Hide scrollbar (could not find a better method to override)

	%orig;

	if (scrollHidden && enabled) {
		[self setHidden:YES];
	}

}

- (id)_colorForStyle:(long long)arg1 {  // Set scrollbar color

	if (scrollColorEnabled && enabled) {
		return scrollColor;
	} else {
		return %orig;
	}

}

%end

%end // Close iOS13 Group

%group iOS12 // Open iOS12 Group

//--Handle Scrollbar--//
%hook UIScrollView

- (void)didMoveToWindow {  // Hide scrollbar (could not find a better method to override)

	%orig;

	if (scrollHidden && enabled) {
		[self setHidden:YES];
	}

}

- (void)addSubview:(UIView *)view {  // Set scrollbar color

	%orig;

	if (scrollColorEnabled && enabled) {
		if ([view isMemberOfClass:[UIImageView class]] && CGSizeEqualToSize(view.frame.size, CGSizeMake(2.5, 2.5))) {  // CODE USED FROM https://github.com/shepgoba/ColorScroll/blob/master/Tweak.xm
			UIImageView *imgView = (UIImageView *)view;
			[imgView setBackgroundColor:scrollColor];
			[[imgView layer] setCornerRadius:1.5];
			[imgView setImage:nil];
		}
	}

}

%end

%end // Close iOS12 Group

// *********************************************** //
// ALL BELOW IS COMPATIBLE WITH BOTH iOS 12 AND 13 //

//--Handle Cursor--//
%hook UITextSelectionView

- (BOOL)visible {  // Hide cursor

	if (caretHidden && enabled) {
		return NO;  // Note that this will also hide the selection bar and highlight
	} else {
		return %orig;
	}

}

- (id)caretViewColor {  // Set cursor color

	if (caretColorEnabled && enabled) {
		return caretColor;
	} else {
		return %orig;
	}

}

- (id)floatingCaretViewColor {  // Set floating cursor color

	if (floatingCaretColorEnabled && enabled) {
		return floatingCaretColor;
	} else {
		return %orig;  // Note that %orig here will return custom cursor color if enabled
	}

}

%end

//--Handle  Selection Bar and Highlight--//
%hook UITextInputTraits

- (UIColor *)selectionBarColor {  // Set selection bar color

	if (selectionBarColorEnabled && enabled) {
		return selectionBarColor;
	} else {
		return %orig;
	}

}

- (UIColor *)selectionHighlightColor { // Set highlight color

	if (highlightColorEnabled && enabled) {
		return highlightColor;
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
	floatingCaretColorEnabled = [preferences objectForKey:@"floatingCaretColorEnabled"] ? [[preferences objectForKey:@"floatingCaretColorEnabled"] boolValue] : YES;
	floatingCaretColor = [SparkColourPickerUtils colourWithString: [preferences objectForKey:@"floatingCaretColor"] withFallback: @"#0984ff:1.0"];
	caretHidden = [preferences objectForKey:@"caretHidden"] ? [[preferences objectForKey:@"caretHidden"] boolValue] : NO;

	selectionBarColorEnabled = [preferences objectForKey:@"selectionBarColorEnabled"] ? [[preferences objectForKey:@"selectionBarColorEnabled"] boolValue] : YES;
	selectionBarColor = [SparkColourPickerUtils colourWithString: [preferences objectForKey:@"selectionBarColor"] withFallback: @"#0984ff:1.0"];

	highlightColorEnabled = [preferences objectForKey:@"highlightColorEnabled"] ? [[preferences objectForKey:@"highlightColorEnabled"] boolValue] : YES;
	highlightColor = [SparkColourPickerUtils colourWithString: [preferences objectForKey:@"highlightColor"] withFallback: @"#0984ff:0.1"];

}

%ctor {

	loadPrefs(); // Load preferences into variables
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.yulkytulky.colorfullines/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce); // Listen for preference changes

	%init;

	// fixed bug here in version 1.2
	if (@available(iOS 13.0, *)) {
		%init(iOS13);
	} else {
		%init(iOS12);
	}

}
// If you're reading this, I hope you had a jolly time reading my code! Have a wonderful day!