//
//  FriendsViewController.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 16/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"here again");
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [self setTitle:@"Your friends"];
    
    [super viewDidLoad];
    
    [self layoutButtons];
    
    [self layoutLabels];
    
    [self layOutTableView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

-(void)layOutTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 450)];
    [self.myTableView setDelegate:self];
    [self.myTableView setDataSource:self];
    [self.view addSubview: self.myTableView];
    
    [self.myTableView setSeparatorColor:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:0.7]];
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {  // Safety check for below iOS 7
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    PFUser *user = [PFUser currentUser];
    PFRelation *friends = [user relationForKey:@"Friends"];
    PFQuery *query = [friends query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.friends = results;
        [self.myTableView reloadData];
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.friends count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UserSearchTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (customCell == nil)
    {
        customCell = [[UserSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        
        customCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
        
        PFUser *user = (PFUser *)[self.friends objectAtIndex:[indexPath row]];
        
        [query whereKey:@"user" equalTo:user];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            
            PFFile *theImage = [object objectForKey:@"imageFile"];
            
            NSData *imageData = [theImage getData];
            
            UIImage *profileImage = [UIImage imageWithData:imageData];
            
            if (profileImage == nil) {
                
            } else {
                
                [customCell setProfilePicturewith:user.username :profileImage];
                
            }
            
        }];
        
        UIButton *removeFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [removeFriendBtn addTarget:self action:@selector(removeFriend:) forControlEvents:UIControlEventTouchUpInside];
        
        [removeFriendBtn setImage:[UIImage imageNamed:@"removeIcon2.png"] forState:UIControlStateNormal];
        
        [removeFriendBtn setTag:indexPath.row];
        
        customCell.accessoryView = removeFriendBtn;
        
    }
    
    return customCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)removeFriend:(UIButton*)sender
{
    
    PFUser *clickeduser = (PFUser *)[self.friends objectAtIndex:[sender tag]];
    
    PFUser *user = [PFUser currentUser];
    
    PFRelation *friends = [user relationForKey:@"Friends"];
    
    [friends removeObject:clickeduser];
    
    [user saveInBackground];

    PFQuery *query = [friends query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        self.friends = results;
        [self viewDidLoad];
    }];
    
}

-(void)refreshView:(NSNotification *)notification
{
    
    [self viewDidLoad];
    
}

-(void)layoutButtons
{
    
    self.addfriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.addfriendBtn addTarget:self action:@selector(openSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.addfriendBtn setBackgroundColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [self.addfriendBtn setTitle:@"\uE80C   Add friends" forState:UIControlStateNormal];
    [self.addfriendBtn setTitleColor:[UIColor colorWithRed:0.741 green:0.765 blue:0.78 alpha:1] forState:UIControlStateHighlighted];
    [self.addfriendBtn.titleLabel setText:@"hello"];
    [self.addfriendBtn.titleLabel setFont:[UIFont fontWithName:@"fontello" size:15]];
    [self.view addSubview:self.addfriendBtn];

}

-(void)openSearch
{
    
    self.usersController = [[SearchUsersViewController alloc] init];
    [self.navigationController pushViewController:self.usersController animated:YES];
    [self.navigationController hidesBottomBarWhenPushed];
    
}

-(void)layoutLabels
{
    
    UILabel *noFriends = [[UILabel alloc] initWithFrame:CGRectMake(320/2-50, 230, 160, 40)];
    [noFriends setTextColor:[UIColor grayColor]];
    [noFriends setText:@"No Friends Yet"];
    [noFriends setFont:[UIFont fontWithName:@"" size:25]];
    [self.view addSubview:noFriends];
    
}

-(void)ShowsearchView
{
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.addfriendBtn.frame;
        frame.origin.x = self.addfriendBtn.frame.origin.x;
        frame.origin.y =   0;
        self.addfriendBtn.frame = frame;
    } completion:^(BOOL finished){
    }];
    
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.myTableView.frame;
        frame.origin.x = self.myTableView.frame.origin.x;
        frame.origin.y =  50;
        self.myTableView.frame = frame;
    } completion:^(BOOL finished){
    }];
}

-(void)hidesearchView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.addfriendBtn.frame;
        frame.origin.x = self.addfriendBtn.frame.origin.x;
        frame.origin.y =  -50;
        self.addfriendBtn.frame = frame;
    } completion:^(BOOL finished){
    }];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.myTableView.frame;
        frame.origin.x = self.myTableView.frame.origin.x;
        frame.origin.y =  0;
        self.myTableView.frame = frame;
    } completion:^(BOOL finished){
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        [self ShowsearchView];
        
    }else{
        [self hidesearchView];
    }
}

@end
