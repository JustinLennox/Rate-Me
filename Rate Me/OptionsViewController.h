//
//  OptionsViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIImage+fixOrientation.h"

@interface OptionsViewController : UIViewController

//Regular View
@property (weak, nonatomic) IBOutlet UIButton *myRatingButton;
@property (weak, nonatomic) IBOutlet UIButton *rateOthersButton;
@property (weak, nonatomic) IBOutlet UIButton *top10Button;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneButtonPressed:(id)sender;

//Present initial photo prompt for first time users
@property (weak, nonatomic) IBOutlet UIButton *noThanksButton;
- (IBAction)noThanksButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *darkBackground;
@property (weak, nonatomic) IBOutlet UILabel *getRatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *getRatedCaptionLabel;

//Present photo picker for first time users
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *chooseFromPhotosButton;
- (IBAction)chooseFromPhotosPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mainPhotoButton;
- (IBAction)mainPhotoButtonPressed:(id)sender;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) PFFile *file;
@property (strong, nonatomic) NSString *imageJustPicked;
//Parse user
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;

@end
