#import <SparkColourPickerUtils.h>
#import "ColorfulLines-Swift.h"

//--Preferences Variables--//
BOOL enabled;

BOOL scrollColorEnabled;
BOOL scrollColorFromIcon;
UIColor *scrollColor;
BOOL scrollHidden;

BOOL caretColorEnabled;
BOOL cursorColorFromIcon;
UIColor *caretColor;
BOOL caretHidden;

BOOL floatingCaretColorEnabled;
BOOL floatingCursorColorFromIcon;
UIColor *floatingCaretColor;

BOOL selectionBarColorEnabled;
BOOL selectionBarColorFromIcon;
UIColor *selectionBarColor;

BOOL highlightColorEnabled;
BOOL highlightColorFromIcon;
UIColor *highlightColor;

//--Global Variables--//
UIColor *iconColor;

//--Interface Declarations--//
@interface UIImage (ColorfulLines)
+ (UIImage *)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(int)arg3;
@end

@interface _UIScrollViewScrollIndicator: UIView
@end

@interface UITextSelectionView
@end

@interface UITextInputTraits
@end