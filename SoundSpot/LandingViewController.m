//
//  LandingViewController.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#define APPNAME @"AudioHunt"

#import "LandingViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"

#define LOGIN_TITLE @"Log in"

@interface LandingViewController ()

@end

@implementation LandingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    self.navigationController.navigationBarHidden = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.config = [[Config alloc] init];
    [self.config setScreenHeight: screenRect.size.height];
    [self.config setScreenWidth: screenRect.size.width];
    
    backgroundView *background = [[backgroundView alloc] initWithFrame:CGRectMake(0, 0,[self.config screenWidth],[self.config screenHeight])];
    
    [self.view addSubview:background];
    [self layoutTexts];
    [self layoutButtons];
}

- (void)layoutButtons
{
    UIButton *loginBTN = [[UIButton alloc] initWithFrame:CGRectMake(20, [self.config screenHeight]-150, 280, 50)];
    [loginBTN addTarget:self action:@selector(procedLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBTN setBackgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1]];
    [loginBTN setTitle:@"Log in" forState:UIControlStateNormal];
    [loginBTN.layer setCornerRadius:25];
    [loginBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBTN setTitleColor:[UIColor colorWithRed:0.741 green:0.765 blue:0.78 alpha:1] forState:UIControlStateHighlighted];

    [loginBTN.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15.0]];
    [self.view addSubview:loginBTN];
    
    UIButton *signupBTN = [[UIButton alloc] initWithFrame:CGRectMake(20, [self.config screenHeight]-95, 280, 50)];
    [signupBTN addTarget:self action:@selector(procedSignup) forControlEvents:UIControlEventTouchUpInside];
    [signupBTN setBackgroundColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [signupBTN setTitle:@"Register" forState:UIControlStateNormal];
    [signupBTN.layer setCornerRadius:25];
    [signupBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signupBTN setTitleColor:[UIColor colorWithRed:0.741 green:0.765 blue:0.78 alpha:1] forState:UIControlStateHighlighted];
    [signupBTN.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15.0]];
    [self.view addSubview:signupBTN];
}

- (void)layoutTexts
{
    UILabel *logoText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 50)];
    self.logoText = APPNAME;
    [logoText setText:self.logoText];
    [logoText setTextColor:[UIColor whiteColor]];
    [logoText setFont:[UIFont fontWithName:@"another shabby" size:35.0]];
    [logoText setCenter:CGPointMake(self.view.frame.size.width / 2, 130)];
    [self.view addSubview:logoText];
    
    UILabel *mottoText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 10)];
    [mottoText setText:@"Find,share and discover music with friends"];
    [mottoText setTextColor:[UIColor whiteColor]];
    [mottoText setFont:[UIFont fontWithName:@"Caviar Dreams" size:10.0]];
    [mottoText setCenter:CGPointMake(self.view.frame.size.width / 2,[self.config screenHeight]-30)];
    [self.view addSubview:mottoText];
    
}

- (void)procedLogin
{
    LoginViewController *loginview = [[LoginViewController alloc] init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:loginview animated:NO];
}

- (void)procedSignup
{
    SignupViewController *signupview = [[SignupViewController alloc] init];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:signupview animated:NO];
}

@end
