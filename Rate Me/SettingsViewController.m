//
//  SettingsViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 2/25/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //[backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoutButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ViewController *destViewController = segue.destinationViewController;
        
        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

-(void)logout{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

@end
