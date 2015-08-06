//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockAlertViewVerifier.h"

#import "QCOMockAlertView.h"


@implementation QCOMockAlertViewVerifier

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertShown:)
                                                     name:JMRMockAlertViewShowNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertShown:(NSNotification *)notification
{
    QCOMockAlertView *alert = [notification object];
	++_showCount;
	self.title = alert.title;
	self.message = alert.message;
	self.delegate = alert.delegate;
	self.cancelButtonTitle = alert.cancelButtonTitle;
	self.otherButtonTitles = alert.otherButtonTitles;
}

@end
