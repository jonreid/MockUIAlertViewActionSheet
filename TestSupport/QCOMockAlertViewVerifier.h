//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


/**
    Captures QCOMockAlertView arguments.
 */
@interface QCOMockAlertViewVerifier : NSObject

@property (nonatomic, assign) NSUInteger showCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;

- (id)init;

@end
