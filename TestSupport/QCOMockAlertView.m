//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMockAlertView.h"

NSString *const QCOMockAlertViewShowNotification = @"QCOMockAlertViewShowNotification";


@implementation QCOMockAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _message = [message copy];
        _delegate = delegate;
        _cancelButtonTitle = [cancelButtonTitle copy];
        
        _otherButtonTitles = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = va_arg(args, NSString *))
            [_otherButtonTitles addObject:otherTitle];
        va_end(args);
    }
    return self;
}

- (NSUInteger)addButtonWithTitle:(NSString *)title
{
    [self.otherButtonTitles addObject:title];
    return self.otherButtonTitles.count;
}

- (void)show
{
    [[NSNotificationCenter defaultCenter] postNotificationName:QCOMockAlertViewShowNotification
                                                        object:self
                                                      userInfo:nil];
}

@end
