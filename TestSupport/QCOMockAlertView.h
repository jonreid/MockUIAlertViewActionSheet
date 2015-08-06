//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>

extern NSString *const QCOMockAlertViewShowNotification;


/**
    Inject this class in place of the UIAlertView class.
    Instantiate a QCOMockAlertViewVerifier before the execution phase of your test.
 */
@interface QCOMockAlertView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, weak) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSMutableArray *otherButtonTitles;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (NSInteger)addButtonWithTitle:(NSString *)title;    // returns index of button. 0 based.
- (void)show;

@end
