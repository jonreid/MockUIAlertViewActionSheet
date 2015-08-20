#import "ViewController.h"

@implementation ViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        // Use the real UIKit classes by default. Make sure you have tests verifying this.
        _alertViewClass = [UIAlertView class];
        _actionSheetClass = [UIActionSheet class];
    }
    return self;
}

- (IBAction)showAlert:(id)sender
{
    // Allocate self.alertViewClass instead of UIAlertView.
    UIAlertView *alertView = [(UIAlertView *)[self.alertViewClass alloc]
                              initWithTitle:@"Get Driving Directions"
                              message:@"Continue to the Maps app for driving directions?"
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
    [alertView addButtonWithTitle:@"Separately added button"];
    [alertView show];
}

- (IBAction)showActionSheet:(id)sender
{
    // Allocate self.actionSheetClass instead of UIActionSheet.
    UIActionSheet *actionSheet = [(UIActionSheet *)[self.actionSheetClass alloc]
                                  initWithTitle:@"http://qualitycoding.org"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Open in Safari", @"Copy link", nil];
    [actionSheet addButtonWithTitle:@"Separately added button"];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:[self view]];
}

@end
