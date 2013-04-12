//
//  NSString+BTIAdditions.m
//  AutomatorAddNSTrackingLogs
//
//  Created by Brian Slick on 4/7/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "NSString+BTIAdditions.h"

@implementation NSString (BTIAdditions)

- (instancetype)stringByRemovingLeadingWhitespaceBTI
{
	NSRange range = [self rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
	
	return [self stringByReplacingCharactersInRange:range withString:@""];
}

@end
