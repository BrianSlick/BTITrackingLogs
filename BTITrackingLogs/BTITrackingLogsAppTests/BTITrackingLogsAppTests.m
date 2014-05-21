//
//  BTITrackingLogsAppTests.m
//  BTITrackingLogsAppTests
//
//  Created by Brian Slick on 5/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTIStringProcessor.h"

@interface BTITrackingLogsAppTests : XCTestCase

@end

@implementation BTITrackingLogsAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test 1

- (void)testThatUnsupportedInputIsNotModified
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test1input-UnsupportedInput" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"NSLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, inputString, @"Contents should not change if the input cannot be processed");
}

#pragma mark - Test 2

- (void)testThatLogsAreIndentedWithSpaces
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test2input-Spaces" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test2output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"NSLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Indents should be spaces");
}

#pragma mark - Test 3

- (void)testThatLogsAreIndentedWithTabs
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test3input-Tabs" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test3output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"NSLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Indents should be tabs");
}

#pragma mark - Test 4

- (void)testThatNSLogsAreAdded
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-AlternatePrefixes" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output-nslog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"NSLog"];
	NSString *outputString = [processor outputString];
	   
	XCTAssertEqualObjects(outputString, outputStringReference, @"NSLogs should have been added");
}

- (void)testThatBTITrackingLogsAreAdded
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-AlternatePrefixes" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output-btitrackinglog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"BTITrackingLogs should have been added");
}

- (void)testThatDLogsAreAdded
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test4input-AlternatePrefixes" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test4output-dlog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"DLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"DLogs should have been added");
}

#pragma mark - Test 5

- (void)testSimpleMethodWithoutReturns
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test5input-SimpleMethodWithoutReturns" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test5output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated");
}

#pragma mark - Test 6

- (void)testSimpleMethodWithSingleReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test6input-SimpleMethodWithSingleReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test6output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated");
}

#pragma mark - Test 7

- (void)testVoidMethodWithEarlyReturn
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test7input-VoidMethodWithEarlyReturn" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test7output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, plus an early exit log for the return");
}

#pragma mark - Test 8

- (void)testReturnInsideBlock
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test8input-ReturnInsideBlock" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test8output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Entering and leaving logs should have been generated, and a leaving log should NOT have been created for the return line inside the block.");
}

#pragma mark - Test 9

- (void)testNSLogVersionDoNotAddMoreLogsIfLogsAreAlreadyThere
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test9input-ExistingNSLog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"NSLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, inputString, @"More logs should not be created if logs are already present");
}

- (void)testBTITrackingLogVersionDoNotAddMoreLogsIfLogsAreAlreadyThere
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test9input-ExistingBTITrackingLog" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, inputString, @"More logs should not be created if logs are already present");
}

#pragma mark - Test 10

- (void)testUpgradeOldFormat
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test10input-UpgradeOldLogFormat" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test10output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
	
	XCTAssertEqualObjects(outputString, outputStringReference, @"Existing logs should be converted to the new format");
}

#pragma mark - Test 11

- (void)testEarlyReturnWithoutBraces
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test11input-EarlyReturnWithoutBraces" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test11output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
    
	XCTAssertEqualObjects(outputString, outputStringReference, @"Braces should be added if the return does not already have then");
}

- (void)testFinalLineNonTrackingLogIsIgnored
{
	NSURL *inputURL = [[NSBundle mainBundle] URLForResource:@"test12input-LastLineIsALog" withExtension:@"txt"];
	NSURL *outputURL = [[NSBundle mainBundle] URLForResource:@"test12output" withExtension:@"txt"];
	
	NSString *inputString = [[NSString alloc] initWithContentsOfURL:inputURL encoding:NSUTF8StringEncoding error:nil];
	NSString *outputStringReference = [[NSString alloc] initWithContentsOfURL:outputURL encoding:NSUTF8StringEncoding error:nil];
	
	BTIStringProcessor *processor = [[BTIStringProcessor alloc] initWithInputString:inputString usingLogPrefix:@"BTITrackingLog"];
	NSString *outputString = [processor outputString];
    
	XCTAssertEqualObjects(outputString, outputStringReference, @"Braces should be added if the return does not already have then");
}

@end
