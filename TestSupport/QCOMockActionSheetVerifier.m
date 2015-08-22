//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockActionSheetVerifier.h"

#import "UIActionSheet+QCOMock.h"


@implementation QCOMockActionSheetVerifier

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(actionSheetShown:)
                                                     name:QCOMockActionSheetShowNotification
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
    [UIActionSheet qcoMock_swizzle];
}

- (void)actionSheetShown:(NSNotification *)notification
{
    UIActionSheet *alert = [notification object];
    self.showCount += 1;
	self.parentView = alert.qcoMock_parentView;
	self.title = alert.title;
	self.delegate = alert.delegate;
	self.cancelButtonTitle = alert.qcoMock_cancelButtonTitle;
	self.destructiveButtonTitle = alert.qcoMock_destructiveButtonTitle;
    self.otherButtonTitles = alert.qcoMock_otherButtonTitles;
    self.actionSheetStyle = alert.actionSheetStyle;
}

@end
