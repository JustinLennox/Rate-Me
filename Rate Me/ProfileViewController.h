//
//  ProfileViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <Parse/Parse.h>
#import "UIImage+fixOrientation.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImage+WebP.h"

@interface ProfileViewController : UIViewController

//UI Photo Buttons

- (IBAction)mainPhotoButtonPressed:(id)sender;
- (IBAction)photoButton1Pressed:(id)sender;
- (IBAction)photoButton2Pressed:(id)sender;
- (IBAction)photoButton3Pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *mainPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton1;
@property (strong, nonatomic) IBOutlet UIButton *photoButton2;
@property (strong, nonatomic) IBOutlet UIButton *photoButton3;
@property (strong, nonatomic) IBOutlet UILabel *photoLabel;

//placeholders for the buttons
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;
@property (strong, nonatomic) UIImageView *image3;

//Photo Library Buttons
- (IBAction)choosePhoto1:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *photoLibraryButton;

//image picker stuff
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *whichImagePicking;

-(void)presentImagePicker;

//Parse stuff
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;
@property (strong, nonatomic) NSString *isImagePickerHappening;

@property (strong, nonatomic) NSString *commentString;

//Username
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

//Switches
@property (strong, nonatomic) IBOutlet UISwitch *allowCommentSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *hideRatingSwitch;
- (IBAction)allowCommentSwitchPressed:(id)sender;
- (IBAction)hideRatingSwitchPressed:(id)sender;

//ModalView Presentation
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneButtonPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *cameraImage;

@end
