// System under test
#import "ViewController.h"

// Test support
#import "QCOMockActionSheet.h"
#import "QCOMockActionSheetVerifier.h"
#import "QCOMockAlertView.h"
#import "QCOMockAlertViewVerifier.h"
#import <XCTest/XCTest.h>


@interface ViewControllerTests_PlainXCTest : XCTestCase
@end

@implementation ViewControllerTests_PlainXCTest
{
    ViewController *sut;
}

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    sut = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    [sut view];
}

#pragma mark Alert View Tests

- (void)testShowAlertButton_ShouldBeConnected
{
    XCTAssertNotNil([sut showAlertButton]);
}

- (void)testShowAlertButtonAction
{
    NSArray *actions = [sut.showAlertButton actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside];

    XCTAssertEqual(actions.count, (NSUInteger)1);
    XCTAssertEqualObjects(actions[0], @"showAlert:");
}

- (void)testDefaultAlertViewClass
{
    XCTAssertEqualObjects(sut.alertViewClass, [UIAlertView class]);
}

- (void)testShowAlert
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];
    sut.alertViewClass = [QCOMockAlertView class];

    [sut showAlert:nil];

    XCTAssertEqual(alertVerifier.showCount, (NSUInteger)1);
    XCTAssertEqualObjects(alertVerifier.title, @"Get Driving Directions");
    XCTAssertEqualObjects(alertVerifier.message, @"Continue to the Maps app for driving directions?");
    XCTAssertEqual(alertVerifier.delegate, sut);
    NSArray *otherButtonTitles = alertVerifier.otherButtonTitles;
    XCTAssertEqualObjects(alertVerifier.cancelButtonTitle, @"Cancel");
    XCTAssertEqual([otherButtonTitles count], (NSUInteger)1);
    XCTAssertEqualObjects(otherButtonTitles[0], @"OK");
}

#pragma mark Action Sheet Tests

- (void)testShowActionSheetButton_ShouldBeConnected
{
    XCTAssertNotNil(sut.showActionSheetButton);
}

- (void)testShowActionSheetButtonAction
{
    NSArray *actions = [(sut.showActionSheetButton) actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside];

    XCTAssertEqual(actions.count, (NSUInteger)1);
    XCTAssertEqualObjects(actions[0], @"showActionSheet:");
}

- (void)testDefaultActionSheetClass
{
    XCTAssertEqualObjects(sut.actionSheetClass, [UIActionSheet class]);
}

- (void)testShowActionSheet
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqual(sheetVerifier.showCount, (NSUInteger)1);
    XCTAssertEqual(sheetVerifier.parentView, [sut view]);
    XCTAssertEqualObjects(sheetVerifier.title, @"http://qualitycoding.org");
    XCTAssertEqual(sheetVerifier.delegate, sut);
    XCTAssertEqualObjects(sheetVerifier.cancelButtonTitle, @"Cancel");
    NSArray *otherButtonTitles = sheetVerifier.otherButtonTitles;
    XCTAssertEqual([otherButtonTitles count], (NSUInteger)3);
    XCTAssertEqualObjects(otherButtonTitles[0], @"Open in Safari");
    XCTAssertEqualObjects(otherButtonTitles[1], @"Copy link");
    XCTAssertEqualObjects(otherButtonTitles[2], @"Separately added button");
}

@end
