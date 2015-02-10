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


//Parse user
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFObject *userObject;

@end
