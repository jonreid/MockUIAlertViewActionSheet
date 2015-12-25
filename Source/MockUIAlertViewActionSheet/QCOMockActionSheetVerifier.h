//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>


/*!
 * @abstract Captures mocked UIActionSheet arguments.
 * @discussion Instantiate a QCOMockActionSheetVerifier before the execution phase of the test. Then
 * invoke the code to create and present your alert. Information about the alert is then available
 * through the QCOMockActionSheetVerifier.
 */
@interface QCOMockActionSheetVerifier : NSObject

@property (nonatomic, assign) NSUInteger showCount;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, copy) NSArray *otherButtonTitles;
@property (nonatomic, assign) UIActionSheetStyle actionSheetStyle;

/*!
 * @abstract Initializes a newly allocated verifier.
 * @discussion Instantiating a QCOMockActionSheetVerifier swizzles UIActionSheet. It remains
 * swizzled until the QCOMockActionSheetVerifier is deallocated.
 */
- (id)init;

@end
