//
//  NSString+BTIAdditions.m
//  BTITrackingLogs
//
//  Created by Brian Slick on 5/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "NSString+BTIAdditions.h"

@implementation NSString (BTIAdditions)

- (NSString *)stringByRemovingLeadingWhitespaceBTI
{
	NSRange range = [self rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
	
    NSString *cleanString = [self stringByReplacingCharactersInRange:range withString:@""];
    
	return cleanString;
}

- (NSString *)indentationTokenBTI
{
    NSArray *lines = [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSUInteger numberOfSpaceIndents = 0;
    NSUInteger numberOfTabIndents = 0;
    
    for (NSString *line in lines)
    {
        NSRange leadingWhitespaceRange = [line rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
        
        if (leadingWhitespaceRange.length == 0)
        {
            continue;
        }
        
        NSString *whitespace = [line substringWithRange:leadingWhitespaceRange];
        
        // Not going to care about possible situations where the whitespace has spaces and tabs.
        // If it has any spaces, it counts towards spaces. If not, it counts towards tabs.
        
        if ([whitespace rangeOfString:@" " options:NSLiteralSearch].location == NSNotFound)
        {
            numberOfTabIndents++;
        }
        else
        {
            numberOfSpaceIndents++;
        }
    }
    
    NSString *token = @"    ";      // Default to 4 spaces
    if (numberOfSpaceIndents < numberOfTabIndents)      // In the event of a tie, use spaces
    {
        token = @"\t";
    }
    
    return token;
}

@end
