//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockAlertViewVerifier.h"

#import "UIAlertView+QCOMock.h"


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
        [self swizzleMocks];
    }
    return self;
}

- (void)dealloc
{
    [self swizzleMocks];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)swizzleMocks
{
    [UIAlertView qcoMock_swizzle];
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
