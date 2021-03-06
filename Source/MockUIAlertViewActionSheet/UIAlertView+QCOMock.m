//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "UIAlertView+QCOMock.h"

#import "NSObject+QCOMockAlertViewActionSheet.h"
#import <objc/runtime.h>

NSString *const QCOMockAlertViewShowNotification = @"QCOMockAlertViewShowNotification";


@implementation UIAlertView (QCOMock)

+ (void)qcoMock_swizzle
{
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)
                                                 withMethod:@selector(initQCOMockWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(addButtonWithTitle:)
                                                 withMethod:@selector(qcoMockAlertView_addButtonWithTitle:)];
    [self qcoMockAlertViewActionSheet_replaceInstanceMethod:@selector(show)
                                                 withMethod:@selector(qcoMockAlertView_show)];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

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

#pragma clang diagnostic pop


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
    return objc_getAssociatedObject(self, @selector(qcoMock_cancelButtonTitle));
}

- (void)setQcoMock_cancelButtonTitle:(NSString *)title
{
    objc_setAssociatedObject(self, @selector(qcoMock_cancelButtonTitle), title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)qcoMock_otherButtonTitles
{
    return objc_getAssociatedObject(self, @selector(qcoMock_otherButtonTitles));
}

- (void)setQcoMock_otherButtonTitles:(NSMutableArray *)otherTitles
{
    objc_setAssociatedObject(self, @selector(qcoMock_otherButtonTitles), otherTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
