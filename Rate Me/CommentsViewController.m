//
//  CommentsViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 1/1/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "CommentsViewController.h"
#import "OtherProfileViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.lastCommentY = 50;
    self.commentNumber = 0;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Comments";
    
    for(id key in [self.userObject objectForKey:@"commentsDictionary"])
    {
        CommentButton *commentButton = [CommentButton buttonWithType:UIButtonTypeRoundedRect];
        NSString *commentString = [[self.userObject objectForKey:@"commentsDictionary"] objectForKey:key];
        NSLog(@"comment: %@", commentString);
        commentButton.frame = CGRectMake(10, self.lastCommentY+10, 200, 25);
        self.lastCommentY += 35;
        commentButton.alpha = 1.0f;
        
        NSString *genderLetter = [commentString substringWithRange:NSMakeRange(commentString.length-1, 1)];

        
        if(commentString.length <= 120){
            commentString = [commentString substringWithRange:NSMakeRange(0, commentString.length-1)];
        }else{
             commentString = [commentString substringWithRange:NSMakeRange(0, 120)];
        }
        
        if(commentString.length > 25 && commentString.length <= 50){
            commentString = [NSString stringWithFormat:@"%@\n%@", [commentString substringWithRange:NSMakeRange(0, 25)], [commentString substringWithRange:NSMakeRange(25, commentString.length-25)]];
        }else if(commentString.length > 50){
            commentString = [NSString stringWithFormat:@"%@\n%@\n%@", [commentString substringWithRange:NSMakeRange(0, 25)], [commentString substringWithRange:NSMakeRange(25, 25)], [commentString substringWithRange:NSMakeRange(50, commentString.length-50)]];
        }
        
        
        [commentButton setTitle:commentString forState:UIControlStateNormal];
        [commentButton sizeToFit];
        commentButton.frame = CGRectMake(commentButton.frame.origin.x, commentButton.frame.origin.y, commentButton.frame.size.width+10, commentButton.frame.size.height);
        [[commentButton layer] setBorderWidth:0.8f];
        commentButton.layer.cornerRadius = 4;
        commentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        commentButton.titleLabel.textAlignment = NSTextAlignmentCenter;

        
        if([genderLetter isEqualToString:@"m"]){
            [commentButton setTitleColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f] forState:UIControlStateNormal];
            [[commentButton layer] setBorderColor:[UIColor colorWithRed:(2.00f/255.00f) green:(186.00f/255.00f) blue:(242.00f/255.00f) alpha:1.0f].CGColor];
        }else{
             [commentButton setTitleColor:[UIColor colorWithRed:(248.00f/255.00f) green:(69.00f/255.00f) blue:(69.00f/255.00f) alpha:1.0f] forState:UIControlStateNormal];
            [[commentButton layer] setBorderColor:[UIColor colorWithRed:(248.00f/255.00f) green:(69.00f/255.00f) blue:(69.00f/255.00f) alpha:1.0f].CGColor];

        }
        
        commentButton.contentMode = UIViewContentModeScaleAspectFill;
        
        //Make it so that pressing the comment loads the user's profile
        commentButton.username = [NSString stringWithFormat:@"%@", key];
        [commentButton addTarget:self
                   action:@selector(loadProfile:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self.regularView addSubview:commentButton];
        
        self.commentNumber++;
        
    }
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    self.scrollView.contentSize = CGSizeMake(320, self.lastCommentY);


}

-(void)loadProfile:(CommentButton *)sender {
    NSString *username = sender.username;
    
    self.usersQuery = [PFQuery queryWithClassName:@"UserObjects"];
    [self.usersQuery whereKey:@"username" equalTo:username];
    [self.usersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.queryingForUsers = YES;
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"It looks like we couldn't find the user! Make sure you're connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            self.queryingForUsers = NO;
        }
        else {
            NSLog(@"We found messages!");
            // We found messages!
            self.usersArray = objects;
            [self performSegueWithIdentifier:@"showUserProfile" sender:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.queryingForUsers = NO;
            });
            
        }
        
    }];


}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"showUserProfile"]) {
        OtherProfileViewController *controller = (OtherProfileViewController *)segue.destinationViewController;
        controller.userObject = [self.usersArray objectAtIndex:0];
 }
 }

@end
