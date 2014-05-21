//
//  BTIAppDelegate.m
//  BTITrackingLogsApp
//
//  Created by Brian Slick on 5/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "BTIAppDelegate.h"

#import "BTIStringProcessor.h"

@implementation BTIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	NSURL *url = [[NSBundle mainBundle] URLForResource:@"sampleInput" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	
	NSLog(@"\ninput:\n-----\n%@\n-----", inputString);
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	
	NSString *outputString = [processor outputString];
	
	NSLog(@"\nfinal output:\n-----\n%@\n-----", outputString);

	NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
