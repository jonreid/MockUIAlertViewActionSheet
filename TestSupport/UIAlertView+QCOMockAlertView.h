//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>

extern NSString *const QCOMockAlertViewShowNotification;


@interface UIAlertView (QCOMockAlertView)

@property (nonatomic, copy) NSString *qcoMockAlertView_cancelButtonTitle;
@property (nonatomic, strong) NSMutableArray *qcoMockAlertView_otherButtonTitles;

+ (void)qcoMockAlertView_swizzle;

@end
