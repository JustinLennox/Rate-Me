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

//#import "UIImage+fixOrientation.h"

@interface ProfileViewController : UIViewController

//UI Photo Buttons

- (IBAction)mainPhotoButtonPressed:(id)sender;
- (IBAction)photoButton2Pressed:(id)sender;
- (IBAction)photoButton3Pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *mainPhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *photoButton2;
@property (strong, nonatomic) IBOutlet UIButton *photoButton3;

//placeholders for the buttons
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;
@property (strong, nonatomic) UIImageView *image3;

//Photo Library Buttons
- (IBAction)choosePhoto1:(id)sender;
- (IBAction)choosePhoto2:(id)sender;
- (IBAction)choosePhoto3:(id)sender;

//image picker stuff
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *whichImagePicking;

-(void)presentImagePicker;

//Parse stuff
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;
@property (strong, nonatomic) NSString *isImagePickerHappening;
@property (weak, nonatomic) IBOutlet UIButton *enableCommentButton;
@property (strong, nonatomic) NSString *commentString;
- (IBAction)enableCommentsPressed:(id)sender;




@end
