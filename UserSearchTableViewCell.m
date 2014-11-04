//
//  UserSearchTableViewCell.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 12/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "UserSearchTableViewCell.h"

@implementation UserSearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setProfilePicturewith:(NSString *)name :(UIImage *)profilePicture{
    
    UILabel *profileName = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 300, 30)];
    [profileName setTextColor:[UIColor colorWithRed:0.133 green:0.192 blue:0.247 alpha:0.8]];
    [profileName setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [profileName setText:name];
    [self.contentView addSubview:profileName];
    
    UIImageView * profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
    // Get the Layer of any view
    CALayer * profilepicLayer = [profilePic layer];
    profilepicLayer.contentsGravity = kCAGravityResizeAspectFill;
    [profilepicLayer setMasksToBounds:YES];
    [profilepicLayer setCornerRadius:25];
    [profilePic setImage:profilePicture];
    [self.contentView addSubview:profilePic];
    
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    // Check for the checkmark
    if (accessoryType == UITableViewCellAccessoryCheckmark)
    {
        
        UIImageView *addiconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        
        self.accessoryView = addiconView;
    }
    // We don't have to modify the accessory
    else
    {
        [super setAccessoryType:accessoryType];
    }
}

@end
