//
//  OptionsViewController.m
//  Rate Me
//
//  Created by Justin Lennox on 12/26/14.
//  Copyright (c) 2014 Justin Lennox. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

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
    
    self.noThanksButton.alpha = 0.0f;
    self.darkBackground.alpha = 0.0f;
    self.getRatedLabel.alpha = 0.0f;
    self.getRatedCaptionLabel.alpha = 0.0f;
    self.chooseFromPhotosButton.alpha = 0.0f;
    self.doneButton.alpha = 0.0f;
    self.mainPhotoButton.alpha = 0.0f;
    
    PFUser *currentUser = [PFUser currentUser];
    if(!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"]){
        self.noThanksButton.alpha = 1.0f;
        self.darkBackground.alpha = 0.7f;
        self.getRatedLabel.alpha = 1.0f;
        self.getRatedCaptionLabel.alpha = 1.0f;
        self.chooseFromPhotosButton.alpha = 1.0f;
        self.mainPhotoButton.alpha = 1.0f;
        self.myRatingButton.enabled = NO;
        self.rateOthersButton.enabled = NO;
        self.top10Button.enabled = NO;
    }
    
    if([self.imageJustPicked isEqualToString:@"YES"]){
        self.doneButton.alpha = 1.0f;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark- initial photo prompt buttons
- (IBAction)noThanksButtonPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.mainPhotoButton.alpha = 0.0f;
    self.noThanksButton.alpha = 0.0f;
    self.darkBackground.alpha = 0.0f;
    self.getRatedLabel.alpha = 0.0f;
    self.getRatedCaptionLabel.alpha = 0.0f;
    self.chooseFromPhotosButton.alpha = 0.0f;
    self.myRatingButton.enabled = YES;
    self.rateOthersButton.enabled = YES;
    self.top10Button.enabled = YES;
}
- (IBAction)chooseFromPhotosPressed:(id)sender {
    [self presentPhotoLibrary];
}

- (IBAction)mainPhotoButtonPressed:(id)sender {
    
        [self presentImagePicker];
}
#pragma mark - imagePickerMethods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageJustPicked = @"YES";
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //A photo was taken or selected
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.image fixOrientation];
            [self.mainPhotoButton setBackgroundImage:self.image forState:UIControlStateNormal];
            NSData *fileData = UIImageJPEGRepresentation(self.image, 1.0);
            NSString *fileName = @"photo1";
            self.file = [PFFile fileWithName:fileName data:fileData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)presentImagePicker{
    
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


- (IBAction)doneButtonPressed:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserObjects"];
    [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"It looks like we couldn't update your current games! Make sure you're connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        else {
            self.userObject = [objects objectAtIndex:0];
            [self.userObject setObject:self.file forKey:@"photo1"];
            [self.userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An error occurred!" message:@"Make sure you're connected to the internet and try choosing your picture again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertView show];
                }else{
                    NSLog(@"Saving!");
                }
            }];
            //We found objects!
            
        }
    }];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.doneButton.alpha = 0.0f;
    self.mainPhotoButton.alpha = 0.0f;
    self.noThanksButton.alpha = 0.0f;
    self.darkBackground.alpha = 0.0f;
    self.getRatedLabel.alpha = 0.0f;
    self.getRatedCaptionLabel.alpha = 0.0f;
    self.chooseFromPhotosButton.alpha = 0.0f;
    self.myRatingButton.enabled = YES;
    self.rateOthersButton.enabled = YES;
    self.top10Button.enabled = YES;


}
@end
