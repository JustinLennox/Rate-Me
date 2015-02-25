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
    dispatch_async(dispatch_get_main_queue(), ^{
        self.usernameLabel.text = [NSString stringWithFormat:@"%@",[self.userObject objectForKey:@"username"]];
        [self loadProfileImages];
        [self roundButtons];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoButton1Pressed:(id)sender {
    if([self.userObject objectForKey:@"photo1"]){
        [self.mainPhotoButton setImage:self.photoButton1.imageView.image forState:UIControlStateNormal];
    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];
    }
}


- (IBAction)photoButton2Pressed:(id)sender {
    if([self.userObject objectForKey:@"photo2"]){
        [self.mainPhotoButton setImage:self.photoButton2.imageView.image forState:UIControlStateNormal];
    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];
        
    }
}

- (IBAction)photoButton3Pressed:(id)sender {

    if([self.userObject objectForKey:@"photo3"]){
        [self.mainPhotoButton setImage:self.photoButton3.imageView.image forState:UIControlStateNormal];

    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];

    }
}

-(void)loadProfileImages
{
        
        if([self.userObject objectForKey:@"photo1"]){
            PFFile *imageFile1 = [self.userObject objectForKey:@"photo1"];
            NSURL *imageFileUrl1 = [[NSURL alloc] initWithString:imageFile1.url];
            
            [self.mainPhotoButton sd_setImageWithURL:imageFileUrl1 forState:UIControlStateNormal];
            [self.photoButton1 sd_setImageWithURL:imageFileUrl1 forState:UIControlStateNormal];
        }
        
        if([self.userObject objectForKey:@"photo2"]){
            PFFile *imageFile2 = [self.userObject objectForKey:@"photo2"];
            NSURL *imageFileUrl2 = [[NSURL alloc] initWithString:imageFile2.url];
            [self.photoButton2 sd_setImageWithURL:imageFileUrl2 forState:UIControlStateNormal];
        }
        
        if([self.userObject objectForKey:@"photo3"]){
            PFFile *imageFile3 = [self.userObject objectForKey:@"photo3"];
            NSURL *imageFileUrl3 = [[NSURL alloc] initWithString:imageFile3.url];
            [self.photoButton3 sd_setImageWithURL:imageFileUrl3 forState:UIControlStateNormal];
        }
    
}



-(void)roundButtons{
    
    self.photoButton1.layer.cornerRadius = self.photoButton1.frame.size.height/2;
    self.photoButton1.layer.masksToBounds = YES;
    self.photoButton1.layer.borderWidth = 0;
    
    self.photoButton2.layer.cornerRadius = self.photoButton1.frame.size.height/2;
    self.photoButton2.layer.masksToBounds = YES;
    self.photoButton2.layer.borderWidth = 0;
    
    self.photoButton3.layer.cornerRadius = self.photoButton1.frame.size.height/2;
    self.photoButton3.layer.masksToBounds = YES;
    self.photoButton3.layer.borderWidth = 0;
    
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
