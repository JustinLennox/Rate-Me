//
//  RateOthersViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+WebCache.h"


@interface RateOthersViewController : UIViewController <UITextViewDelegate>

//Main Image
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;

//Thumbnail Buttons
- (IBAction)thumButton1Pressed:(id)sender;
- (IBAction)thumbButton2Pressed:(id)sender;
- (IBAction)thumbButton3Pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *thumButton1;
@property (strong, nonatomic) IBOutlet UIButton *thumbButton2;
@property (strong, nonatomic) IBOutlet UIButton *thumbButton3;

//Report Button
- (IBAction)reportButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

//Comment Stuff
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)commentButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) NSString *finalString;

//Rating Buttons
- (IBAction)rating1Pressed:(id)sender;
- (IBAction)rating2Pressed:(id)sender;
- (IBAction)rating3Pressed:(id)sender;
- (IBAction)rating4Pressed:(id)sender;
- (IBAction)rating5Pressed:(id)sender;
- (IBAction)rating6Pressed:(id)sender;
- (IBAction)rating7Pressed:(id)sender;
- (IBAction)rating8Pressed:(id)sender;
- (IBAction)rating9Pressed:(id)sender;
- (IBAction)rating10Pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rating1Button;
@property (weak, nonatomic) IBOutlet UIButton *rating2Button;
@property (weak, nonatomic) IBOutlet UIButton *rating3Button;
@property (weak, nonatomic) IBOutlet UIButton *rating4Button;
@property (weak, nonatomic) IBOutlet UIButton *rating5Button;
@property (weak, nonatomic) IBOutlet UIButton *rating6Button;
@property (weak, nonatomic) IBOutlet UIButton *rating7Button;
@property (weak, nonatomic) IBOutlet UIButton *rating8Button;
@property (weak, nonatomic) IBOutlet UIButton *rating9Button;
@property (weak, nonatomic) IBOutlet UIButton *rating10Button;
@property (strong, nonatomic) NSArray *buttonArray;

//Rating
@property (strong, nonatomic) NSNumber *finalRating;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
- (IBAction)rateButtonPressed:(id)sender;
-(void)loadNewImages;

//Three Images from Parse
@property (strong, nonatomic) UIImage *image1;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;
@property (strong, nonatomic) UIImage *image2;
@property (strong, nonatomic) UIImage *image3;

//Parse Files
@property (strong, nonatomic) NSArray *usersArray;
@property (nonatomic) int currentUserNumber;
@property (strong ,nonatomic) PFUser *currentRatingUser;
@property (strong, nonatomic) PFObject *parseUsersArray;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSString *currentUserGender;
@property (strong, nonatomic) PFQuery *usersQuery;
@property (nonatomic) BOOL queryingForUsers;


@end
