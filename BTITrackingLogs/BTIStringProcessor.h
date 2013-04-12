//
//  BTIStringProcessor.h
//  BTITrackingLogs
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// Libraries
#import <Foundation/Foundation.h>

// Classes and Forward Declarations

// Public Constants

// Protocols

@interface BTIStringProcessor : NSObject
{
}

// Public Properties

// Public Methods
- (instancetype)initWithInputString:(NSString *)input forNSLogOutput:(BOOL)isNSLogOutput;  // "NO" for BTITrackingLog
- (NSString *)outputString;

@end
