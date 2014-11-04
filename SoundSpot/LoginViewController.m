//
//  LoginViewController.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "LoginViewController.h"
#import "backgroundView.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface LoginViewController ()<UIApplicationDelegate>

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];   //it hides
}

-(void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // heavy lifting here
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userName becomeFirstResponder];
        });
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];    // it shows
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [self layoutRadiopicture];
    [self layoutviewForm];
    [self layoutButtons];
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
    UIView *formView = [[UIView alloc] initWithFrame:CGRectMake(0, 115, [self.config screenWidth], 80)];
    [self.view addSubview:formView];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:0.96]];

    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, [self.config screenWidth], 40)];
    [self.userName setPlaceholder:@"Enter your username"];
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
    
    self.userPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, [self.config screenWidth], 40)];
    [self.userPassword setPlaceholder:@"Enter your password"];
    self.userPassword.secureTextEntry = YES;
    [self.userPassword setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [self.userPassword setLeftViewMode:UITextFieldViewModeAlways];
    self.userPassword.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passwordicon.png"]];
    [self.userPassword.leftView setFrame:CGRectMake(0, 0, 40, 30)];
    [self.userPassword setTextColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [self.userPassword setBackgroundColor:[UIColor whiteColor]];
    [self.userPassword setReturnKeyType:UIReturnKeyGo];
    [formView addSubview:self.userPassword];
    
}

-(void)userLogin
{
    [PFUser logInWithUsernameInBackground:[self.userName text] password:[self.userPassword text]
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self showApp];
                                        } else {
                                            
                                        }
                                    }];
}

-(void)showApp
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self.navigationController presentViewController:appDelegate.navBarController animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userName) {
        [textField resignFirstResponder];
        [self.userPassword becomeFirstResponder];
    } else if (textField == self.userPassword) {
        // here you can define what happens
        // when user presses return on the email field
    }
    return YES;
}

-(void)layoutButtons
{
    UIButton *loginBTN = [[UIButton alloc] initWithFrame:CGRectMake(0, 205, [self.config screenWidth], 50)];
    [loginBTN addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBTN setBackgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    [loginBTN setTitle:@"Log in" forState:UIControlStateNormal];
    [loginBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBTN.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15.0]];
    [self.view addSubview:loginBTN];
    
    UIButton *forgotpasswordBTN = [[UIButton alloc] initWithFrame:CGRectMake([self.config screenWidth]/2-100, 265, 200, 20)];
    [forgotpasswordBTN setTitle:@"Forgot your password ?" forState:UIControlStateNormal];
    [forgotpasswordBTN.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:10.0]];
    [self.view addSubview:forgotpasswordBTN];
}

-(void)layoutnavbarTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Caviar Dreams" size:18],NSFontAttributeName,
    [UIColor whiteColor],NSForegroundColorAttributeName,
    [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
    
    [self setTitle:@"Log in"];
}

@end
