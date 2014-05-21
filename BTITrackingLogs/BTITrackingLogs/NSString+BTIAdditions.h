//
//  NSString+BTIAdditions.h
//  BTITrackingLogs
//
//  Created by Brian Slick on 5/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BTIAdditions)

- (NSString *)stringByRemovingLeadingWhitespaceBTI;
- (NSString *)indentationTokenBTI;

@end
