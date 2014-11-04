//
//  PostTableViewCell.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 09/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

-(void)didSendButtonTap:(id)sender;

@end


@interface PostTableViewCell : UITableViewCell

@property (assign) id <CustomCellDelegate> delegate;

@property UIView *visibleView;
@property UIView *hiddenView;
-(void)setSoundcloudLabel;
-(void)setUserInfo:(NSString *)userName :(UIImage *)userPic;
-(void)setPostInfo:(NSString *)postMessage :(NSString *)post_songTitle :(UIImage *)post_songArtwork;
-(void)setHiddenButtons;
@end
