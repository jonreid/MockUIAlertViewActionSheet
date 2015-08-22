#import "ViewController.h"

@implementation ViewController

- (Class)alertViewClass
{
    // Use the real UIAlertView by default. Make sure you have a test verifying this.
    if (!_alertViewClass)
        _alertViewClass = [UIAlertView class];
    return _alertViewClass;
}

- (Class)actionSheetClass
{
    // Use the real UIActionSheet by default. Make sure you have a test verifying this.
    if (!_actionSheetClass)
        _actionSheetClass = [UIActionSheet class];
    return _actionSheetClass;
}

- (IBAction)showAlert:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc]
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
