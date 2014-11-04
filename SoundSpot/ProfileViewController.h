//
//  ProfileViewController.h
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileView.h"
#import "CVCustomActionSheet.h"
#import "FriendsViewController.h"
#import "LandingViewController.h"
#import "AppDelegate.h"
#import <parse/Parse.h>

@interface ProfileViewController : UIViewController<CVCustomActionSheetDelegate>
@property CVCustomActionSheet *actionSheet;
@property ProfileView *profileview;
@property FriendsViewController *friendsViewController;
@property LandingViewController *landingViewController;
@property UINavigationController *nVC;
@end
