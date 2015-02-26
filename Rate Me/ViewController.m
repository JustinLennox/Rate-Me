//
//  ViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Set the textfield delegates
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.emailField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButton.png"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButtonPressed.png"] forState:UIControlStateHighlighted];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"3DBlueButtonPressed.png"] forState:UIControlStateSelected];
    
    [self.signupButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButton.png"] forState:UIControlStateNormal];
    [self.signupButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateHighlighted];
    [self.signupButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateSelected];
    
    //Set up TextFields for Email Login
    [self.usernameField setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
    userIcon.image = [UIImage imageNamed:@"user-50.png"];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    [paddingView addSubview:userIcon];
    self.usernameField.leftView = paddingView;
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.alpha = 0.0f;
    
    [self.passwordField setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *userIcon2 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 15, 15)];
    userIcon2.image = [UIImage imageNamed:@"lock-50.png"];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    [paddingView2 addSubview:userIcon2];
    self.passwordField.leftView = paddingView2;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.alpha = 0.0f;
    
    [self.emailField setLeftViewMode:UITextFieldViewModeAlways];
    UIImageView *userIcon3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
    userIcon3.image = [UIImage imageNamed:@"email-50.png"];
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    [paddingView3 addSubview:userIcon3];
    self.emailField.leftView = paddingView3;
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.alpha = 0.0f;
    
    //Set all the email login stuff's alpha to 0 so we don't see it. We only want to see this stuff when the user wants to login with email
    self.emailField.alpha = 0.0f;
    self.passwordField.alpha = 0.0f;
    self.usernameField.alpha = 0.0f;
    self.loginButton.alpha = 0.0f;
    self.signupButton.alpha = 0.0f;
    

    self.changeLoginButton.alpha = 0.0f;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark- Master Login Methods

- (IBAction)twitterLoginPressed:(id)sender {
    [self changeMasterLoginButtonAlphas];
}

- (IBAction)emailLoginPressed:(id)sender {
    [self changeMasterLoginButtonAlphas];
    
    self.emailField.alpha = 1.0f;
    self.passwordField.alpha = 1.0f;
    self.usernameField.alpha = 1.0f;
    self.loginButton.alpha = 1.0f;
    self.signupButton.alpha = 1.0f;
    
}

- (IBAction)facebookLoginPressed:(id)sender {
    [self changeMasterLoginButtonAlphas];
    
   /* [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
        if (!user) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"The Facebook login was unsuccessful. If you didn't cancel it on purpose, make sure you are connected to the internet. If you are, you may have to reset your phone's Facebook privacy settings under Settings>Privacy>Facebook!" delegate:nil cancelButtonTitle:@"Ok :D" otherButtonTitles: nil];
            [alertView show];
        } else if (user.isNew) {
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"name"]
                                             forKey:@"username"];
                    [[PFUser currentUser] saveInBackground];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }}];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // Store the current user's Facebook ID on the user
                    [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                             forKey:@"fbId"];
                    [[PFUser currentUser] setObject:[result objectForKey:@"name"]
                                             forKey:@"displayName"];
                    [[PFUser currentUser] saveInBackground];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
    }];*/

}

- (IBAction)googlePlusLoginPressed:(id)sender {
    [self changeMasterLoginButtonAlphas];
}

- (IBAction)changeLoginButtonPressed:(id)sender {
    [self changeMasterLoginButtonAlphas];
    
    //Hide the email login stuff
    self.emailField.alpha = 0.0f;
    self.passwordField.alpha = 0.0f;
    self.usernameField.alpha = 0.0f;
    self.loginButton.alpha = 0.0f;
    self.signupButton.alpha = 0.0f;
    
    
}

-(void)changeMasterLoginButtonAlphas{
    
    if(self.emailLoginButton.alpha == 1.0f){
        //This means we can see the master login buttons and want to hide them.
        self.facebookLoginButton.alpha = 0.0f;
        self.googlePlusLoginButton.alpha = 0.0f;
        self.twitterLoginButton.alpha = 0.0f;
        self.emailLoginButton.alpha = 0.0f;
        self.changeLoginButton.alpha = 1.0f;
    }else{
        //This means we can't see the master login buttons and we want to show them.
        self.facebookLoginButton.alpha = 1.0f;
        self.googlePlusLoginButton.alpha = 1.0f;
        self.twitterLoginButton.alpha = 1.0f;
        self.emailLoginButton.alpha = 1.0f;
        self.changeLoginButton.alpha = 0.0f;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

#pragma mark- Email Signup and Login Methods
- (IBAction)signUpButtonPressed:(id)sender {
    
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username, password, and email address!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
    
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        PFFile *emptyPicture = [[PFFile alloc] init];
        
        PFObject *userObject = [PFObject objectWithClassName:@"UserObjects"];
        [userObject setObject:newUser.username forKey:@"username"];
        [userObject setObject:emptyPicture forKey:@"profilePicture"];
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }else{
                [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(error){
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alertView show];

                        
                    }else{
                        
                    }
                
                }];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        
    }
}

- (IBAction)loginButtonPressed:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username and password!" delegate:nil cancelButtonTitle:@"Ok :D" otherButtonTitles: nil];
        [alertView show];
    }else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }else{
               [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
        }];
    }

}

#pragma mark- Text and Keyboard Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passwordField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField) {
        //[textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        //[textField resignFirstResponder];
        [self.emailField becomeFirstResponder];
        // here you can define what happens
        // when user presses return on the email field
    }else if (textField == self.emailField) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}



@end
