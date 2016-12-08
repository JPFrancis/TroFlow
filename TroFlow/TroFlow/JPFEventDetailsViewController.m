//
//  JPFEventDetailViewController.m
//  TroFlow
//
//  Created by John Paul Francis on 5/8/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "JPFEventDetailsViewController.h"
#import <Parse/Parse.h>

@interface JPFEventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionLabel;
- (IBAction)addToMyFlowPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bottomVIew2;
@property PFObject *tempObject;

@end

@implementation JPFEventDetailsViewController
@synthesize currentEventID;

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
    [self.bottomVIew2 setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query getObjectInBackgroundWithId:self.currentEventID block:^(PFObject *currentEvent, NSError *error) {
        
        self.tempObject = currentEvent;
        self.eventNameLabel.text = [currentEvent objectForKey:@"Name"];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *dateString = [dateFormatter stringFromDate:[currentEvent objectForKey:@"eventDate"]];
        [dateFormatter setDateStyle:NSDateFormatterNoStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        NSString *timeString = [dateFormatter stringFromDate:[currentEvent objectForKey:@"eventDate"]];
        
        self.eventTimeLabel.text = [NSString stringWithFormat:@"%@ | %@", dateString, timeString];
        
        self.eventDescriptionLabel.text = [currentEvent objectForKey:@"Description"];
        
        [self.eventDescriptionLabel sizeToFit];
        [self.eventNameLabel sizeToFit];
        [self.eventTimeLabel sizeToFit];
        
    }];
    
    
    
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

- (IBAction)addToMyFlowPressed:(id)sender {
    PFObject *event = [PFObject objectWithClassName:@"FlowEvents"];
    [event setObject:[self.tempObject objectForKey:@"eventDate"] forKey:@"eventDate"];
    [event setObject:[self.tempObject objectForKey:@"Name"] forKey:@"Name"];
    [event setObject:[self.tempObject objectForKey:@"Description"] forKey:@"Description"];
    [event setObject:[self.tempObject objectForKey:@"eventCategory"] forKey:@"eventCategory"];
    
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            // Dismiss the controller
            [self performSegueWithIdentifier:@"addToFlow" sender:self];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
}
@end
