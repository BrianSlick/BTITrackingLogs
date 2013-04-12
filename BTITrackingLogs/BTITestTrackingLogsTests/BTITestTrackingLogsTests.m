//
//  BTITestTrackingLogsTests.m
//  BTITestTrackingLogsTests
//
//  Created by Brian Slick on 4/11/13.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTITestTrackingLogsTests.h"

#import "BTIStringProcessor.h"

@implementation BTITestTrackingLogsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - Test 1

- (void)testNSLogVersionOutputIsNotModifiedIfSelectionDoesNotStartAndEndWithBraces
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test1input-UnsupportedInput" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, inputString, @"Contents should not change if the input cannot be processed");
}

- (void)testBTILogVersionOutputIsNotModifiedIfSelectionDoesNotStartAndEndWithBraces
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test1input-InvalidInput" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, inputString, @"Contents should not change if the input cannot be processed");
}

#pragma mark - Test 2

- (void)testNSLogVersionSimpleMethodWithoutReturns
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test2input-SimpleMethodWithoutReturns" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test2output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated");
}

- (void)testBTILogVersionSimpleMethodWithoutReturns
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test2input-SimpleMethodWithoutReturns" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test2output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated");
}

#pragma mark - Test 3

- (void)testNSLogVersionSimpleMethodWithSingleReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test3input-SimpleMethodWithSingleReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test3output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, with leaving log appearing before return line");
}

- (void)testBTILogVersionSimpleMethodWithSingleReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test3input-SimpleMethodWithSingleReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test3output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, with leaving log appearing before return line");
}

#pragma mark - Test 4

- (void)testNSLogVersionVoidMethodWithEarlyReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-VoidMethodWithEarlyReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, plus an early exit log for the return");
}

- (void)testBTILogVersionVoidMethodWithEarlyReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-VoidMethodWithEarlyReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, plus an early exit log for the return");
}

#pragma mark - Test 5

- (void)testNSLogVersionReturnInsideBlock
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test5input-ReturnInsideBlock" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test5output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, and a leaving log should NOT have been created for the return line inside the block.");
}

- (void)testBTILogVersionReturnInsideBlock
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test5input-ReturnInsideBlock" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test5output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, and a leaving log should NOT have been created for the return line inside the block.");
}

#pragma mark - Test 6

- (void)testNSLogVersionDoNotAddMoreLogsIfLogsAreAlreadyThere
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test6input-ExistingNSLog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, inputString, @"More logs should not be created if logs are already present");
}

- (void)testBTILogVersionDoNotAddMoreLogsIfLogsAreAlreadyThere
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test6input-ExistingBTILog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, inputString, @"More logs should not be created if logs are already present");
}

#pragma mark - Test 7

- (void)testNSLogVersionUpgradeOldFormat
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7input-UpgradeOldLogFormat" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Existing logs should be converted to the new format");
}

- (void)testBTILogVersionUpgradeOldFormat
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7input-UpgradeOldLogFormat" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Existing logs should be converted to the new format");
}

- (void)testNSLogVersionAlternateVersionMigration
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7output-btilog" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:YES];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Existing logs should be converted to the new format");
}

- (void)testBTILogVersionAlternateVersionMigration
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7output-nslog" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output-btilog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString forNSLogOutput:NO];
	NSString *outputString = [processor outputString];
	
	STAssertEqualObjects(outputString, outputStringReference, @"Existing logs should be converted to the new format");
}

@end
