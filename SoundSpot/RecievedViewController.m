//
//  RecievedViewController.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "RecievedViewController.h"

@interface RecievedViewController ()

@end

@implementation RecievedViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutnavbarTitle];
}

-(void)layoutnavbarTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Caviar Dreams" size:18],NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName,
      [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
    
    self.navigationItem.title=@"Recieved";
}
@end
