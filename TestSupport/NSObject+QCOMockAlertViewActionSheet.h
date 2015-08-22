//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface NSObject (QCOMockAlertViewActionSheet)

+ (void)replaceInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector;

@end
