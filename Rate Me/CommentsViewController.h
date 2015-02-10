//
//  CommentsViewController.h
//  Rate Me
//
//  Created by Justin Lennox on 1/1/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRatingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CommentButton.h"

@interface CommentsViewController : UIViewController

@property (nonatomic, strong) PFObject *userObject;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (nonatomic) int lastCommentY;
@property (nonatomic) NSUInteger commentNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *regularView;

@property (strong, nonatomic) PFQuery *usersQuery;
@property (nonatomic) BOOL queryingForUsers;
@property (strong, nonatomic) NSArray *usersArray;

@end
