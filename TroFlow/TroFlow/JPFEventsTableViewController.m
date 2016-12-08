//
//  JPFEventsTableViewController.m
//  TroFlow
//
//  Created by John Paul Francis on 5/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "JPFEventsTableViewController.h"
#import <Parse/Parse.h>
#import "JPFEventDetailsViewController.h"

@interface JPFEventsTableViewController ()
@property (assign, nonatomic) int currentRow;
@property (strong, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation JPFEventsTableViewController
@synthesize eventsArray;
@synthesize rowNo;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView = self.theTableView;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
    [self performSelector:@selector(retrieveFromParse)];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1];
    self.refreshControl = refreshControl;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [eventsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Event";
    [cell setBackgroundColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
    
    //NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:[eventsArray objectAtIndex:indexPath.row]];
    PFObject *tempObject = [eventsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempObject objectForKey:@"Name"];
    
    NSDate *date = [NSDate date];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSString *dateString = [dateFormatter stringFromDate:[tempObject objectForKey:@"eventDate"]];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	NSString *timeString = [dateFormatter stringFromDate:[tempObject objectForKey:@"eventDate"]];
	
    //cell.detailTextLabel.text = [tempObject objectForKey:@"Description"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@", dateString, timeString];
    
    if([[tempObject objectForKey:@"eventCategory"] isEqualToString:@"Sports"]){
        UIImage *img = [UIImage imageNamed:@"sports.png"];
        cell.imageView.image = img;
    }
    if([[tempObject objectForKey:@"eventCategory"] isEqualToString:@"Social"]){
        UIImage *img = [UIImage imageNamed:@"social.png"];
        cell.imageView.image = img;
    }
    if([[tempObject objectForKey:@"eventCategory"] isEqualToString:@"Contest"]){
        UIImage *img = [UIImage imageNamed:@"competition.png"];
        cell.imageView.image = img;
    }
    if([[tempObject objectForKey:@"eventCategory"] isEqualToString:@"Speaker"]){
        UIImage *img = [UIImage imageNamed:@"speaker.png"];
        cell.imageView.image = img;
    }
    if([[tempObject objectForKey:@"eventCategory"] isEqualToString:@"Performance"]){
        UIImage *img = [UIImage imageNamed:@"performance.png"];
        [img drawInRect:CGRectMake(0, 0, 32, 32)];
        cell.imageView.image = img;
    }
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (void) retrieveFromParse {
    PFQuery *retrieveEvents = [PFQuery queryWithClassName:@"Event"];
    [retrieveEvents findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            eventsArray = [[NSArray alloc] initWithArray:objects];
        }
        [self.tableView reloadData];
    }];
    if([eventsArray count]>0){
        NSLog(@"something there...");
    }
    for(int i =0; i < [eventsArray count]; i++){
        PFObject *tempObject = [eventsArray objectAtIndex:i];
        NSLog([tempObject objectId]);
    }
}

- (void)updateTable
{
    [self retrieveFromParse];
    
    //[yourView.layer removeAnimationForKey:@"Spin"];
    [self.refreshControl endRefreshing];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HERE!");
    rowNo = indexPath.row;
    NSLog([NSString stringWithFormat:@"%d", rowNo]);
    [self performSegueWithIdentifier:@"showEventDetail" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        NSLog(@"HERE");
        JPFEventDetailsViewController *destViewController = segue.destinationViewController;
        PFObject *tempObject = [eventsArray objectAtIndex:rowNo];
        destViewController.currentEventID = [tempObject objectId];
        NSLog(destViewController.currentEventID);
    }
}


@end
