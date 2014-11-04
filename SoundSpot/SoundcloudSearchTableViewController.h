//
//  SoundcloudSearchTableViewController.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 15/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchView.h"
#import "SendToViewController.h"
#import "SCRequest.h"
#import "SCSoundCloud.h"
#import "SongItemCustomCell.h"
#import "SendToViewController.h"


@interface SoundcloudSearchTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationBarDelegate, SongCustomCellDelegate>
{
    int selectedCellid;
}

@property UITextField *customTextField;
@property searchView *customSearchView;
@property NSArray *searchResult;

@end
