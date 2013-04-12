//
//  BTIStringProcessor.m
//  BTITrackingLogs
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTIStringProcessor.h"

#import "NSString+BTIAdditions.h"

@interface BTIStringProcessor ()

// Private Properties
@property (nonatomic, copy) NSString *originalString;
@property (nonatomic, assign, getter = isNSLogOutput) BOOL nsLogOutput;

// Private Methods

@end

@implementation BTIStringProcessor

- (instancetype)initWithInputString:(NSString *)input
					 forNSLogOutput:(BOOL)isNSLogOutput
{
	self = [super init];
	if (self)
	{
		[self setOriginalString:input];
		[self setNsLogOutput:isNSLogOutput];
	}
	return self;
}

- (NSString *)outputString
{
	NSString *inputString = [self originalString];
	
	// Make sure the selection begins and ends with { }
	if ( (![inputString hasPrefix:@"{"]) || (![inputString hasSuffix:@"}"]) )
	{
		NSLog(@"<<< Leaving  <%p> %s >>> EARLY - Selection is not braces", self, __PRETTY_FUNCTION__);
		return inputString;
	}
	
	NSString *tab = @"\t";
	NSString *standardLogPrefix = @"NSLog";
	NSString *customLogPrefix = @"BTITrackingLog";
	
	BOOL isCustomLogVersion = ![self isNSLogOutput];
	
	NSString *activeModernPrefix = (isCustomLogVersion) ? customLogPrefix : standardLogPrefix;
	
	NSString *legacyEntryFormat = @">>> Entering %s <<<";
	NSString *modernEntryFormat = @">>> Entering <%p> %s <<<";
	
	NSString *legacyExitFormat = @"<<< Leaving %s >>>";
	NSString *modernExitFormat = @"<<< Leaving  <%p> %s >>>";
	
	NSString *legacyFormatTokens = @"\", __PRETTY_FUNCTION__);";
	NSString *modernFormatTokens = @"\", self, __PRETTY_FUNCTION__);";
	
	// Legacy formats
	// NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	// NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
	
	// (@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
	NSString *modernEntryStringStub = [NSString stringWithFormat:@"(@\"%@%@", modernEntryFormat, modernFormatTokens];
	NSString *standardEntryString = [standardLogPrefix stringByAppendingString:modernEntryStringStub];
	NSString *customEntryString = [customLogPrefix stringByAppendingString:modernEntryStringStub];
	NSString *modernEntryString = (isCustomLogVersion) ? customEntryString : standardEntryString;
	
	// (@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	NSString *modernExitStringStub = [NSString stringWithFormat:@"(@\"%@%@", modernExitFormat, modernFormatTokens];
	NSString *standardExitString = [standardLogPrefix stringByAppendingString:modernExitStringStub];
	NSString *customExitString = [customLogPrefix stringByAppendingString:modernExitStringStub];
	NSString *modernExitString = (isCustomLogVersion) ? customExitString : standardExitString;
	
	// (@"<<< Leaving  <%p> %s >>> EARLY - <reason not specified>", self, __PRETTY_FUNCTION__);
	NSString *modernEarlyExitStringStub = [NSString stringWithFormat:@"(@\"%@ EARLY - <reason not specified>%@", modernExitFormat, modernFormatTokens];
	NSString *standardEarlyExitString = [standardLogPrefix stringByAppendingString:modernEarlyExitStringStub];
	NSString *customEarlyExitString = [customLogPrefix stringByAppendingString:modernEarlyExitStringStub];
	NSString *modernEarlyExitString = (isCustomLogVersion) ? customEarlyExitString : standardEarlyExitString;;
	
	// Upgrade/Replace older logs
	
	NSMutableString *upgradeString = [NSMutableString stringWithString:inputString];
	
	[upgradeString replaceOccurrencesOfString:legacyEntryFormat withString:modernEntryFormat options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
	[upgradeString replaceOccurrencesOfString:legacyExitFormat withString:modernExitFormat options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
	[upgradeString replaceOccurrencesOfString:legacyFormatTokens withString:modernFormatTokens options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
	
	if (isCustomLogVersion)
	{
		[upgradeString replaceOccurrencesOfString:standardEntryString withString:customEntryString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
		[upgradeString replaceOccurrencesOfString:standardExitString withString:customExitString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
		
		NSString *oldEarlyExitString = [NSString stringWithFormat:@"%@(@\"%@", standardLogPrefix, modernExitFormat];
		NSString *newEarlyExitString = [NSString stringWithFormat:@"%@(@\"%@", customLogPrefix, modernExitFormat];
		
		[upgradeString replaceOccurrencesOfString:oldEarlyExitString withString:newEarlyExitString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
	}
	else
	{
		[upgradeString replaceOccurrencesOfString:customEntryString withString:standardEntryString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
		[upgradeString replaceOccurrencesOfString:customExitString withString:standardExitString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
		
		NSString *oldEarlyExitString = [NSString stringWithFormat:@"%@(@\"%@", customLogPrefix, modernExitFormat];
		NSString *newEarlyExitString = [NSString stringWithFormat:@"%@(@\"%@", standardLogPrefix, modernExitFormat];
		
		[upgradeString replaceOccurrencesOfString:oldEarlyExitString withString:newEarlyExitString options:NSLiteralSearch range:NSMakeRange(0, [upgradeString length])];
	}
	
	// Loop over each line to determine where to insert tracking logs
	
	NSArray *originalLines = [upgradeString componentsSeparatedByString:@"\n"];
	__block NSMutableArray *newLines = [NSMutableArray array];
	
	__block NSInteger scopeDepth = 0;
	__block NSMutableArray *blockDepth = [NSMutableArray array];
	
	[originalLines enumerateObjectsUsingBlock:^(NSString *line, NSUInteger index, BOOL *stop) {
				
		// Capture and trim leading whitespace
		NSString *trimmedLine = [line stringByRemovingLeadingWhitespaceBTI];
		NSString *whitespace = @"";
		
		if ([line length] != [trimmedLine length])
		{
			whitespace = [line substringToIndex:[line length] - [trimmedLine length]];
		}
		
		// Determine if scope depth (indenting) needs to change)
		
		BOOL isOpeningBrace = ([trimmedLine hasPrefix:@"{"] || [trimmedLine hasSuffix:@"{"]);
		BOOL isClosingBrace = ([trimmedLine hasPrefix:@"}"]);
		BOOL isStartOfBlock = ([trimmedLine rangeOfString:@"^"].location != NSNotFound);
		BOOL isInsideBlock = ([blockDepth count] > 0);
				
		if (isOpeningBrace)
		{
			scopeDepth++;
			if ( (isStartOfBlock) || (isInsideBlock) )
			{
				[blockDepth addObject:@YES];
			}
		}
		else if (isClosingBrace)
		{
			scopeDepth--;
			if (isInsideBlock)
			{
				[blockDepth removeLastObject];
			}
		}
		
		if (isOpeningBrace)
		{
			// Only care about opening brace
			
			[newLines addObject:line];
			
			if (scopeDepth > 1)
			{
				return;
			}
			
			// Ignore blocks
			if (isStartOfBlock)
			{
				return;
			}
			
			// Determine if log has already been placed
			NSString *nextLine = [originalLines objectAtIndex:index + 1];
			NSString *trimmedNextLine = [nextLine stringByRemovingLeadingWhitespaceBTI];
			
			if ([trimmedNextLine hasPrefix:modernEntryString])		// Not using isEqualToString in case there is trailing space
			{
				return;
			}
			else
			{
				NSString *newWhiteSpace = @"";
				for (int scopeCounter = 0; scopeCounter < scopeDepth; scopeCounter++)
				{
					newWhiteSpace = [newWhiteSpace stringByAppendingString:tab];
				}
				
				[newLines addObject:[newWhiteSpace stringByAppendingString:modernEntryString]];
				[newLines addObject:@""];
				return;
			}
		}
		
		if ([trimmedLine hasPrefix:@"return"])
		{
			// Determine if this is inside a block
			if (isInsideBlock)
			{
				[newLines addObject:line];
				return;
			}
			
			// Determine if previous line already has a log
			
			NSString *previousLine = [newLines lastObject];
			NSString *trimmedPreviousLine = [previousLine stringByRemovingLeadingWhitespaceBTI];
			
			if ([trimmedPreviousLine hasPrefix:activeModernPrefix])
			{
				[newLines addObject:line];
				return;
			}
			
			NSString *newWhiteSpace = @"";
			for (int scopeCounter = 0; scopeCounter < scopeDepth; scopeCounter++)
			{
				newWhiteSpace = [newWhiteSpace stringByAppendingString:tab];
			}
			
			if (scopeDepth <= 1)		// Last line
			{
				[newLines addObject:@""];
				[newLines addObject:[newWhiteSpace stringByAppendingString:modernExitString]];
				[newLines addObject:line];
				return;
			}
			else
			{
				[newLines addObject:[newWhiteSpace stringByAppendingString:modernEarlyExitString]];
				[newLines addObject:line];
				return;
			}
		}
		
		if (isClosingBrace && !isInsideBlock && (scopeDepth == 0) )
		{
			// Determine if previous line already has a log, or is a return line
			
			NSString *previousLine = [newLines lastObject];
			NSString *trimmedPreviousLine = [previousLine stringByRemovingLeadingWhitespaceBTI];
			
			if ( ([trimmedPreviousLine hasPrefix:activeModernPrefix]) || ([trimmedPreviousLine hasPrefix:@"return"]) )
			{
				[newLines addObject:line];
				return;
			}
			else
			{
				[newLines addObject:@""];
				[newLines addObject:[tab stringByAppendingString:modernExitString]];
				[newLines addObject:line];
				return;
			}
		}
		
		[newLines addObject:line];
		
	}];
	
	NSString *returnString = [newLines componentsJoinedByString:@"\n"];
	
	return returnString;
}

@end
