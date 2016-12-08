//
//  JPFPromoteScrollViewController.m
//  TroFlow
//
//  Created by John Paul Francis on 5/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "JPFPromoteScrollViewController.h"
#import "JPFThirdViewController.h"
#import <Parse/Parse.h>

@interface JPFPromoteScrollViewController ()
- (IBAction)submitButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *eventDescription;
@property (weak, nonatomic) IBOutlet UITextField *eventName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySelector;
- (IBAction)descriptionEndOnExit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)eventReturn:(id)sender;
- (IBAction)descriptionReturn:(id)sender;
@end

@implementation JPFPromoteScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//[scroller setScrollEnabled:YES];
//[scroller setContentSize:CGSizeMake(320, 1000)];

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(280, 600)];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


- (IBAction)submitButtonPressed:(id)sender {
    if((self.eventName.text.length >0)&&(self.eventDescription.text.length > 0)){
        PFObject *event = [PFObject objectWithClassName:@"Event"];
        [event setObject:_datePicker.date forKey:@"eventDate"];
        [event setObject:_eventName.text forKey:@"Name"];
        [event setObject:_eventDescription.text forKey:@"Description"];
        if(self.categorySelector.selectedSegmentIndex == 0){
            [event setObject:@"Sports" forKey:@"eventCategory"];
        }
        if(self.categorySelector.selectedSegmentIndex == 1){
            [event setObject:@"Social" forKey:@"eventCategory"];
        }
        if(self.categorySelector.selectedSegmentIndex == 2){
            [event setObject:@"Contest" forKey:@"eventCategory"];
        }
        if(self.categorySelector.selectedSegmentIndex == 3){
            [event setObject:@"Speaker" forKey:@"eventCategory"];
        }
        if(self.categorySelector.selectedSegmentIndex == 4){
            [event setObject:@"Performance" forKey:@"eventCategory"];
        }
        
        // Upload recipe to Parse
        [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (!error) {
                // Show success message
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                // Dismiss the controller
                [self performSegueWithIdentifier:@"submit" sender:self];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please fill in the requested information" message:@"Fields left blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)eventReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)descriptionReturn:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)descriptionEndOnExit:(id)sender {
    [sender resignFirstResponder];
}
@end
