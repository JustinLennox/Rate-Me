//
//  MyRatingViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CommentsViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface MyRatingViewController : UIViewController

//User Props
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIButton *profileImage;

//User Ratings
@property (nonatomic) float userAverageRating;
@property (nonatomic) float userGirlRating;
@property (nonatomic) float userBoyRating;
@property (nonatomic) int userOverallRating;
@property (nonatomic) int numberOfRatings;



//Rating Labels
@property (strong, nonatomic) IBOutlet UILabel *overallRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *guyRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *girlRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfRatingsLabel;


//Profile Button
- (IBAction)profileButtonPressed:(id)sender;


//Did You Know?
@property (strong, nonatomic) IBOutlet UILabel *didYouKnowLabel;
@property (strong, nonatomic) IBOutlet UILabel *didYouKnowTextLabel;
@property (strong, nonatomic) NSArray *didYouKnowInfo;


@end
