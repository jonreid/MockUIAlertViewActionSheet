//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "UIActionSheet+QCOMockActionSheet.h"

#import "NSObject+QCOMockAlertViewActionSheet.h"
#import <objc/runtime.h>

NSString *const QCOMockActionSheetShowNotification = @"QCOMockActionSheetShowNotification";

static char const * const cancelButtonTitleKey = "qcoMock_cancelButtonTitle";
static char const * const destructiveButtonTitleKey = "qcoMock_destructiveButtonTitle";
static char const * const otherButtonTitlesKey = "qcoMock_otherButtonTitles";
static char const * const parentViewKey = "qcoMock_parentView";


@implementation UIActionSheet (QCOMockActionSheet)

+ (void)qcoMock_swizzle
{
    [self replaceInstanceMethod:@selector(initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:)
                     withMethod:@selector(initQcoMockWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:)];
    [self replaceInstanceMethod:@selector(addButtonWithTitle:)
                     withMethod:@selector(qcoMock_addButtonWithTitle:)];
    [self replaceInstanceMethod:@selector(showInView:)
                     withMethod:@selector(qcoMock_showInView:)];
}

- (id)initQcoMockWithTitle:(NSString *)title
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
    return objc_getAssociatedObject(self, cancelButtonTitleKey);
}

- (void)setQcoMock_cancelButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, cancelButtonTitleKey, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)qcoMock_destructiveButtonTitle
{
    return objc_getAssociatedObject(self, destructiveButtonTitleKey);
}

- (void)setQcoMock_destructiveButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, destructiveButtonTitleKey, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)qcoMock_otherButtonTitles
{
    return objc_getAssociatedObject(self, otherButtonTitlesKey);
}

- (void)setQcoMock_otherButtonTitles:(NSMutableArray *)otherTitles
{
    objc_setAssociatedObject(self, otherButtonTitlesKey, otherTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)qcoMock_parentView
{
    return objc_getAssociatedObject(self, parentViewKey);
}

- (void)setQcoMock_parentView:(UIView *)parentView
{
    objc_setAssociatedObject(self, parentViewKey, parentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
