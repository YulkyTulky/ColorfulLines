#include "CFLRootListController.h"

@implementation CFLRootListController

- (NSArray *)specifiers {

	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	NSArray *chosenIDs = @[@"101", @"201", @"301", @"401", @"501"];
	[self setSavedSpecifiers:(![self savedSpecifiers]) ? [[NSMutableDictionary alloc] init] : [self savedSpecifiers]];
	for (PSSpecifier *specifier in _specifiers) {
		if ([chosenIDs containsObject:[specifier propertyForKey:@"id"]]) {
			[[self savedSpecifiers] setObject:specifier forKey:[specifier propertyForKey:@"id"]];
		}
	}

	return _specifiers;

}

- (id)readPreferenceValue:(PSSpecifier*)specifier {

	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}

	NSString *key = [specifier propertyForKey:@"key"];
	if ([key isEqualToString:@"scrollColorFromIcon"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"101"]] afterSpecifierID:@"100" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"101"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"101"]] animated:YES];
		}
	}
	if ([key isEqualToString:@"cursorColorFromIcon"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"201"]] afterSpecifierID:@"200" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"201"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"201"]] animated:YES];
		}
	}
	if ([key isEqualToString:@"floatingCursorColorFromIcon"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"301"]] afterSpecifierID:@"300" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"301"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"301"]] animated:YES];
		}
	}
	if ([key isEqualToString:@"selectionBarColorFromIcon"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"401"]] afterSpecifierID:@"400" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"401"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"401"]] animated:YES];
		}
	}
	if ([key isEqualToString:@"highlightColorFromIcon"]) {
		if (![value boolValue]) {
			[self insertContiguousSpecifiers:@[[self savedSpecifiers][@"501"]] afterSpecifierID:@"500" animated:YES];
		} else if ([self containsSpecifier:[self savedSpecifiers][@"501"]]) {
			[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"501"]] animated:YES];
		}
	}

}

- (void)reloadSpecifiers {

  	[super reloadSpecifiers];

	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.colorfullines.plist"];
  	if ([preferences[@"scrollColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"101"]] animated:NO];
	}
	if ([preferences[@"cursorColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"201"]] animated:NO];
	}
	if ([preferences[@"floatingCursorColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"301"]] animated:NO];
	}
	if ([preferences[@"selectionBarColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"401"]] animated:NO];
	}
	if ([preferences[@"highlightColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"501"]] animated:NO];
	}

}

- (void)viewDidLoad {

    [super viewDidLoad];

	NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.colorfullines.plist"];
  	if ([preferences[@"scrollColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"101"]] animated:NO];
	}
	if ([preferences[@"cursorColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"201"]] animated:NO];
	}
	if ([preferences[@"floatingCursorColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"301"]] animated:NO];
	}
	if ([preferences[@"selectionBarColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"401"]] animated:NO];
	}
	if ([preferences[@"highlightColorFromIcon"] boolValue]) {
		[self removeContiguousSpecifiers:@[[self savedSpecifiers][@"501"]] animated:NO];
	}

}

- (void)github {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/YulkyTulky/ColorfulLines"] options:@{} completionHandler:nil];

}

- (void)discord {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/Z8hqzXY"] options:@{} completionHandler:nil];

}

@end