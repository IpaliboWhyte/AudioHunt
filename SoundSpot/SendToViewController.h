//
//  SendToViewController.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 22/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchUsersViewController.h"
#import "UserSearchTableViewCell.h"
#import <Parse/Parse.h>

@interface SendToViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property SearchUsersViewController *friendsViewController;

@property UITableView *tableView;

@property NSArray *friends;

@property NSMutableArray *checkedfriends;

@end
