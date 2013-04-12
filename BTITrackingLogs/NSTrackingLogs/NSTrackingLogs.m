//
//  NSTrackingLogs.m
//  NSTrackingLogs
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "NSTrackingLogs.h"

#import "BTIStringProcessor.h"

@implementation NSTrackingLogs

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
	NSString *inputString = (NSString *)[input objectAtIndex:0];
	
	if (![inputString isKindOfClass:[NSString class]])
	{
		return input;
	}
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	
	return [processor outputString];
}


@end
