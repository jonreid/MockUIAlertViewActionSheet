# MockUIAlertViewActionSheet

[![Build Status](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet.svg?branch=master)](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet)
[![Coverage Status](https://coveralls.io/repos/jonreid/MockUIAlertViewActionSheet/badge.svg?branch=master&service=github)](https://coveralls.io/github/jonreid/MockUIAlertViewActionSheet?branch=master)

MockUIAlertViewActionSheet lets you mock iOS alerts and action sheets for unit
tests, based on the classic (and deprecated) UIAlertView and UIActionSheet.

(For new UIAlertController-based alerts, use
[MockUIAlertController](https://github.com/jonreid/MockUIAlertController).)

No actual alerts are presented. This means:

* The workflow doesn't pause for an action to be selected
* Tests are blazing fast.


## What do I need to change in production code?

To support redirection between UIAlertView and the mock, we need an extra 
layer of indirection. I use property injection with a lazy getter that defaults
to the real UIAlertView:

```obj-c
@property (nonatomic, strong) Class alertViewClass;
```

```obj-c
- (Class)alertViewClass
{
    if (!_alertViewClass) {
        _alertViewClass = [UIAlertView class];
    }
    return _alertViewClass;
}
```

Then modify any calls to UIAlertView that you want to make unit-testable.
Replace `UIAlertView` with `self.alertViewClass`:

```obj-c
UIAlertView *alertView = [(UIAlertView *)[self.alertViewClass alloc]
                          initWithTitle:@"Get Driving Directions"
                          message:@"Continue to the Maps app for driving directions?"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
[alertView show];
```
 

## What can I test?

For starters, make sure you have a test verifying the default value of
`alertViewClass`.

In other tests:

1. Instantiate a `QCOMockAlertViewVerifier` before the execution phase of the test.
2. Inject `QCOMockAlertView` as the `alertViewClass`.
3. Invoke the code to create and present your alert.

Information about the alert is then available through the
[QCOMockAlertViewVerifier](https://github.com/jonreid/MockUIAlertViewActionSheet/blob/master/TestSupport/QCOMockAlertViewVerifier.h).

For example, here's a test verifying the title. `sut` is the system under test
in the test fixture.

```obj-c
- (void)testShowAlert_AlertShouldHaveTitle {
    QCOMockAlertViewVerifier *alertVerifier = [[QCOMockAlertViewVerifier alloc] init];
    sut.alertViewClass = [QCOMockAlertView class];

    [sut showAlert:nil];

    XCTAssertEqualObjects(alertVerifier.title, @"Title");
}
```

See the sample app for more examples. One set of examples use
[OCHamcrest assertions](https://github.com/hamcrest/OCHamcrest), but OCHamcrest
is not required.
