//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockAlertViewVerifier.h"

#import "UIAlertView+QCOMockAlertView.h"


@implementation QCOMockAlertViewVerifier

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertShown:)
                                                     name:QCOMockAlertViewShowNotification
                                                   object:nil];
        [self swizzleMockAlertView];
    }
    return self;
}

- (void)dealloc
{
    [self swizzleMockAlertView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)swizzleMockAlertView
{
    [UIAlertView qcoMockAlertView_swizzle];
}

- (void)alertShown:(NSNotification *)notification
{
    UIAlertView *alert = [notification object];
    self.showCount += 1;
	self.title = alert.title;
	self.message = alert.message;
	self.delegate = alert.delegate;
	self.cancelButtonTitle = alert.qcoMock_cancelButtonTitle;
	self.otherButtonTitles = alert.qcoMock_otherButtonTitles;
}

@end
