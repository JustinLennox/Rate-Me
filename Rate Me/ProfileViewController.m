//
//  ProfileViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *currentUser = [PFUser currentUser];
    if(!currentUser){
        NSLog(@"No user!");
        ViewController *controller = [[ViewController alloc] init];
        [self.view.window.rootViewController presentViewController:controller animated:YES completion:nil];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(250.00f/255.00f) green:(212.00f/255.00f) blue:(107.00f/255.00f) alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Profile";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //[backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"Logout" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [backButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self roundButtons];
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserObjects"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"It looks like we couldn't update your current games! Make sure you're connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else {
            self.userObject = [objects objectAtIndex:0];
            //We found objects!
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadProfileImages];
                self.usernameLabel.text = [NSString stringWithFormat:@"%@'s Profile", [[PFUser currentUser] username]];
                [self updateSwitches];
            });

        }
        
    }];
    
    [self.photoLibraryButton setBackgroundImage:[UIImage imageNamed:@"BlueButton.png"] forState:UIControlStateHighlighted];
    [self.photoLibraryButton setBackgroundImage:[UIImage imageNamed:@"BlueButton.png"] forState:UIControlStateSelected];
    [self.photoLibraryButton setBackgroundImage:[UIImage imageNamed:@"OutlineButton.png"] forState:UIControlStateNormal];
    
    self.whichImagePicking = @"1";
    self.cameraImage.alpha = 0.0f;
    self.photoLabel.alpha = 0.0f;
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"] == YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.cameraImage.alpha = 1.0f;
        self.photoLabel.alpha = 1.0f;
        self.photoLabel.text = @"Main Photo";
        self.doneButton.alpha = 1.0f;
    }else{
        self.doneButton.alpha = 0.0f;
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - choose photo buttons



- (IBAction)mainPhotoButtonPressed:(id)sender {
    [self presentImagePicker];
}

- (IBAction)photoButton1Pressed:(id)sender {
    self.whichImagePicking = @"1";
    if([self.userObject objectForKey:@"photo1"]){
        [self.mainPhotoButton setImage:self.photoButton1.imageView.image forState:UIControlStateNormal];
        self.cameraImage.alpha = 0.0f;
        self.photoLabel.alpha = 0.0f;
        self.photoLabel.text = nil;
    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];
        self.cameraImage.alpha = 1.0f;
        self.photoLabel.alpha = 1.0f;
        self.photoLabel.text = @"Main Photo";
    }
}


- (IBAction)photoButton2Pressed:(id)sender {
    self.whichImagePicking = @"2";
    if([self.userObject objectForKey:@"photo2"]){
        [self.mainPhotoButton setImage:self.photoButton2.imageView.image forState:UIControlStateNormal];
        self.cameraImage.alpha = 0.0f;
        self.photoLabel.alpha = 0.0f;
        self.photoLabel.text = nil;
    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];
        self.cameraImage.alpha = 1.0f;
        self.photoLabel.alpha = 1.0f;
        self.photoLabel.text = @"Photo 2";
        
    }
}

- (IBAction)photoButton3Pressed:(id)sender {
    self.whichImagePicking = @"3";
    if([self.userObject objectForKey:@"photo3"]){
         [self.mainPhotoButton setImage:self.photoButton3.imageView.image forState:UIControlStateNormal];
        self.cameraImage.alpha = 0.0f;
        self.photoLabel.alpha = 0.0f;
        self.photoLabel.text = nil;
    }else{
        [self.mainPhotoButton setImage:nil forState:UIControlStateNormal];
        self.cameraImage.alpha = 1.0f;
        self.photoLabel.alpha = 1.0f;
        self.photoLabel.text = @"Photo 3";
    }
}

#pragma mark - imagePickerMethods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //A photo was taken or selected
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.image fixOrientation];
        if([self.whichImagePicking isEqualToString:@"1"]){
            [self.mainPhotoButton setImage:self.image forState:UIControlStateNormal];
            [self.photoButton1 setImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo1";
            PFFile *file = [PFFile fileWithName:fileName data:fileData];
            [self.userObject setObject:file forKey:@"photo1"];

        }else if([self.whichImagePicking isEqualToString:@"2"]){
            [self.mainPhotoButton setImage:self.image forState:UIControlStateNormal];
            [self.photoButton2 setImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo2";
            PFFile *file = [PFFile fileWithName:fileName data:fileData];
            [self.userObject setObject:file forKey:@"photo2"];

        }else if([self.whichImagePicking isEqualToString:@"3"]){
            [self.mainPhotoButton setImage:self.image forState:UIControlStateNormal];
            [self.photoButton3 setImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo3";
            PFFile *file = [PFFile fileWithName:fileName data:fileData];
            [self.userObject setObject:file forKey:@"photo3"];

        }
    }
    [self.userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!" message:@"Make sure you're connected to the internet and try choosing your picture again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }else{
            NSLog(@"Saving!");
        }
    }];
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)presentImagePicker{
    self.isImagePickerHappening = @"YES";
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        
    }else{
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    [self presentViewController:self.imagePicker animated:NO completion:nil];

    
}

-(void)presentPhotoLibrary{
    self.isImagePickerHappening = @"YES";
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    
    
    
}

- (IBAction)choosePhoto1:(id)sender {
    
    [self presentPhotoLibrary];
}

-(void)loadProfileImages
{
    self.commentString = [self.userObject objectForKey:@"commentsEnabled"];
    
    if(![self.isImagePickerHappening isEqualToString:@"YES"]){
        
        if([self.userObject objectForKey:@"photo1"]){
            PFFile *imageFile1 = [self.userObject objectForKey:@"photo1"];
            NSURL *imageFileUrl1 = [[NSURL alloc] initWithString:imageFile1.url];
            //NSData *imageData1 = [NSData dataWithContentsOfURL:imageFileUrl1];
            
            [self.mainPhotoButton sd_setImageWithURL:imageFileUrl1 forState:UIControlStateNormal];
             [self.photoButton1 sd_setImageWithURL:imageFileUrl1 forState:UIControlStateNormal];
        }
        
        if([self.userObject objectForKey:@"photo2"]){
            PFFile *imageFile2 = [self.userObject objectForKey:@"photo2"];
            NSURL *imageFileUrl2 = [[NSURL alloc] initWithString:imageFile2.url];
           // NSData *imageData2 = [NSData dataWithContentsOfURL:imageFileUrl2];
            //self.image2 = [UIImage imageWithData:imageData2];
            [self.photoButton2 sd_setImageWithURL:imageFileUrl2 forState:UIControlStateNormal];
        }
        
        if([self.userObject objectForKey:@"photo3"]){
            PFFile *imageFile3 = [self.userObject objectForKey:@"photo3"];
            NSURL *imageFileUrl3 = [[NSURL alloc] initWithString:imageFile3.url];
           // NSData *imageData3 = [NSData dataWithContentsOfURL:imageFileUrl3];
            //self.image3 = [UIImage imageWithData:imageData3];

            [self.photoButton3 sd_setImageWithURL:imageFileUrl3 forState:UIControlStateNormal];
        }
        
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

#pragma mark- Switch Methods

-(void)updateSwitches{
    if([[self.userObject objectForKey:@"commentsEnabled"] isEqualToString:@"YES"]){
        [self.allowCommentSwitch setOn:YES animated:NO];
    }else{
        [self.allowCommentSwitch setOn:NO animated:NO];
    }
    
    if([[self.userObject objectForKey:@"hideRating"] isEqualToString:@"YES"]){
       [self.hideRatingSwitch setOn:YES animated:NO];
    }else{
        [self.hideRatingSwitch setOn:NO animated:NO];
    }
    
}
- (IBAction)allowCommentSwitchPressed:(id)sender {
    
    if(self.allowCommentSwitch.on){
        [self.userObject setObject:@"YES" forKey:@"commentsEnabled"];
    }else{
        [self.userObject setObject:@"NO" forKey:@"commentsEnabled"];
    }
    
        [self.userObject saveInBackground];
    
}

- (IBAction)hideRatingSwitchPressed:(id)sender {
    
    if(self.hideRatingSwitch.on){
        [self.userObject setObject:@"YES" forKey:@"hideRating"];
    }else{
        [self.userObject setObject:@"NO" forKey:@"hideRating"];
    }
    
        [self.userObject saveInBackground];
    
}
- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- logout

-(void)logout{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        ViewController *destViewController = segue.destinationViewController;
        
        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}
@end
