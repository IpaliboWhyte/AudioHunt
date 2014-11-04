//
//  SendToViewController.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 22/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "SendToViewController.h"

@interface SendToViewController ()

@end

@implementation SendToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
     self.navigationItem.title=@"Send to";
    
    [self getAllFriends];
    self.checkedfriends = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
}

-(void) getAllFriends{
    PFUser *user = [PFUser currentUser];
    PFRelation *friends = [user relationForKey:@"Friends"];
    PFQuery *query = [friends query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        self.friends = results;
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"you have %lu, friends", (unsigned long)[self.friends count]);

    return [self.friends count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"MyIdentifier";

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
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
        
        /*
        UIButton *check = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [check setBackgroundColor:[UIColor greenColor]];
        
        [check addTarget:self action:@selector(checkfriend) forControlEvents:UIControlEventTouchUpInside];
        
        [check setTag:indexPath.row];
        
        //[check setImage:[UIImage imageNamed:@"removeIcon2.png"] forState:UIControlStateNormal];
        */
    }
    
    return customCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

        if (![[self.checkedfriends objectAtIndex:0]isEqual:self.friends]) {
            
            [self.checkedfriends addObject:[self.friends objectAtIndex:[indexPath row]]];
            
        }
    
    NSLog(@"check friends is, %lu ", (unsigned long)[self.checkedfriends count]);
    
}

-(void)checkfriend{
    
    
}

@end
