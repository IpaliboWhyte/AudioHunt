//
//  ProfileView.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 14/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        screenRect = [[UIScreen mainScreen] bounds];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backgroundView];
        
    }
    return self;
}

-(void)displayProfilepicView
{
    
    self.background = [[UIImageView alloc] init];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.background setFrame:CGRectMake(0, 0, 320, 500)];
    [self.background setBackgroundColor:[UIColor grayColor]];
    [self addSubview: self.background];
    
}

-(void)setProfilePicture:(UIImage *)profilePicture{
    
    self.background.image = profilePicture;
    
    UIImage *effectImage = nil;
    effectImage = [self.background.image applyDarkEffect];
    self.background.image = effectImage;
    
    UIImageView * profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 70, 70)];
    // Get the Layer of any view
    CALayer * profilepicLayer = [profilePic layer];
    profilepicLayer.contentsGravity = kCAGravityResizeAspectFill;
    [profilepicLayer setMasksToBounds:YES];
    [profilepicLayer setCornerRadius:35];
    [profilePic setImage:profilePicture];
    [self addSubview:profilePic];
    
    
}

-(void)displayBestSong{
    
    /*
    UIView *myBestSongView = [[UIView alloc] initWithFrame:CGRectMake(0, 320, 320, 100)];
    [myBestSongView setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.1]];
    [self addSubview:myBestSongView];
    
    UILabel *bestIcon = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, 150, 30)];
    [bestIcon setFont:[UIFont fontWithName:@"fontello" size:15]];
    [bestIcon setText:@"\uE80F "];
    [bestIcon setTextColor:[UIColor whiteColor]];
    [self addSubview:bestIcon];
    
    UIImageView *songArtwork = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 60, 60)];
    NSURL *imageURL = [NSURL URLWithString:@"http://o.scdn.co/300/ca89ace8c00211e4ff4b87596d4bbc5272b9f25e"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [songArtwork setImage:image];
    [myBestSongView addSubview:songArtwork];
    
    UILabel *songTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 200, 20)];
    [songTitle setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [songTitle setText:@"kanye west - Say you will"];
    [songTitle setTextColor:[UIColor whiteColor]];
    [myBestSongView addSubview:songTitle];
     */
}

-(void)displayMostPlayedSong:(NSString *)name
{
    
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(90, 85, 220, 50)];
    [detailView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [detailView.layer setCornerRadius:10];
    [self addSubview:detailView];
    
    UIImageView *mostPlayedSongArtwork = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wizkid2.jpg"]];
    [mostPlayedSongArtwork setFrame:CGRectMake(10, 10, 30, 30)];
    [detailView addSubview:mostPlayedSongArtwork];
    
    
    UILabel *mostPlayedSong = [[UILabel alloc]initWithFrame:CGRectMake(45, 5, 150, 40)];
    [mostPlayedSong setText:@"Wizkid - oluwa lo ni"];
    mostPlayedSong.numberOfLines = 0;
    [mostPlayedSong setTextColor:[UIColor whiteColor]];
    [mostPlayedSong setAlpha:0.8];
    [mostPlayedSong setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [detailView addSubview:mostPlayedSong];
    
}

-(void)displayAboutMe
{
    UILabel *aboutMe = [[UILabel alloc]initWithFrame:CGRectMake(320/2-125, 190, 250, 40)];
    [aboutMe setLineBreakMode:NSLineBreakByCharWrapping];
    [aboutMe setTextAlignment:NSTextAlignmentCenter];
    [aboutMe setText:@"I love Music, follow me I'm new here! recommend good music! "];
    [aboutMe setTextColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [aboutMe setNumberOfLines:0];
    [aboutMe setFont:[UIFont fontWithName:@"Bariol" size:14]];
    [self addSubview:aboutMe];
}

@end
