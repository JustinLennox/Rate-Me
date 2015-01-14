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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)signUpButtonPressed:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0 || !self.userGender) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username, password, email address, and choose your gender!" delegate:nil cancelButtonTitle:@"Ok :D" otherButtonTitles: nil];
        [alertView show];
    }
    
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        [newUser setObject:self.userGender forKey:@"Gender"];
        
        NSArray *emptyArray = [[NSArray alloc] init];
        NSDictionary *emptyDictionary = [[NSDictionary alloc] init];
        
        PFObject *userObject = [PFObject objectWithClassName:@"UserObjects"];
        [userObject setObject:newUser.username forKey:@"username"];
        [userObject setObject:emptyArray forKey:@"overallRatingArray"];
        [userObject setObject:emptyArray forKey:@"femaleRatingArray"];
        [userObject setObject:emptyArray forKey:@"maleRatingArray"];
        [userObject setObject:@0 forKey:@"reports"];
        [userObject setObject:@"NO" forKey:@"commentsEnabled"];
        [userObject setObject:emptyDictionary forKey:@"commentsDictionary"];

        
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

- (IBAction)femaleButtonPressed:(id)sender {
    self.userGender = @"Female";
}

- (IBAction)maleButtonPressed:(id)sender {
    self.userGender = @"Male";
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
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"Login error! Make sure your username and password are correct!"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }else{
               [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
        }];
    }

}

@end
