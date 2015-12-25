//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


/*!
 * @abstract Captures mocked UIAlertView arguments.
 * @discussion Instantiate a QCOMockAlertViewVerifier before the execution phase of the test. Then
 * invoke the code to create and present your alert. Information about the alert is then available
 * through the QCOMockAlertViewVerifier.
 */
@interface QCOMockAlertViewVerifier : NSObject

@property (nonatomic, assign) NSUInteger showCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;

/*!
 * @abstract Initializes a newly allocated verifier.
 * @discussion Instantiating a QCOMockAlertViewVerifier swizzles UIAlertView. It remains swizzled
 * until the QCOMockAlertViewVerifier is deallocated.
 */
- (instancetype)init;

@end
