# MockUIAlertViewActionSheet

[![Build Status](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet.svg?branch=master)](https://travis-ci.org/jonreid/MockUIAlertViewActionSheet)
[![Coverage Status](https://coveralls.io/repos/jonreid/MockUIAlertViewActionSheet/badge.svg?branch=master&service=github)](https://coveralls.io/github/jonreid/MockUIAlertViewActionSheet?branch=master)
[![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/MockUIAlertViewActionSheet/badge.png)](https://cocoapods.org/pods/MockUIAlertViewActionSheet)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

MockUIAlertViewActionSheet lets you mock iOS alerts and action sheets for unit
tests, based on the classic (and deprecated) UIAlertView and UIActionSheet.

(For new UIAlertController-based alerts, use
[MockUIAlertController](https://github.com/jonreid/MockUIAlertController).)

No actual alerts are presented. This means:

* The workflow doesn't pause for an action to be selected
* Tests are blazing fast.

## Adding it to your project

### CocoaPods

Add the following to your Podfile, changing "MyTests" to the name of your test target:

```ruby
target :MyTests, :exclusive => true do
  pod 'MockUIAlertViewActionSheet', '~> 1.0'
end
```

### Carthage

Add the following to your Cartfile:

```
github "jonreid/MockUIAlertViewActionSheet" ~> 1.0
```

### Build It Yourself

Make sure to take everything from Source/MockUIAlertViewActionSheet.


## Writing Tests
 
### What do I need to change in production code?

Nothing.

### How do I test an alert view?

1. `#import <MockUIAlertViewActionSheet/QCOMockAlertViewVerifier.h>`
2. Instantiate a `QCOMockAlertViewVerifier` before the execution phase of the test.
3. Invoke the code to create and present your alert.

Information about the alert is then available through the
[QCOMockAlertViewVerifier](https://github.com/jonreid/MockUIAlertViewActionSheet/blob/master/Source/MockUIAlertViewActionSheet/QCOMockAlertViewVerifier.h).

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

### How do I test an action sheet?

1. `#import <MockUIAlertViewActionSheet/QCOMockActionSheetVerifier.h>`
2. Instantiate a `QCOMockActionSheetVerifier` before the execution phase of the test.
3. Invoke the code to create and present your action sheet.

Information about the action sheet is then available through the
[QCOMockActionSheetVerifier](https://github.com/jonreid/MockUIAlertViewActionSheet/blob/master/Source/MockUIAlertViewActionSheet/QCOMockActionSheetVerifier.h).

### Can I see some examples?

See the sample app. Run it to see what it does, then read the ViewController tests.
