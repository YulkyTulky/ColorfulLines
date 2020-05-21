#import "SparkColourPickerUtils.h"

//--Macros--//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//--Preferences Variables--//
BOOL enabled;
BOOL scrollColorEnabled;
UIColor *scrollColor;
BOOL scrollHidden;

BOOL caretColorEnabled;
UIColor *caretColor;
BOOL floatingCaretColorEnabled;
UIColor *floatingCaretColor;
BOOL caretHidden;

BOOL selectionBarColorEnabled;
UIColor *selectionBarColor;

BOOL highlightColorEnabled;
UIColor *highlightColor;

//--Interace Declarations--//
@interface _UIScrollViewScrollIndicator: UIView
@end

/* @interface UIScrollView: UIView
@end */

@interface UITextSelectionView
@end

@interface UITextInputTraits
@end