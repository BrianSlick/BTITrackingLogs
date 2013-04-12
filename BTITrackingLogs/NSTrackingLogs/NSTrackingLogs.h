//
//  NSTrackingLogs.h
//  NSTrackingLogs
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import <Automator/AMBundleAction.h>

@interface NSTrackingLogs : AMBundleAction

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
