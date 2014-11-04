//
//  ProfileViewController.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//
#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self layoutLogOutbtn];
    [self layoutnavbarTitle];
    [self layoutprofileheader];
    [self loadProfileButtons];

    UIBarButtonItem *backBtn =[[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleDone target:self action:@selector(showActionsheet)];
    backBtn.title = @"\uE800";
    [backBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"fontello" size:25], NSFontAttributeName,
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=backBtn;

}

-(void)showActionsheet
{
    // Action shit
    self.actionSheet = [[CVCustomActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Log out",@"Account",@"Edit profile"]];
    [self.actionSheet show];
    
}

-(void)loadProfileButtons
{
    UIButton *Friends = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 280, 50)];
    [Friends.layer setCornerRadius:25];
    [Friends setBackgroundColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:1]];
    [Friends addTarget:self action:@selector(showFriends) forControlEvents:UIControlEventTouchUpInside];
    [Friends setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Friends.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [Friends setTitle:@"Friends" forState:UIControlStateNormal];
    [self.view addSubview:Friends];
    
    UIButton *favs = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 280, 50)];
    [favs.layer setCornerRadius:25];
    [favs setBackgroundColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [favs setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [favs.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [favs setTitle:@"Favs" forState:UIControlStateNormal];
    [self.view addSubview:favs];
    
    UIButton *posts = [[UIButton alloc] initWithFrame:CGRectMake(20, 370, 280, 50)];
    [posts.layer setCornerRadius:25];
    [posts setBackgroundColor:[UIColor colorWithRed:0.584 green:0.647 blue:0.651 alpha:1]];
    [posts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [posts.titleLabel setFont:[UIFont fontWithName:@"Caviar Dreams" size:15]];
    [posts setTitle:@"Posts" forState:UIControlStateNormal];
    [self.view addSubview:posts];
}

-(void)showFriends
{
    self.friendsViewController = [[FriendsViewController alloc] init];
    [self.navigationController pushViewController:self.friendsViewController animated:YES];
}

-(void)layoutprofileheader
{

    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        //Cargo la imagen de la celda
        PFFile *theImage = [object objectForKey:@"imageFile"];
        NSData *imageData = [theImage getData];
        UIImage *profileImage = [UIImage imageWithData:imageData];
        
        if (profileImage == nil) {
        } else {
            [self.profileview setProfilePicture:profileImage];
        }
        
    }];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    PFUser *currentUser = [PFUser currentUser];
    self.profileview = [[ProfileView alloc] init];
    [self.profileview displayProfilepicView];
    [self.profileview displayMostPlayedSong:[currentUser username]];
    [self.profileview displayBestSong];
    //[self.profileview displayAboutMe];
    [self.view addSubview:self.profileview];
    
}

-(void)layoutnavbarTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Caviar Dreams" size:18],NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName,
      [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
    self.navigationItem.title=[[PFUser currentUser] username];
}

-(void)layoutLogOutbtn
{
    UIButton *mybtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    [mybtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [mybtn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:mybtn];
}

-(void)logout
{
    
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    [self hideApp];
    
    #pragma unused(currentUser)

}

-(void)hideApp
{
    
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate createNew];
}

- (void)actionSheetButtonClicked:(CVCustomActionSheet *)actionSheet withButtonIndex:(NSNumber *)buttonIndex withButtonTitle:(NSString *)buttonTite{
    
    if ([buttonTite isEqual:@"Log out"]) {
        [self logout];
    }
    
}

- (void)actionSheetCancelled:(CVCustomActionSheet *)actionSheet{
    
}

@end
