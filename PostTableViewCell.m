//
//  PostTableViewCell.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 09/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.visibleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
        [self.contentView addSubview: self.visibleView];
        
        self.hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, self.visibleView.frame.size.height, 320, 50)];
        [self.contentView addSubview: self.hiddenView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;

        [self setClipsToBounds:YES];
        
    }
    return self;
}

-(void)setSoundcloudLabel{
    
    UILabel *soundCloudLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 10, 30, 30)];
    [soundCloudLabel setText:@"\uE803"];
    [soundCloudLabel setTextColor:[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1]];
    [soundCloudLabel setFont:[UIFont fontWithName:@"fontello" size:20]];
    [self.visibleView addSubview:soundCloudLabel];
    
}

-(void)setHiddenButtons{

    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320/2-0.25, 50)];
    [playButton setBackgroundColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:0.9]];
    [playButton setTitle:@"\uE808" forState:UIControlStateNormal];
    [playButton.titleLabel setFont:[UIFont fontWithName:@"fontello" size:17]];
    [self.hiddenView addSubview: playButton];
    
    UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(320/2+0.25, 0, 320/2, 50)];
    [share addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [share setBackgroundColor:[UIColor colorWithRed:0.584 green:0.647 blue:0.651 alpha:0.9]];
    [share setTitle:@"\uE809" forState:UIControlStateNormal];
    [share.titleLabel setFont:[UIFont fontWithName:@"fontello" size:17]];
    [self.hiddenView addSubview: share];
    
}

-(void)setUserInfo:(NSString *)userName :(UIImage *)userPic{
    UILabel *userName_ofPost = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 230, 30)];
    [userName_ofPost setText:userName];
    [userName_ofPost setTextColor:[UIColor colorWithRed:0.133 green:0.192 blue:0.247 alpha:0.8]];
    [userName_ofPost setFont:[UIFont fontWithName:@"bariol" size:15]];
    [self.visibleView addSubview:userName_ofPost];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
    [imageview setImage:userPic];
    [imageview setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.2]];
    CALayer * l = [imageview layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:15];
    [self.visibleView addSubview:imageview];
    
}
-(void)setPostInfo:(NSString *)postMessage :(NSString *)post_songTitle :(UIImage *)post_songArtwork{
    
    UILabel *commentPost = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 300, 30)];
    [commentPost setText:postMessage];
    [commentPost setTextColor:[UIColor colorWithRed:0.133 green:0.192 blue:0.247 alpha:0.5]];
    [commentPost setFont:[UIFont fontWithName:@"bariol" size:15]];
    [self.visibleView addSubview:commentPost];
    
    UILabel *songPost = [[UILabel alloc] initWithFrame:CGRectMake(70, 75, 300, 30)];
    [songPost setText:post_songTitle];
    [songPost setTextColor:[UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1]];
    [songPost setFont:[UIFont fontWithName:@"bariol" size:15]];
    [self.visibleView addSubview:songPost];
    
}

-(void)checkButtonTapped:(id)sender{
    [self.delegate didSendButtonTap:sender];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
