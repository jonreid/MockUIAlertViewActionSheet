// System under test
#import "ViewController.h"

// Test support
#import "QCOMockActionSheet.h"
#import "QCOMockActionSheetVerifier.h"
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
    UIButton *button = [sut showAlertButton];

    XCTAssertNotNil(button);
}

- (void)testShowAlertButton_ShouldHaveAction
{
    NSArray *touchUpActions = [sut.showAlertButton actionsForTarget:sut
                                                    forControlEvent:UIControlEventTouchUpInside];

    XCTAssertEqual(touchUpActions.count, (NSUInteger)1);
    XCTAssertEqualObjects(touchUpActions[0], @"showAlert:");
}

- (void)testShowAlert_ShouldPresentAlert
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqual(alertVerifier.showCount, (NSUInteger)1);
}

- (void)testShowAlert_ShouldHaveTitle
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqualObjects(alertVerifier.title, @"Get Driving Directions");
}

- (void)testShowAlert_AlertShouldHaveMessage
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqualObjects(alertVerifier.message, @"Continue to the Maps app for driving directions?");
}

- (void)testShowAlert_AlertShouldHaveDelegate
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqual(alertVerifier.delegate, sut);
}

- (void)testShowAlert_AlertShouldHaveCancelButton
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqualObjects(alertVerifier.cancelButtonTitle, @"Cancel");
}

- (void)testShowAlert_AlertShouldHaveOtherButtons
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    NSArray *otherButtonTitles = alertVerifier.otherButtonTitles;
    XCTAssertEqual([otherButtonTitles count], (NSUInteger)2);
    XCTAssertEqualObjects(otherButtonTitles[0], @"OK");
    XCTAssertEqualObjects(otherButtonTitles[1], @"Separately added button");
}

#pragma mark Action Sheet Tests

- (void)testShowActionSheetButton_ShouldBeConnected
{
    UIButton *button = sut.showActionSheetButton;

    XCTAssertNotNil(button);
}

- (void)testShowActionSheetButton_ShouldHaveAction
{
    NSArray *touchUpActions = [sut.showActionSheetButton actionsForTarget:sut
                                                          forControlEvent:UIControlEventTouchUpInside];

    XCTAssertEqual(touchUpActions.count, (NSUInteger)1);
    XCTAssertEqualObjects(touchUpActions[0], @"showActionSheet:");
}

- (void)testDefaultActionSheetClass_ShouldBeUIActionSheet
{
    Class aClass = sut.actionSheetClass;
    
    XCTAssertEqualObjects(aClass, [UIActionSheet class]);
}

- (void)testShowActionSheet_ShouldPresentSheet
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqual(sheetVerifier.showCount, (NSUInteger)1);
}

- (void)testShowActionSheet_SheetShouldHaveParentView
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqual(sheetVerifier.parentView, [sut view]);
}

- (void)testShowActionSheet_SheetShouldHaveTitle
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqualObjects(sheetVerifier.title, @"http://qualitycoding.org");
}

- (void)testShowActionSheet_SheetShouldHaveDelegate
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqual(sheetVerifier.delegate, sut);
}

- (void)testShowActionSheet_SheetShouldHaveCancelButton
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqualObjects(sheetVerifier.cancelButtonTitle, @"Cancel");
}

- (void)testShowActionSheet_SheetShouldHaveOtherButtons
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    NSArray *otherButtonTitles = sheetVerifier.otherButtonTitles;
    XCTAssertEqual([otherButtonTitles count], (NSUInteger)3);
    XCTAssertEqualObjects(otherButtonTitles[0], @"Open in Safari");
    XCTAssertEqualObjects(otherButtonTitles[1], @"Copy link");
    XCTAssertEqualObjects(otherButtonTitles[2], @"Separately added button");
}

- (void)testShowActionSheet_SheetShouldHaveStyle
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [QCOMockActionSheet class];

    [sut showActionSheet:nil];

    XCTAssertEqual(sheetVerifier.actionSheetStyle, UIActionSheetStyleBlackOpaque);
}

@end
