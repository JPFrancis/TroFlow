//
//  JPFFirstViewController.m
//  TroFlow
//
//  Created by John Paul Francis on 5/6/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "JPFFirstViewController.h"

@interface JPFFirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *trojanLogo;

@end

@implementation JPFFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([self.tabBarController.tabBar respondsToSelector:@selector(setTintColor:)]) {
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.8 green:0.478 blue:0 alpha:1]];
    }
    [self.tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.188 green:0 blue:0 alpha:1] ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animateLogo {
    
}

@end
