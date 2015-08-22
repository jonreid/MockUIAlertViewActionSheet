//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "UIActionSheet+QCOMock.h"

#import "NSObject+QCOMockAlertViewActionSheet.h"
#import <objc/runtime.h>

NSString *const QCOMockActionSheetShowNotification = @"QCOMockActionSheetShowNotification";


@implementation UIActionSheet (QCOMock)

+ (void)qcoMock_swizzle
{
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:)
                                                 withMethod:@selector(initQCOMockWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(addButtonWithTitle:)
                                                 withMethod:@selector(qcoMock_addButtonWithTitle:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(showInView:)
                                                 withMethod:@selector(qcoMock_showInView:)];
}

- (id)initQCOMockWithTitle:(NSString *)title
                  delegate:(id <UIActionSheetDelegate>)delegate
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
         otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.delegate = delegate;
        self.qcoMock_cancelButtonTitle = cancelButtonTitle;
        self.qcoMock_destructiveButtonTitle = destructiveButtonTitle;

        self.qcoMock_otherButtonTitles = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = va_arg(args, NSString *))
            [self.qcoMock_otherButtonTitles addObject:otherTitle];
        va_end(args);
    }
    return self;
}

- (NSUInteger)qcoMock_addButtonWithTitle:(NSString *)title
{
    [self.qcoMock_otherButtonTitles addObject:title];
    return self.qcoMock_otherButtonTitles.count;
}

- (void)qcoMock_showInView:(UIView *)view
{
    self.qcoMock_parentView = view;
    [[NSNotificationCenter defaultCenter] postNotificationName:QCOMockActionSheetShowNotification
                                                        object:self
                                                      userInfo:nil];
}

- (NSString *)qcoMock_cancelButtonTitle
{
    return objc_getAssociatedObject(self, @selector(qcoMock_cancelButtonTitle));
}

- (void)setQcoMock_cancelButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, @selector(qcoMock_cancelButtonTitle), title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)qcoMock_destructiveButtonTitle
{
    return objc_getAssociatedObject(self, @selector(qcoMock_destructiveButtonTitle));
}

- (void)setQcoMock_destructiveButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, @selector(qcoMock_destructiveButtonTitle), title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)qcoMock_otherButtonTitles
{
    return objc_getAssociatedObject(self, @selector(qcoMock_otherButtonTitles));
}

- (void)setQcoMock_otherButtonTitles:(NSMutableArray *)otherTitles
{
    objc_setAssociatedObject(self, @selector(qcoMock_otherButtonTitles), otherTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)qcoMock_parentView
{
    return objc_getAssociatedObject(self, @selector(qcoMock_parentView));
}

- (void)setQcoMock_parentView:(UIView *)parentView
{
    objc_setAssociatedObject(self, @selector(qcoMock_parentView), parentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
