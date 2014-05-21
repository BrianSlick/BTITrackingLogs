//
//  BTITrackingLogs.m
//  BTITrackingLogs
//
//  Created by Brian Slick on 5/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "BTITrackingLogs.h"

#import "BTIStringProcessor.h"

// Private Constants

#define kPrefixMatrixSelectedRowKey         @"com.briterideas.selectedRow"
#define kCustomPrefixKey                    @"com.briterideas.customPrefix"

typedef NS_ENUM(NSInteger, BTIPrefixMatrixSelectedRow) {
    BTIPrefixMatrixSelectedRowNSLog = 0,
    BTIPrefixMatrixSelectedRowBTITrackingLog,
    BTIPrefixMatrixSelectedRowCustomPrefix,
};

@interface BTITrackingLogs ()

@property (nonatomic, weak) IBOutlet NSMatrix *prefixMatrix;
@property (nonatomic, weak) IBOutlet NSTextField *customPrefixTextField;

@end

@implementation BTITrackingLogs

- (id)runWithInput:(id)input
             error:(NSError **)error
{
    NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (![input isKindOfClass:[NSArray class]])
    {
        NSLog(@"<<< Leaving  <%p> %s >>> EARLY - Input is not an array", self, __PRETTY_FUNCTION__);
        return input;
    }
    
    NSString *prefix = nil;
    
    NSInteger selectedRow = [[[self parameters] objectForKey:kPrefixMatrixSelectedRowKey] integerValue];
    
    switch (selectedRow)
    {
        case BTIPrefixMatrixSelectedRowNSLog:
            prefix = @"NSLog";
            break;
        case BTIPrefixMatrixSelectedRowBTITrackingLog:
            prefix = @"BTITrackingLog";
            break;
        case BTIPrefixMatrixSelectedRowCustomPrefix:
        {
            prefix = [[self parameters] objectForKey:kCustomPrefixKey];
            if ([prefix length] == 0)
            {
                prefix = @"NSLog";
            }
        }
            break;
        default:
            prefix = @"NSLog";
            break;
    }
        
    NSArray *inputArray = (NSArray *)input;
    NSMutableArray *outputArray = [NSMutableArray array];
    
    for (id inputObject in inputArray)
    {
        if (![inputObject isKindOfClass:[NSString class]])
        {
            [outputArray addObject:inputObject];
            
            continue;
        }
        
        NSString *inputString = (NSString *)inputObject;
        
        BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:prefix];
        NSString *outputString = [processor outputString];
        
        if (outputString != nil)
        {
            [outputArray addObject:outputString];
        }
        else
        {
            [outputArray addObject:inputObject];
        }
    }
    
    NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return outputArray;
}

- (void)opened
{
    NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableDictionary *parameters = [self parameters];
    
    // Selected row
    if ([parameters objectForKey:kPrefixMatrixSelectedRowKey] == nil)
    {
        [parameters setObject:@(BTIPrefixMatrixSelectedRowBTITrackingLog) forKey:kPrefixMatrixSelectedRowKey];
    }
    
    [self parametersUpdated];
    
    [super opened];
    
    NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)updateParameters
{
    NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableDictionary *parameters = [self parameters];
    
    [parameters setObject:@([[self prefixMatrix] selectedRow]) forKey:kPrefixMatrixSelectedRowKey];
    
    NSString *customPrefix = [[self customPrefixTextField] stringValue];
    if ([customPrefix length] == 0)
    {
        customPrefix = @"";
    }
    
    [parameters setObject:customPrefix forKey:kCustomPrefixKey];
    
    NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)parametersUpdated
{
    NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
        
    NSMutableDictionary *parameters = [self parameters];
    
    NSInteger selectedRow = [[parameters objectForKey:kPrefixMatrixSelectedRowKey] integerValue];
    
    [[self prefixMatrix] selectCellAtRow:selectedRow column:0];
    
    if (selectedRow == BTIPrefixMatrixSelectedRowCustomPrefix)
    {
        NSString *prefix = [parameters objectForKey:kCustomPrefixKey];
        if ([prefix length] == 0)
        {
            prefix = @"";
        }
        
        [[self customPrefixTextField] setStringValue:prefix];
    }
    else
    {
        [[self customPrefixTextField] setStringValue:@""];
    }
    
    [self prefixMatrixValueChanged:[self prefixMatrix]];
    
    NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)prefixMatrixValueChanged:(NSMatrix *)matrix
{
    NSLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger selectedRow = [matrix selectedRow];
    
    [[self customPrefixTextField] setEnabled:(selectedRow == BTIPrefixMatrixSelectedRowCustomPrefix)];
    
    NSLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
