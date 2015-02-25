//
//  OtherProfileViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 2/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
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

@interface OtherProfileViewController : UIViewController

//UI Photo Buttons

- (IBAction)photoButton1Pressed:(id)sender;
- (IBAction)photoButton2Pressed:(id)sender;
- (IBAction)photoButton3Pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *mainPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton1;
@property (strong, nonatomic) IBOutlet UIButton *photoButton2;
@property (strong, nonatomic) IBOutlet UIButton *photoButton3;

//placeholders for the buttons
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;
@property (strong, nonatomic) UIImageView *image3;

//Parse Stuff
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;
@property (strong, nonatomic) NSString *username;

//Comment Stuff
@property (strong, nonatomic) NSString *commentString;

//Username
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;


@end
