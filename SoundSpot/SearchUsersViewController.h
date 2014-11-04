//
//  SearchUsersViewController.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 22/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchView.h"
#import "UserSearchTableViewCell.h"

@interface SearchUsersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property searchView *mysearchView;
@property UITextField *myTextField;
@property UITableView *mytableView;
@property NSArray *users;
@end
