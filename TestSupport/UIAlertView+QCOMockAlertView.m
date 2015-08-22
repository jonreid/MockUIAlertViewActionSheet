//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "UIAlertView+QCOMockAlertView.h"

#import "NSObject+QCOMockAlertViewActionSheet.h"
#import <objc/runtime.h>

NSString *const QCOMockAlertViewShowNotification = @"QCOMockAlertViewShowNotification";

static char const * const cancelButtonTitleKey = "qcoMock_cancelButtonTitle";
static char const * const otherButtonTitlesKey = "qcoMock_otherButtonTitles";


@implementation UIAlertView (QCOMockAlertView)

+ (void)qcoMockAlertView_swizzle
{
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)
                                                 withMethod:@selector(initQCOMockWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(addButtonWithTitle:)
                                                 withMethod:@selector(qcoMockAlertView_addButtonWithTitle:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(show)
                                                 withMethod:@selector(qcoMockAlertView_show)];
}

- (id)initQCOMockWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.qcoMock_cancelButtonTitle = [cancelButtonTitle copy];

        self.qcoMock_otherButtonTitles = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = va_arg(args, NSString *))
            [self.qcoMock_otherButtonTitles addObject:otherTitle];
        va_end(args);
    }
    return self;
}

- (NSUInteger)qcoMockAlertView_addButtonWithTitle:(NSString *)title
{
    [self.qcoMock_otherButtonTitles addObject:title];
    return self.qcoMock_otherButtonTitles.count;
}

- (void)qcoMockAlertView_show
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QCOMockAlertViewShowNotification
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

- (NSMutableArray *)qcoMock_otherButtonTitles
{
    return objc_getAssociatedObject(self, otherButtonTitlesKey);
}

- (void)setQcoMock_otherButtonTitles:(NSMutableArray *)otherTitles
{
    objc_setAssociatedObject(self, otherButtonTitlesKey, otherTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
