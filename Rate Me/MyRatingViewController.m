//
//  MyRatingViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "MyRatingViewController.h"
#import "ViewController.h"
@interface MyRatingViewController ()

@end

@implementation MyRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(250.00f/255.00f) green:(212.00f/255.00f) blue:(107.00f/255.00f) alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"My Rating";
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderWidth = 0;
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserObjects"];
    NSLog(@"%@", [[PFUser currentUser] username]);
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"It looks like we couldn't update your current games! Make sure you're connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else {
            self.userObject = [objects objectAtIndex:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadProfileImage];
                [self setRating];
            });
            
        }
    }];
    
    self.currentUser = [PFUser currentUser];
    self.usernameLabel.text = [self.currentUser objectForKey:@"username"];
    
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFUser *currentUser = [PFUser currentUser];
    if(!currentUser){
        NSLog(@"No user!");
        //ViewController *controller = [[ViewController alloc] init];
        //[self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) setRating{
    self.userAverageRating = 0.0f;
    self.userGirlRating = 0.0f;
    self.userBoyRating = 0.0f;
    self.userOverallRating = 0.0f;
    
    if([[self.userObject objectForKey:@"overallRatingArray"] count] > 0){
        for(NSNumber *number in [self.userObject objectForKey:@"overallRatingArray"]){
            self.userAverageRating += [number doubleValue];
        }
        self.userAverageRating = self.userAverageRating/[[self.userObject objectForKey:@"overallRatingArray"] count];
        self.userOverallRating = round(self.userAverageRating);
        self.overallRatingLabel.text =  [NSString stringWithFormat:@"%i", self.userOverallRating];
         self.averageRatingLabel.text = [NSString stringWithFormat:@"%.1f", self.userAverageRating];
    }else{
        self.overallRatingLabel.text =  @"?";
        self.averageRatingLabel.text = @"?";
    }
    
    
    if([[self.userObject objectForKey:@"maleRatingArray"] count] > 0){
        for(NSNumber *number in [self.userObject objectForKey:@"maleRatingArray"]){
            self.userBoyRating += [number doubleValue];
        }
        self.userBoyRating = self.userBoyRating/[[self.userObject objectForKey:@"maleRatingArray"] count];
        self.guyRatingLabel.text = [NSString stringWithFormat:@"%.1f", self.userBoyRating];
    }else{
        self.guyRatingLabel.text = @"?";
    }
    
    
    if([[self.userObject objectForKey:@"femaleRatingArray"] count] > 0){
        for(NSNumber *number in [self.userObject objectForKey:@"femaleRatingArray"]){
            self.userGirlRating += [number doubleValue];
        }
        self.userGirlRating = self.userGirlRating/[[self.userObject objectForKey:@"femaleRatingArray"] count];
        self.girlRatingLabel.text = [NSString stringWithFormat:@"%.1f", self.userGirlRating];
    }else{
        self.girlRatingLabel.text = @"?";
    }
    
    self.numberOfRatingsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[self.userObject objectForKey:@"overallRatingArray"] count]];

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showComments"])
    {
        NSLog(@"Oh we segued to comments alright");
        // Get reference to the destination view controller
        CommentsViewController *vc = [segue destinationViewController];
        vc.userObject = self.userObject;
        // Pass any objects to the view controller here, like...
        
    }
}

-(void)loadProfileImage
{
    if([self.userObject objectForKey:@"photo1"]){
        
        PFFile *imageFile1 = [self.userObject objectForKey:@"photo1"];
        NSURL *imageFileUrl1 = [[NSURL alloc] initWithString:imageFile1.url];
        //NSData *imageData1 = [NSData dataWithContentsOfURL:imageFileUrl1];
        [self.profileImage sd_setImageWithURL:imageFileUrl1];
        //self.profileImage.image = [UIImage imageWithData:imageData1];
    }
   
}
- (IBAction)profileButtonPressed:(id)sender {
    
    [self.tabBarController setSelectedIndex:1];
}
@end
