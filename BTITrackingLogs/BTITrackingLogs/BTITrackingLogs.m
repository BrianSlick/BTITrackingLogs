//
//  BTITrackingLogs.m
//  BTITrackingLogs
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTITrackingLogs.h"

#import "BTIStringProcessor.h"

@implementation BTITrackingLogs

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
	NSString *inputString = (NSString *)[input objectAtIndex:0];
	
	if (![inputString isKindOfClass:[NSString class]])
	{
		return input;
	}
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	
	return [processor outputString];
}

@end
