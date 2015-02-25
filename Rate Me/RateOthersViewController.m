//
//  RateOthersViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "RateOthersViewController.h"
//#import "UIImage+fixOrientation.h"

@interface RateOthersViewController ()

@end

@implementation RateOthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(250.00f/255.00f) green:(212.00f/255.00f) blue:(107.00f/255.00f) alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.rateButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButton.png"] forState:UIControlStateNormal];
    [self.rateButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateHighlighted];
    [self.rateButton setBackgroundImage:[UIImage imageNamed:@"3DYellowButtonPressed.png"] forState:UIControlStateSelected];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Rate Others";
    
    self.commentTextView.alpha = 0.0f;
    self.commentButton.alpha = 0.0f;
    self.currentUserNumber = 0;
    
    //Load the users to be rated
    [self loadNewUsersAndAd];
    
    if([[[PFUser currentUser] objectForKey:@"Gender"] isEqualToString:@"Male"]){
        self.currentUserGender = @"Male";
    }else{
        self.currentUserGender = @"Female";
    }
    
    self.commentTextView.delegate = self;
    
    [self.reportButton setBackgroundImage:[UIImage imageNamed:@"RedOutline"] forState:UIControlStateNormal];
    [self.reportButton setBackgroundImage:[UIImage imageNamed:@"RedButton"] forState:UIControlStateHighlighted];
    [self.reportButton setBackgroundImage:[UIImage imageNamed:@"RedButton"] forState:UIControlStateSelected];
    [self.reportButton setBackgroundImage:[UIImage imageNamed:@"RedButton"] forState:UIControlStateDisabled];
    [self.reportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.reportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.reportButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"OutlineButton"] forState:UIControlStateNormal];
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"BlueButton"] forState:UIControlStateHighlighted];
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"BlueButton"] forState:UIControlStateSelected];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    self.buttonArray = @[self.rating1Button, self.rating2Button, self.rating3Button, self.rating4Button, self.rating5Button, self.rating6Button, self.rating6Button, self.rating7Button, self.rating8Button, self.rating9Button, self.rating10Button];
    
        [self roundButtons];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.queryingForUsers){
        [self.usersQuery cancel];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)thumButton1Pressed:(id)sender {
    self.mainImage.image = self.thumButton1.imageView.image;
    
}

- (IBAction)thumbButton2Pressed:(id)sender {
    self.mainImage.image = self.thumbButton2.imageView.image;
}

- (IBAction)thumbButton3Pressed:(id)sender {
    self.mainImage.image = self.thumbButton3.imageView.image;
}

- (IBAction)reportButtonPressed:(id)sender {
    [self.currentRatingUser incrementKey:@"reports"];
    self.reportButton.enabled = NO;
}


- (IBAction)rating1Pressed:(id)sender {
    self.finalRating = @1;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating1Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating2Pressed:(id)sender {
    self.finalRating = @2;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating2Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating3Pressed:(id)sender {
    self.finalRating = @3;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating3Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating3Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating4Pressed:(id)sender {
    self.finalRating = @4;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating4Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating4Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating5Pressed:(id)sender {
    self.finalRating = @5;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating5Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating5Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating6Pressed:(id)sender {
    self.finalRating = @6;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating6Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating6Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating7Pressed:(id)sender {
    self.finalRating = @7;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating7Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating7Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating8Pressed:(id)sender {
    self.finalRating = @8;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating8Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating8Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating9Pressed:(id)sender {
    self.finalRating = @9;
     self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating9Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating9Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rating10Pressed:(id)sender {
    self.finalRating = @10;
    self.rateButton.enabled = YES;
    [self unhighlightButtons];
    [self.rating10Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rating10Button setBackgroundColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f]];
}

- (IBAction)rateButtonPressed:(id)sender {
    if(self.finalRating){
        self.rateButton.enabled = NO;
        NSLog(@"User:%i; rating:%@", self.currentUserNumber, self.finalRating);
        
        [[self.currentRatingUser objectForKey:@"overallRatingArray"] addObject:self.finalRating];
        
        if([self.currentUserGender isEqualToString:@"Male"]){
            [[self.currentRatingUser objectForKey:@"maleRatingArray"] addObject:self.finalRating];
        }else{
            [[self.currentRatingUser objectForKey:@"femaleRatingArray"] addObject:self.finalRating];
        }
        
        if(self.commentTextView.text.length > 0){
            
            if(self.anonymous){
                self.finalString = [NSString stringWithFormat:@"%@%@", self.commentTextView.text, @"a"];
            }else{
                if([self.currentUserGender isEqualToString:@"Male"]){
                   self.finalString = [NSString stringWithFormat:@"%@%@", self.commentTextView.text, @"m"];
                }else{
                   self.finalString = [NSString stringWithFormat:@"%@%@", self.commentTextView.text, @"f"];
                }
            }
            
            //Check to make sure they have a comments dictionary
            if([self.currentRatingUser objectForKey:@"commentsDictionary"])
            {
                NSDictionary *commentsDictionary = [NSDictionary dictionaryWithDictionary:[self.currentRatingUser objectForKey:@"commentsDictionary"]];
                NSMutableDictionary *mutableCommentsDictionary = [NSMutableDictionary dictionaryWithDictionary:[commentsDictionary mutableCopy]];
                NSLog(@"Comments Dictionary: %@", commentsDictionary);
                NSLog(@"Final String: %@", self.finalString);
                
                [mutableCommentsDictionary setObject:self.finalString forKey:[NSString stringWithFormat:@"%@", [[PFUser currentUser] username]]];
                [self.currentRatingUser setObject:mutableCommentsDictionary forKey:@"commentsDictionary"];
            }else{
                NSMutableDictionary *commentsDictionary = [[NSMutableDictionary alloc] init];
                [commentsDictionary setObject:self.finalString forKey:self.currentUser.username];
                [self.currentRatingUser setObject:commentsDictionary forKey:@"commentsDictionary"];
            }
            
        }
        
       //NSMutableArray *newUsersArray = [NSMutableArray arrayWithArray:self.usersArray];
        //[newUsersArray replaceObjectAtIndex:self.currentUserNumber withObject:self.currentRatingUser];
        
        //if(self.currentUserNumber == 5){
       [PFObject saveAllInBackground:self.usersArray block:^(BOOL succeeded, NSError *error) {
            if(error){
                
            }else{
                NSLog(@"Yup we're saving");
            }
        }];
        //}
       /*[self.currentRatingUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(error){
                
            }else{
                NSLog(@"It worked!");
            }
        }];*/
        self.finalRating = 0;
        self.commentTextView.text = @"";
        self.commentTextView.alpha = 0.0f;
        self.commentButton.alpha = 0.0f;
        self.currentUserNumber++;
        [self unhighlightButtons];
        [self loadNewImages];
    }
    
}

-(void)loadNewImages{
    
    self.rateButton.enabled = NO;
    
    if(self.currentUserNumber < self.usersArray.count){
        
        self.currentRatingUser = [self.usersArray objectAtIndex:self.currentUserNumber];
        
        while(![self.currentRatingUser objectForKey:@"photo1"])
        {
            if([self.currentRatingUser objectForKey:@"photo1"])
            {
                NSLog(@"Cause I'm about to break!");
                break;
            }else{
                self.currentUserNumber++;
                self.currentRatingUser = [self.usersArray objectAtIndex:self.currentUserNumber];
                NSLog(@"There wasn't a photo in that one");
            }
        }
        
        if([self.currentRatingUser objectForKey:@"photo1"]){
            //self.rateButton.enabled = YES;
            self.reportButton.enabled = YES;
            PFFile *imageFile1 = [self.currentRatingUser objectForKey:@"photo1"];
            NSURL *imageFileUrl1 = [[NSURL alloc] initWithString:imageFile1.url];
            //NSData *imageData1 = [NSData dataWithContentsOfURL:imageFileUrl1];
            [self.mainImage sd_setImageWithURL:imageFileUrl1];
            [self.thumButton1 sd_setImageWithURL:imageFileUrl1 forState:UIControlStateNormal];
        }
        
        if([self.currentRatingUser objectForKey:@"photo2"])
        {
            PFFile *imageFile2 = [self.currentRatingUser objectForKey:@"photo2"];
            NSURL *imageFileUrl2 = [[NSURL alloc] initWithString:imageFile2.url];
            //NSData *imageData2 = [NSData dataWithContentsOfURL:imageFileUrl2];
            //self.image2 = [UIImage imageWithData:imageData2];
            [self.thumbButton2 sd_setImageWithURL:imageFileUrl2 forState:UIControlStateNormal];
            self.thumbButton2.alpha = 1.0f;
        }else
        {
            self.thumbButton2.alpha = 0.0f;
        }
        
        if([self.currentRatingUser objectForKey:@"photo3"])
        {
            PFFile *imageFile3 = [self.currentRatingUser objectForKey:@"photo3"];
            NSURL *imageFileUrl3 = [[NSURL alloc] initWithString:imageFile3.url];
            //NSData *imageData3 = [NSData dataWithContentsOfURL:imageFileUrl3];
            //self.image3 = [UIImage imageWithData:imageData3];
            [self.thumbButton3 sd_setImageWithURL:imageFileUrl3 forState:UIControlStateNormal];
             self.thumbButton3.alpha = 1.0f;
        }else
        {
             self.thumbButton3.alpha = 0.0f;
        }
        
        if([[self.currentRatingUser objectForKey:@"commentsEnabled"] isEqualToString:@"YES"])
        {
            self.commentButton.alpha = 1.0f;
        }
    }

}

-(BOOL)doesUserHavePhoto
{
    for(PFUser *user in self.usersArray)
    {
        if([self.currentRatingUser objectForKey:@"photo1"])
        {
            return YES;
        }else{
            self.currentUserNumber++;
            return NO;
        }
    }
    return NO;
}

-(void)loadNewUsersAndAd{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSLog(@"Loading New Users and Ad");
    self.usersQuery = [PFQuery queryWithClassName:@"UserObjects"];
    [self.usersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.queryingForUsers = YES;
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"It looks like we couldn't update your current games! Make sure you're connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            self.queryingForUsers = NO;
        }
        else {
            NSLog(@"We found messages!");
            // We found messages!
            self.usersArray = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadNewImages];
                self.queryingForUsers = NO;
            });
            
        }
        
    }];
    });
    
    
}

#pragma mark - format button methods

-(void)roundButtons{
    
    self.thumButton1.layer.cornerRadius = self.thumButton1.frame.size.height/2;
    self.thumButton1.layer.masksToBounds = YES;
    self.thumButton1.layer.borderWidth = 0;
    
    self.thumbButton2.layer.cornerRadius = self.thumButton1.frame.size.height/2;
    self.thumbButton2.layer.masksToBounds = YES;
    self.thumbButton2.layer.borderWidth = 0;
    
    self.thumbButton3.layer.cornerRadius = self.thumButton1.frame.size.height/2;
    self.thumbButton3.layer.masksToBounds = YES;
    self.thumbButton3
    .layer.borderWidth = 0;
    
    for(UIButton *button in self.buttonArray){
        button.layer.cornerRadius = button.bounds.size.width / 2.0;
        button.layer.borderWidth = 0.8;
        button.layer.borderColor = [UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f].CGColor;
    }
    
}

-(void)unhighlightButtons{
    for(UIButton *button in self.buttonArray)
    {
        [button setTitleColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
    }
}

//Comment Methods

- (IBAction)commentButtonPressed:(id)sender {
    
    self.commentTextView.alpha = 0.5f;
    [self.commentTextView becomeFirstResponder];
    
}

#define MAX_LENGTH 120

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    if(newLength <= MAX_LENGTH)
    {
        if([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
        }
        return YES;
    } else {
        NSUInteger emptySpace = MAX_LENGTH - (textView.text.length - range.length);
        textView.text = [[[textView.text substringToIndex:range.location]
                          stringByAppendingString:[text substringToIndex:emptySpace]]
                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
        if([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
        }
        return NO;
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.commentTextView resignFirstResponder];
     self.commentTextView.alpha = 0.0f;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.alpha = 0.0f;
    self.commentTextView.alpha = 0.0f;
    return NO;
}

@end
