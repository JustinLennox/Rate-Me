//
//  OtherProfileViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 2/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "OtherProfileViewController.h"

@interface OtherProfileViewController ()

@end

@implementation OtherProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Username:%@", [self.userObject objectForKey:@"username"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
