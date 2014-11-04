//
//  SignupViewController.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 12/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#define FORMRAISEBY 110
#define TITLE @"Sign up"
#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];   //it hides
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];    // it shows
}

-(void)viewDidAppear:(BOOL)animated
{

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutnavbarTitle];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.config = [[Config alloc] init];
    
    // Set width and heigth of the device screen
    [self.config setScreenHeight: screenRect.size.height];
    [self.config setScreenWidth: screenRect.size.width];
    
    backgroundView *background = [[backgroundView alloc] initWithFrame:CGRectMake(0, 0, [self.config screenWidth], [self.config screenHeight])];
    [self.view addSubview:background];
    
    [self layoutviewForm];
    
    [self layoutRadiopicture];
    
    [self layoutButtons];
    
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
                                          
}

-(void)layoutButtons
{
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([self.config screenWidth]/2)-50, 10, 100, 100)];
    [self.profileImageView setBackgroundColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:0.96]];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    // Get the Layer of any view
    CALayer * pic_layer = [self.profileImageView layer];
    [pic_layer setMasksToBounds:YES];
    [pic_layer setCornerRadius:50.0];
    [self.view addSubview:self.profileImageView];
    
    UIButton *pictureBTN = [[UIButton alloc] initWithFrame:CGRectMake(([self.config screenWidth]/2)-50, 10, 100, 100)];
    [pictureBTN addTarget:self action:@selector(showActionsheet) forControlEvents:UIControlEventTouchUpInside];
    [pictureBTN setTitle:@"\uE807" forState:UIControlStateNormal];
    [pictureBTN.titleLabel setFont:[UIFont fontWithName:@"fontello" size:15.0]];
    [pictureBTN.layer setCornerRadius:50];
    [self.view addSubview:pictureBTN];
    
    signupBTN = [[UIButton alloc] initWithFrame:CGRectMake(0, 410, [self.config screenWidth], 50)];
    [signupBTN addTarget:self action:@selector(createNewuser) forControlEvents:UIControlEventTouchUpInside];
    [signupBTN setBackgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    [signupBTN setTitle:@"Go" forState:UIControlStateNormal];
    [signupBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signupBTN.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15.0]];
    [self.view addSubview:signupBTN];
}

-(void)showActionsheet
{
    // Action shit
    self.actionSheet = [[CVCustomActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Choose from photos",@"Take image"]];
    [self.actionSheet show];
    
}

-(void)takePhoto
{
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePicker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
    imagePicker.showsCameraControls = YES;
    imagePicker.navigationBarHidden = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)choosePhoto
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]){
        imagePicker.navigationBarHidden = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)uploadImage:(NSData *)imageData completion:(void (^)(BOOL success))completionBlock
{
    
    // Convert to JPEG with 50% quality
    NSData* data = UIImageJPEGRepresentation(self.profileImageView.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    //HUD creation here (see example for code)
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [userPhoto.ACL  setPublicReadAccess:true];
            [userPhoto.ACL  setWriteAccess:true forUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"saved");
                    completionBlock(true);
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
    }];
}

-(void)layoutRadiopicture
{
    UIImageView *radioBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self.config screenWidth], 125)];
    UIImage *radioImage = [UIImage imageNamed:@"radiobackground.jpg"];
    [radioBackground setImage:radioImage];
    [self.view addSubview:radioBackground];
}

-(void)layoutviewForm
{
    formView = [[UIView alloc] initWithFrame:CGRectMake(0, 115, [self.config screenWidth], 120)];
    [self.view addSubview:formView];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:0.96]];
    self.userEmail = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, [self.config screenWidth], 40)];
    [self.userEmail setPlaceholder:@"Your email address"];
    [self.userEmail setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [self.userEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.userEmail setAutocorrectionType: UITextAutocorrectionTypeNo];
    [self.userEmail setLeftViewMode:UITextFieldViewModeAlways];
    self.userEmail.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emailicon.png"]];
    [self.userEmail.leftView setFrame:CGRectMake(0, 0, 40, 30)];
    [self.userEmail setTextColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [self.userEmail setBackgroundColor:[UIColor whiteColor]];
    [self.userEmail setReturnKeyType:UIReturnKeyNext];
    [self.userEmail setDelegate:self];
    [formView addSubview:self.userEmail];
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, [self.config screenWidth], 40)];
    [self.userName setPlaceholder:@"Create a username"];
    [self.userName setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [self.userName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.userName.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.userName setLeftViewMode:UITextFieldViewModeAlways];
    self.userName.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profileicon.png"]];
    [self.userName.leftView setFrame:CGRectMake(0, 0, 40, 30)];
    [self.userName setTextColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [self.userName setBackgroundColor:[UIColor whiteColor]];
    [self.userName setReturnKeyType:UIReturnKeyNext];
    [self.userName setDelegate:self];
    [formView addSubview:self.userName];
    
    self.userPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, 90, [self.config screenWidth], 40)];
    [self.userPassword setPlaceholder:@"Create a password"];
    self.userPassword.secureTextEntry = YES;
    [self.userPassword setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [self.userPassword setLeftViewMode:UITextFieldViewModeAlways];
    self.userPassword.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passwordicon.png"]];
    [self.userPassword.leftView setFrame:CGRectMake(0, 0, 40, 30)];
    [self.userPassword setTextColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [self.userPassword setBackgroundColor:[UIColor whiteColor]];
    [self.userPassword setReturnKeyType:UIReturnKeyGo];
    [self.userPassword setDelegate:self];
    [formView addSubview:self.userPassword];
    
}

-(void)raiseViewform
{
// Reposition the form when keyboard shows
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         formView.frame = CGRectMake(0, FORMRAISEBY, [self.config screenWidth], 120);
                     }
                     completion:^(BOOL finished){
                     }];
    [self.view addSubview:formView];
}

-(void)layoutnavbarTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Caviar Dreams" size:18],NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName,
      [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
    
    [self setTitle:TITLE];
}

-(void)createNewuser
{
    PFUser *user = [PFUser user];
    user.username = [self.userName text];
    user.password = [self.userPassword text];
    user.email = [self.userEmail text];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            // Hooray! Let them use the app now.
            if (!myPic){
                
                NSLog(@"no profile pic");
                [self showApp];
                
            }else{
                
                NSLog(@"Profile pic available");
                
                // Convert to JPEG with 50% quality
                NSData* data = UIImageJPEGRepresentation(self.profileImageView.image, 0.5f);
                [self uploadImage:data completion:^(BOOL success) {
                    
                    if (success) {
                        NSLog(@"done !");
                        [self showApp];
                    } else {
                        // Could not log in. Display alert to user.
                    }
                    
                    
                }];
                
            }
            
        } else {
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

-(void)showApp
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationController presentViewController:appDelegate.navBarController animated:YES completion:nil];
}

// ************************ Delegate Methods ************************

-(void)keyboardWasShown:(NSNotification *)notification
{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self raiseViewform];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.inputAccessoryView = signupBTN;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userEmail) {
        [textField resignFirstResponder];
        [self.userName becomeFirstResponder];
    } else if (textField == self.userName) {
        [textField resignFirstResponder];
        [self.userPassword becomeFirstResponder];
    }
    return YES;
}

-(void)actionSheetButtonClicked:(CVCustomActionSheet *)actionSheet withButtonIndex:(NSNumber *)buttonIndex withButtonTitle:(NSString *)buttonTitle
{
    if ([buttonTitle isEqualToString:@"Take image"]) {
        [self takePhoto];
    }else if (@"Choose from photo"){
        [self choosePhoto];
    }
}

-(void)actionSheetCancelled:(CVCustomActionSheet *)actionSheet
{
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    myPic = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.profileImageView.image = myPic;
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];//Or call YES if you want the nice dismissal animation
    
    NSLog(@"Canceled");
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}

@end
