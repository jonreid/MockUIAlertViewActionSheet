#import "ViewController.h"

@implementation ViewController

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
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
