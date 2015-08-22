//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockAlertViewVerifier.h"

#import "UIAlertView+QCOMock.h"


static void swizzleMocks(void)
{
    [UIAlertView qcoMock_swizzle];
}

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
        swizzleMocks();
    }
    return self;
}

- (void)dealloc
{
    swizzleMocks();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
