//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>

extern NSString *const QCOMockAlertViewShowNotification;


@interface UIAlertView (QCOMock)

@property (nonatomic, copy) NSString *qcoMock_cancelButtonTitle;
@property (nonatomic, strong) NSMutableArray *qcoMock_otherButtonTitles;

+ (void)qcoMock_swizzle;

@end
