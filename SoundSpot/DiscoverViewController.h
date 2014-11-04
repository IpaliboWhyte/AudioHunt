//
//  DiscoverViewController.h
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "backgroundView.h"
#import "searchView.h"
#import "SendToViewController.h"
#import "PostTableViewCell.h"
#import "SCUI.h"
#import "SoundcloudSearchTableViewController.h"

@interface DiscoverViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CustomCellDelegate>{
    CGRect screenRect;
    int selectedNumber;
}

@property SoundcloudSearchTableViewController *searchTableview;

@property PostTableViewCell *customCell;
@property SendToViewController *sendToViewController;
@property UITableView *tableview;
@property UITextField *mySearch;
@property searchView *mysearchView;
@property UIView *toggle;

-(void)didSendButtonTap:(id)sender;

@end
