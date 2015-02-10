//
//  OptionsViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "OptionsViewController.h"
#import "ProfileViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    if(!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    [self.myRatingButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButton.png"] forState:UIControlStateNormal];
    [self.myRatingButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButtonPressed.png"] forState:UIControlStateSelected];
    [self.myRatingButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButtonPressed.png"] forState:UIControlStateHighlighted];
    
    [self.rateOthersButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButton.png"] forState:UIControlStateNormal];
    [self.rateOthersButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateSelected];
    [self.rateOthersButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateHighlighted];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(250.00f/255.00f) green:(212.00f/255.00f) blue:(107.00f/255.00f) alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Rate Me!";


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"] == YES){

        self.myRatingButton.enabled = NO;
        self.rateOthersButton.enabled = NO;
        self.top10Button.enabled = NO;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProfileViewController *profileView = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        [self setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:profileView animated:YES completion:nil];
        
        //ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        //profileViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        //self.navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //[self presentViewController:profileViewController animated:YES completion:^{
        //[self.view.window.rootViewController presentViewController:profileView];
            //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
            //[[NSUserDefaults standardUserDefaults] synchronize];
        //}];
        
    }else{
        self.myRatingButton.enabled = YES;
        self.rateOthersButton.enabled = YES;
        self.top10Button.enabled = YES;
    }
    

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
