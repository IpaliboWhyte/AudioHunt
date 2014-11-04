//
//  LoginViewController.h
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "RecievedViewController.h"
#import "LandingViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property Config *config;
@property UITextField *userName;
@property UITextField *userPassword;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navBarController;

@end
