//
//  SignupViewController.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 12/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"
#import "backgroundView.h"
#import "LandingViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Config.h"
#import "CVCustomActionSheet.h"
#import "MBProgressHUD.h"

@interface SignupViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate, CVCustomActionSheetDelegate>{
    UIView *formView;
    UIButton *signupBTN;
    
    UIImagePickerController *imagePicker;
    UIImage *myPic;
    
}

@property Config *config;
@property UITextField *userEmail;
@property UITextField *userName;
@property UITextField *userPassword;
@property UIImageView *profileImageView;
@property CVCustomActionSheet *actionSheet;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end
