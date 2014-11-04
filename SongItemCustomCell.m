//
//  SongItemCustomCell.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 26/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "SongItemCustomCell.h"

@implementation SongItemCustomCell

- (void)awakeFromNib {

}

-(void)layoutSongProperties:(NSString *)songTitle :(UIImage *)songArtwork{
    
    self.topSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    [self.topSection setBackgroundColor: [UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:0.13]];
    [self addSubview:self.topSection];
    
    self.bottomSection = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, 50)];
    [self.bottomSection setBackgroundColor: [UIColor grayColor]];
    [self addSubview:self.bottomSection];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 240, 50)];
    [titleLabel setNumberOfLines:0];
    [titleLabel setText:songTitle];
    [titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.topSection addSubview:titleLabel];
    
    UIImageView *artworkview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [artworkview setImage:songArtwork];
    [artworkview setBackgroundColor:[UIColor redColor]];
    [self.topSection addSubview:artworkview];
    
}

-(void)layoutButtons{
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    [playButton setBackgroundColor:[UIColor colorWithRed:0.361 green:0.592 blue:0.749 alpha:1]];
    [playButton setTitle:@"\uE800" forState:UIControlStateNormal];
    [playButton.titleLabel setFont:[UIFont fontWithName:@"cellbuttonfonts" size:13]];
    [self.bottomSection addSubview:playButton];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 160, 50)];
    [shareButton addTarget:self action:@selector(sendTo:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setBackgroundColor:[UIColor colorWithRed:0.424 green:0.478 blue:0.537 alpha:1]];
    [shareButton setTitle:@"\uE801" forState:UIControlStateNormal];
    [shareButton.titleLabel setFont:[UIFont fontWithName:@"cellbuttonfonts" size:13]];
    [self.bottomSection addSubview:shareButton];
}

-(void)sendTo:(id)sender{
    [self.delegate sendToUser:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
