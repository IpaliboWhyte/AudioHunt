//
//  SearchUsersViewController.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 22/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "SearchUsersViewController.h"
#import "searchView.h"
#import <parse/Parse.h>

@interface SearchUsersViewController ()

@end

@implementation SearchUsersViewController

- (void)viewDidLoad
{
    [self setTitle:@"Add a friend"];
    [super viewDidLoad];
    [self layoutSearchBar];
    [self layoutTable];

}

-(void)popBacktoRootView{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)layoutTable
{
    self.mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mysearchView.frame.size.height, 320, 400)];
    //self.mytableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.mytableView setSeparatorColor:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:0.7]];
    if ([self.mytableView respondsToSelector:@selector(setSeparatorInset:)]) {  // Safety check for below iOS 7
        [self.mytableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self.mytableView setDelegate:self];
    [self.mytableView setDataSource:self];
    [self.view addSubview:self.mytableView];
}

-(void)layoutSearchBar
{
    self.mysearchView = [[searchView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.mysearchView layoutwithBackground];
    self.myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 320, 50)];
    [self.myTextField setDelegate:self];
    [self.myTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.myTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.myTextField setReturnKeyType:UIReturnKeySearch];
    [self.myTextField setPlaceholder:@"Search"];
    [self.myTextField setTextColor:[UIColor whiteColor]];
    [self.myTextField setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.mysearchView addSubview:self.myTextField];
    [self.view addSubview:self.mysearchView];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    PFQuery *query = [PFUser query];
        [query whereKey:@"username" containsString:self.myTextField.text];
        self.users = [query findObjects];
        [self.mytableView reloadData];
    
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    //UserSearchTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    UIButton *addFriendBtn;
    
    if (cell == nil)
    {
        cell = [[UserSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
        PFUser *user = (PFUser *)[self.users objectAtIndex:[indexPath row]];
        [query whereKey:@"user" equalTo:user];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            
            //Cargo la imagen de la celda
            PFFile *theImage = [object objectForKey:@"imageFile"];
            NSData *imageData = [theImage getData];
            UIImage *profileImage = [UIImage imageWithData:imageData];
            
            if (profileImage == nil) {
            } else {
                //[customCell setProfilePicturewith:user.username :profileImage];
                cell.textLabel.text = user.username;
            }
            
        }];
        
        addFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        
        [addFriendBtn addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
        
        [addFriendBtn setTag:[indexPath row]];
        
        [addFriendBtn setImage:[UIImage imageNamed:@"addicondisabledblue.png"] forState:UIControlStateNormal];
        
        [addFriendBtn setImage:[UIImage imageNamed:@"alreadyfriends.png"] forState:UIControlStateSelected];
        
        [addFriendBtn setTag:indexPath.row];
        
        cell.accessoryView = addFriendBtn;
    }
    
    return cell;
    
}

-(void)addFriend:(UIButton *)sender{
    
    [sender setSelected:YES];
    
    PFUser *clickeduser = (PFUser *)[self.users objectAtIndex:[sender tag]];
    
    PFUser *user = [PFUser currentUser];
    PFRelation *friends = [user relationForKey:@"Friends"];
    [friends addObject:clickeduser];
    [user saveInBackground];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.myTextField resignFirstResponder];
    
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        [self ShowsearchView];
        
    }else{
        [self hidesearchView];
    }
}

-(void)ShowsearchView
{
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.mysearchView.frame;
        frame.origin.x = self.mysearchView.frame.origin.x;
        frame.origin.y =   0;
        self.mysearchView.frame = frame;
    } completion:^(BOOL finished){
    }];
    
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.mytableView.frame;
        frame.origin.x = self.mytableView.frame.origin.x;
        frame.origin.y =  50;
        self.mytableView.frame = frame;
    } completion:^(BOOL finished){
    }];
}

-(void)hidesearchView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.mysearchView.frame;
        frame.origin.x = self.mysearchView.frame.origin.x;
        frame.origin.y =  -50;
        self.mysearchView.frame = frame;
    } completion:^(BOOL finished){
    }];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.mytableView.frame;
        frame.origin.x = self.mytableView.frame.origin.x;
        frame.origin.y =  0;
        self.mytableView.frame = frame;
    } completion:^(BOOL finished){
    }];
    
}


@end
