//
//  JPFEventsTableViewController.h
//  TroFlow
//
//  Created by John Paul Francis on 5/7/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPFEventsTableViewController : UITableViewController{
    NSArray *eventsArray;
    int rowNo;
}
@property NSArray *eventsArray;
@property int rowNo;
@end
