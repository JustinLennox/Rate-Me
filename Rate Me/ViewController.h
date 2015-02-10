//
//  ViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *maleButton;
@property (strong, nonatomic) IBOutlet UIButton *femaleButton;
@property (strong, nonatomic) NSString *userGender;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)signUpButtonPressed:(id)sender;
- (IBAction)femaleButtonPressed:(id)sender;
- (IBAction)maleButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UISwitch *genderSwitch;
- (IBAction)switchTouched:(id)sender;

@end

