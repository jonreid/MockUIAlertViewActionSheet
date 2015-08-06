// System under test
#import "ViewController.h"

// Test support
#import "JMRMockActionSheet.h"
#import "JMRMockActionSheetVerifier.h"
#import "JMRMockAlertView.h"
#import "JMRMockAlertViewVerifier.h"
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
    assertThat(sut.showAlertButton, is(notNilValue()));
}

- (void)testShowAlertButtonAction
{
    assertThat([sut.showAlertButton actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside],
               contains(@"showAlert:", nil));
}

- (void)testDefaultAlertViewClass
{
    assertThat(sut.alertViewClass, is([UIAlertView class]));
}

- (void)testShowAlert
{
    JMRMockAlertViewVerifier *alertVerifier = [[JMRMockAlertViewVerifier alloc] init];
    sut.alertViewClass = [JMRMockAlertView class];

    [sut showAlert:nil];

    assertThat(@(alertVerifier.showCount), is(equalTo(@1)));
    assertThat(alertVerifier.title, is(@"Get Driving Directions"));
    assertThat(alertVerifier.message, is(@"Continue to the Maps app for driving directions?"));
    assertThat(alertVerifier.delegate, is(sameInstance(sut)));
    assertThat(alertVerifier.cancelButtonTitle, is(@"Cancel"));
    assertThat(alertVerifier.otherButtonTitles, contains(@"OK", nil));
}

#pragma mark Action Sheet Tests

- (void)testShowActionSheetButton_ShouldBeConnected
{
    assertThat(sut.showActionSheetButton, is(notNilValue()));
}

- (void)testShowActionSheetButtonAction
{
    assertThat([sut.showActionSheetButton actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside],
               contains(@"showActionSheet:", nil));
}

- (void)testDefaultActionSheetClass
{
    assertThat(sut.actionSheetClass, is([UIActionSheet class]));
}

- (void)testShowActionSheet
{
    JMRMockActionSheetVerifier *sheetVerifier = [[JMRMockActionSheetVerifier alloc] init];
    sut.actionSheetClass = [JMRMockActionSheet class];

    [sut showActionSheet:nil];

    assertThat(@(sheetVerifier.showCount), is(equalTo(@1)));
    assertThat(sheetVerifier.parentView, is(sameInstance([sut view])));
    assertThat(sheetVerifier.title, is(@"http://qualitycoding.org"));;
    assertThat(sheetVerifier.delegate, is(sameInstance(sut)));
    assertThat(sheetVerifier.cancelButtonTitle, is(@"Cancel"));
    assertThat(sheetVerifier.otherButtonTitles,
               contains(@"Open in Safari", @"Copy link", @"Separately added button", nil));
}

@end

