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



//Master Login Buttons
@property (strong, nonatomic) IBOutlet UIButton *twitterLoginButton;
@property (strong, nonatomic) IBOutlet UIButton *emailLoginButton;
@property (strong, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (strong, nonatomic) IBOutlet UIButton *googlePlusLoginButton;
@property (strong, nonatomic) IBOutlet UIButton *changeLoginButton;

//Master Login Buttons Pressed
- (IBAction)twitterLoginPressed:(id)sender;
- (IBAction)emailLoginPressed:(id)sender;
- (IBAction)facebookLoginPressed:(id)sender;
- (IBAction)googlePlusLoginPressed:(id)sender;

- (IBAction)changeLoginButtonPressed:(id)sender;


//Email Login Stuff
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)signUpButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;

@end

