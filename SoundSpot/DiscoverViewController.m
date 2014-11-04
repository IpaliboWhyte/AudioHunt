//
//  DiscoverViewController.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "DiscoverViewController.h"
#import <parse/Parse.h>

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
     screenRect = [[UIScreen mainScreen] bounds];
    [self layoutnavbarTitle];
    [self layoutTableview];
    [self layoutSearchBar];
    [self.mySearch setDelegate:self];
    [self.view addSubview:self.mysearchView];
    selectedNumber = -1;
    
}

-(void)doDoubleTap{
    NSLog(@"double tapped");
}

-(void)layoutnavbarTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Caviar Dreams" size:18],NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName,
      [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
    self.navigationItem.title=@"Discover";
}

-(void)layoutSearchBar
{
    
    screenRect = [[UIScreen mainScreen] bounds];
    self.mysearchView = [[searchView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.mysearchView layoutwithBackground];
    
    self.mySearch = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width, 50)];
    [self.mySearch setFont:[UIFont fontWithName:@"bariol" size:20]];
    [self.mySearch setPlaceholder:@"Search"];
    [self.mySearch setTextColor:[UIColor whiteColor]];
    [self.mySearch setValue:[UIColor whiteColor]
    forKeyPath:@"_placeholderLabel.textColor"];
    [self.mySearch setReturnKeyType:UIReturnKeyGo];
    [self.mysearchView addSubview:self.mySearch];
    self.mySearch.autocorrectionType = UITextAutocorrectionTypeNo;
    
}

-(void)layoutTableview
{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenRect.size.width, screenRect.size.height)];
    [self.tableview setSeparatorColor:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:0.7]];
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    [self.view addSubview:self.tableview];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.mySearch resignFirstResponder];
    
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        
        [self ShowsearchView];

    } else {
        
        [self hidesearchView];
        
    }
    
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
        CGRect frame = self.tableview.frame;
        frame.origin.x = self.tableview.frame.origin.x;
        frame.origin.y =  0;
        self.tableview.frame = frame;
    } completion:^(BOOL finished){
    }];

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
        CGRect frame = self.tableview.frame;
        frame.origin.x = self.tableview.frame.origin.x;
        frame.origin.y =  50;
        self.tableview.frame = frame;
    } completion:^(BOOL finished){
    }];
}

- (void)didSendButtonTap:(id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
    }
    
    self.sendToViewController = [[SendToViewController alloc] init];
    [self.navigationController pushViewController:self.sendToViewController animated:YES];
     
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.searchTableview = [[SoundcloudSearchTableViewController alloc] init];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransition;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:self.searchTableview animated:NO];
    
    [self.mySearch resignFirstResponder];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row] == selectedNumber) {
        return  180;
    }
    else return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    PostTableViewCell *customCell = [[PostTableViewCell alloc] init];
    
    customCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (customCell == nil)
    {
        customCell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
        [customCell setSoundcloudLabel];
        
        [customCell setUserInfo:@"Tosman321" :[UIImage imageNamed:@"placeholder.jpg"]];
        
        [customCell setPostInfo:@"Guys check this out!" :@"Flygerian - Skepta feat Donjazzy" :[UIImage imageNamed:@"wizkid.jpg"]];
        
        [customCell setHiddenButtons];
        
        [customCell setDelegate:self];
        
        if ([indexPath section]==0) {
            
            
        }
        
        
    }

    return customCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (selectedNumber == [indexPath row]) {
        selectedNumber =-1;
    }else{
        int row = (int)[indexPath row];
        selectedNumber = row;
    }
    [tableView beginUpdates];
    [tableView endUpdates];
}

@end
