//
//  JPFThirdViewController.m
//  TroFlow
//
//  Created by John Paul Francis on 5/6/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "JPFThirdViewController.h"

@interface JPFThirdViewController ()
@property (weak, nonatomic) IBOutlet UIView *externalDiv;
@property (weak, nonatomic) IBOutlet UIView *loggedInContainer;
- (IBAction)logInButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *becomePromoButton;
- (IBAction)showEmail:(id)sender;
- (IBAction)usernameReturn:(id)sender;
- (IBAction)passwordReturn:(id)sender;
- (IBAction)usernameKeyReturn:(id)sender;
    
@end

@implementation JPFThirdViewController
@synthesize loggedInContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self.externalDiv setBackgroundColor:[UIColor colorWithRed:0.188 green:0 blue:0 alpha:1] ];
    [self.externalDiv setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
    [self.loggedInContainer setHidden:YES];
    [self.becomePromoButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logInButton:(id)sender {
    if([self.usernameTextField.text isEqualToString:@"JP"] && [self.passwordTextField.text isEqualToString:@"burr"]){
        [self.loggedInContainer setHidden:NO];
        [self.becomePromoButton setHidden:YES];
    }
    else{
        [self.becomePromoButton setHidden:NO];
        [self.passwordTextField resignFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"You are not currently able to promote events. Click the button to apply." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Promoter Request Email";
    // Email Content
    NSString *messageBody = @"I would like to become a promoter. You can reach me at the email _______, or the phone number ________.";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"john.francis@usc.edu"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (IBAction)usernameReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)passwordReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)usernameKeyReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
