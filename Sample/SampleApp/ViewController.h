#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Class alertViewClass;
@property (nonatomic, strong) Class actionSheetClass;
@property (nonatomic, strong) IBOutlet UIButton *showAlertButton;
@property (nonatomic, strong) IBOutlet UIButton *showActionSheetButton;

- (IBAction)showAlert:(id)sender;
- (IBAction)showActionSheet:(id)sender;

@end
