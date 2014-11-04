//
//  FriendsViewController.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 16/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchUsersViewController.h"
#import <Parse/Parse.h>
#import "UserSearchTableViewCell.h"

@interface FriendsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property UISegmentedControl *friendsSegmentedControl;
@property SearchUsersViewController *usersController;
@property UITableView *myTableView;
@property UserSearchTableViewCell *customCell;
@property NSArray *friends;
@property UIButton *addfriendBtn;

@end