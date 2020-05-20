#import "SparkColourPickerUtils.h"

//--Preferences Variables--//
BOOL enabled;
BOOL scrollColorEnabled;
UIColor *scrollColor;
BOOL scrollHidden;
BOOL caretColorEnabled;
UIColor *caretColor;
BOOL caretHidden;

//--Interace Declarations--//
@interface _UIScrollViewScrollIndicator: UIView
@property (nonatomic, strong, readwrite) UIColor *foregroundColor;
@end

@interface UITextSelectionView
@end