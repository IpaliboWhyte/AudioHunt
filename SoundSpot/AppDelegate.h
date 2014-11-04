//
//  AppDelegate.h
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "RecievedViewController.h"
#import "LandingViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navBarController;
@property (nonatomic, strong) UIViewController *landingViewController;
@property (nonatomic,strong) UINavigationController *nVC;
- (void)createNew;

@end
