#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface PSListController (ColorfulLines)
- (BOOL)containsSpecifier:(id)arg1;
@end

@interface CFLRootListController: PSListController
@property (nonatomic, retain) NSMutableDictionary *savedSpecifiers;
@property (nonatomic) BOOL enabledSwitchStateWhenLastReset;
@end