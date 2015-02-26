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
#import "BarChartView.h"
#import "UIColor+UIColor.h"

@interface MyRatingViewController : UIViewController <UIScrollViewDelegate>

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


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *containerView;

//Rating Labels
@property (strong, nonatomic) IBOutlet UILabel *overallRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *guyRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *girlRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfRatingsLabel;

//Number Counts
@property (nonatomic) int count1;
@property (nonatomic) int count2;
@property (nonatomic) int count3;
@property (nonatomic) int count4;
@property (nonatomic) int count5;
@property (nonatomic) int count6;
@property (nonatomic) int count7;
@property (nonatomic) int count8;
@property (nonatomic) int count9;
@property (nonatomic) int count10;


//Statistics
@property (strong, nonatomic) IBOutlet UILabel *medianValue;
@property (strong, nonatomic) IBOutlet UILabel *modeValue;

//Profile Button
- (IBAction)profileButtonPressed:(id)sender;


//Did You Know?
@property (strong, nonatomic) IBOutlet UILabel *didYouKnowLabel;
@property (strong, nonatomic) IBOutlet UILabel *didYouKnowTextLabel;
@property (strong, nonatomic) NSArray *didYouKnowInfo;

//Bar Chart Properties

@property (strong, nonatomic) IBOutlet BarChartView *barChart;

@end
