//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockActionSheetVerifier.h"

#import "UIActionSheet+QCOMock.h"


static void swizzleMocks(void)
{
    [UIActionSheet qcoMock_swizzle];
}

@implementation QCOMockActionSheetVerifier

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(actionSheetShown:)
                                                     name:QCOMockActionSheetShowNotification
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
