//
//  ProfileViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
            });

        }
        
    }];

    

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
    self.whichImagePicking = @"1";
    [self presentImagePicker];
}


- (IBAction)photoButton2Pressed:(id)sender {
    self.whichImagePicking = @"2";
    [self presentImagePicker];
}

- (IBAction)photoButton3Pressed:(id)sender {
    self.whichImagePicking = @"3";
    [self presentImagePicker];
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
            [self.mainPhotoButton setBackgroundImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo1";
            PFFile *file = [PFFile fileWithName:fileName data:fileData];
            [self.userObject setObject:file forKey:@"photo1"];

        }else if([self.whichImagePicking isEqualToString:@"2"]){
            [self.photoButton2 setBackgroundImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo2";
            PFFile *file = [PFFile fileWithName:fileName data:fileData];
            [self.userObject setObject:file forKey:@"photo2"];

        }else if([self.whichImagePicking isEqualToString:@"3"]){
            [self.photoButton3 setBackgroundImage:self.image forState:UIControlStateNormal];
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
    self.whichImagePicking = @"1";
    [self presentPhotoLibrary];
}

- (IBAction)choosePhoto2:(id)sender {
     self.whichImagePicking = @"2";
     [self presentPhotoLibrary];
}

- (IBAction)choosePhoto3:(id)sender {
     self.whichImagePicking = @"3";
     [self presentPhotoLibrary];
}

- (IBAction)enableCommentsPressed:(id)sender {
    
    if([self.commentString isEqualToString:@"YES"]){
        self.commentString = @"NO";
    }else{
        self.commentString = @"YES";
    }
    
    [self.userObject setObject:self.commentString forKey:@"commentsEnabled"];
    
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
@end
