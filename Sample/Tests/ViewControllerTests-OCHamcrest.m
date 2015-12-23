// System under test
#import "ViewController.h"

// Test support
#import <MockUIAlertViewActionSheet/QCOMockActionSheetVerifier.h>
#import <MockUIAlertViewActionSheet/QCOMockAlertViewVerifier.h>
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>


@interface ViewControllerTests_OCHamcrest : XCTestCase
@end

@implementation ViewControllerTests_OCHamcrest
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
    UIButton *button = sut.showAlertButton;
    
    assertThat(button, is(notNilValue()));
}

- (void)testShowAlertButton_ShouldHaveAction
{
    NSArray *touchUpActions = [sut.showAlertButton actionsForTarget:sut
                                                    forControlEvent:UIControlEventTouchUpInside];

    assertThat(touchUpActions, contains(@"showAlert:", nil));
}

- (void)testShowAlert_ShouldPresentAlert
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(@(alertVerifier.showCount), is(equalTo(@1)));
}

- (void)testShowAlert_AlertShouldHaveTitle
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(alertVerifier.title, is(@"Get Driving Directions"));
}

- (void)testShowAlert_AlertShouldHaveMessage
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(alertVerifier.message, is(@"Continue to the Maps app for driving directions?"));
}

- (void)testShowAlert_AlertShouldHaveDelegate
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(alertVerifier.delegate, is(sameInstance(sut)));
}

- (void)testShowAlert_AlertShouldHaveCancelButton
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(alertVerifier.cancelButtonTitle, is(@"Cancel"));
}

- (void)testShowAlert_AlertShouldHaveOtherButtons
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    assertThat(alertVerifier.otherButtonTitles, contains(@"OK", @"Separately added button", nil));
}

#pragma mark Action Sheet Tests

- (void)testShowActionSheetButton_ShouldBeConnected
{
    UIButton *button = sut.showActionSheetButton;
    
    assertThat(button, is(notNilValue()));
}

- (void)testShowActionSheetButton_ShouldHaveAction
{
    NSArray *touchUpActions = [sut.showActionSheetButton actionsForTarget:sut
                                                          forControlEvent:UIControlEventTouchUpInside];
    
    assertThat(touchUpActions, contains(@"showActionSheet:", nil));
}

- (void)testShowActionSheet_ShouldPresentActionSheet
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(@(sheetVerifier.showCount), is(equalTo(@1)));
}

- (void)testShowActionSheet_SheetShouldHaveParentView
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(sheetVerifier.parentView, is(sameInstance([sut view])));
}

- (void)testShowActionSheet_SheetShouldHaveTitle
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(sheetVerifier.title, is(@"http://qualitycoding.org"));;
}

- (void)testShowActionSheet_SheetShouldHaveDelegate
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(sheetVerifier.delegate, is(sameInstance(sut)));
}

- (void)testShowActionSheet_SheetShouldHaveCancelButton
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(sheetVerifier.cancelButtonTitle, is(@"Cancel"));
}

- (void)testShowActionSheet_SheetShouldHaveOtherButtons
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(sheetVerifier.otherButtonTitles,
            contains(@"Open in Safari", @"Copy link", @"Separately added button", nil));
}

- (void)testShowActionSheet_SheetShouldHaveStyle
{
    QCOMockActionSheetVerifier *sheetVerifier = [[QCOMockActionSheetVerifier alloc] init];

    [sut showActionSheet:nil];

    assertThat(@(sheetVerifier.actionSheetStyle), is(@(UIActionSheetStyleBlackOpaque)));
}

@end

