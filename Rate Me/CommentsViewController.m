//
//  CommentsViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 1/1/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "CommentsViewController.h"

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
    
    for(NSString *comment in [self.userObject objectForKey:@"commentsDictionary"])
    {
        UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        NSString *commentString = [[self.userObject objectForKey:@"commentsDictionary"] objectAtIndex:self.commentNumber];
        commentButton.frame = CGRectMake(50, self.lastCommentY+10, 200, 25);
        self.lastCommentY += 30;
        commentButton.alpha = 1.0f;
        commentButton.titleLabel.textColor = [UIColor whiteColor];
        
        NSString *genderLetter = [commentString substringWithRange:NSMakeRange(commentString.length-1, 1)];
        NSLog(@"Gender: %@", genderLetter);
        if([genderLetter isEqualToString:@"m"]){
            commentButton.backgroundColor = [UIColor grayColor];
        }else{
            commentButton.backgroundColor = [UIColor blueColor];
        }
        
        if(commentString.length <= 120){
            commentString = [commentString substringWithRange:NSMakeRange(0, commentString.length-1)];
        }else{
             commentString = [commentString substringWithRange:NSMakeRange(0, 120)];
        }
        
        NSLog(@"%@",[[self.userObject objectForKey:@"commentsArray"] objectAtIndex:self.commentNumber]);
        [commentButton setTitle:commentString forState:UIControlStateNormal];
        commentButton.titleLabel.numberOfLines = 3;
        commentButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        
        [commentButton sizeToFit];
        [self.regularView addSubview:commentButton];
        
        self.commentNumber++;
        
    }
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    self.scrollView.contentSize = CGSizeMake(320, self.lastCommentY);


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
