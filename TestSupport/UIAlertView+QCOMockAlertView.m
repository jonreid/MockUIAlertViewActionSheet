//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "UIAlertView+QCOMockAlertView.h"

#import "NSObject+QCOMockAlertViewActionSheet.h"
#import <objc/runtime.h>

NSString *const QCOMockAlertViewShowNotification = @"QCOMockAlertViewShowNotification";

static char const * const cancelButtonTitleKey = "qcoMockAlertView_cancelButtonTitle";
static char const * const otherButtonTitlesKey = "qcoMockAlertView_otherButtonTitles";


@implementation UIAlertView (QCOMockAlertView)

+ (void)qcoMockAlertView_swizzle
{
    [self replaceInstanceMethod:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)
                     withMethod:@selector(initQCOMockWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)];
    [self replaceInstanceMethod:@selector(addButtonWithTitle:)
                     withMethod:@selector(qcoMockAlertView_addButtonWithTitle:)];
    [self replaceInstanceMethod:@selector(show)
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
        self.qcoMockAlertView_cancelButtonTitle = [cancelButtonTitle copy];

        self.qcoMockAlertView_otherButtonTitles = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = va_arg(args, NSString *))
            [self.qcoMockAlertView_otherButtonTitles addObject:otherTitle];
        va_end(args);
    }
    return self;
}

- (NSUInteger)qcoMockAlertView_addButtonWithTitle:(NSString *)title
{
    [self.qcoMockAlertView_otherButtonTitles addObject:title];
    return self.qcoMockAlertView_otherButtonTitles.count;
}

- (void)qcoMockAlertView_show
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QCOMockAlertViewShowNotification
                                                        object:self
                                                      userInfo:nil];
}

- (NSString *)qcoMockAlertView_cancelButtonTitle
{
    return objc_getAssociatedObject(self, cancelButtonTitleKey);
}

- (void)setQcoMockAlertView_cancelButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, cancelButtonTitleKey, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)qcoMockAlertView_otherButtonTitles
{
    return objc_getAssociatedObject(self, otherButtonTitlesKey);
}

- (void)setQcoMockAlertView_otherButtonTitles:(NSMutableArray *)otherTitles
{
    objc_setAssociatedObject(self, otherButtonTitlesKey, otherTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
