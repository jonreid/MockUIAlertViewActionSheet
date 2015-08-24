# MockUIAlertViewActionSheet

[![Build Status](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet.svg?branch=master)](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet)
[![Coverage Status](https://coveralls.io/repos/jonreid/MockUIAlertViewActionSheet/badge.svg?branch=master&service=github)](https://coveralls.io/github/jonreid/MockUIAlertViewActionSheet?branch=master)
[![Cocoapods Version](https://cocoapod-badges.herokuapp.com/v/MockUIAlertViewActionSheet/badge.png)](https://cocoapods.org/pods/MockUIAlertViewActionSheet)

MockUIAlertViewActionSheet lets you mock iOS alerts and action sheets for unit
tests, based on the classic (and deprecated) UIAlertView and UIActionSheet.

(For new UIAlertController-based alerts, use
[MockUIAlertController](https://github.com/jonreid/MockUIAlertController).)

No actual alerts are presented. This means:

* The workflow doesn't pause for an action to be selected
* Tests are blazing fast.


## What do I need to change in production code?

Nothing.
 

## What can I test?

1. Instantiate a `QCOMockAlertViewVerifier` before the execution phase of the test.
2. Invoke the code to create and present your alert.

Information about the alert is then available through the
[QCOMockAlertViewVerifier](https://github.com/jonreid/MockUIAlertViewActionSheet/blob/master/TestSupport/QCOMockAlertViewVerifier.h).

For example, here's a test verifying the title. `sut` is the system under test
in the test fixture.

```obj-c
- (void)testShowAlert_AlertShouldHaveTitle
{
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];

    [sut showAlert:nil];

    XCTAssertEqualObjects(alertVerifier.title, @"Title");
}
```

See the sample app for more examples. One set of examples use
[OCHamcrest assertions](https://github.com/hamcrest/OCHamcrest), but OCHamcrest
is not required.
