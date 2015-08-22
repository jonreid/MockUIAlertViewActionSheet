//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>

extern NSString *const QCOMockActionSheetShowNotification;


@interface UIActionSheet (QCOMockActionSheet)

@property (nonatomic, copy) NSString *qcoMock_cancelButtonTitle;
@property (nonatomic, copy) NSString *qcoMock_destructiveButtonTitle;
@property (nonatomic, strong) NSMutableArray *qcoMock_otherButtonTitles;
@property (nonatomic, strong) UIView *qcoMock_parentView;

+ (void)qcoMock_swizzle;

@end
