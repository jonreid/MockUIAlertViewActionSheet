//  MockUIAlertViewActionSheet by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>


/**
    Captures mock UIActionSheet arguments.
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

- (id)init;

@end
