//
//  SongItemCustomCell.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 26/09/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SongCustomCellDelegate

@required

-(void)sendToUser:(id)sender;

@end

@interface SongItemCustomCell : UITableViewCell{
    
}

@property (nonatomic, weak) id<SongCustomCellDelegate> delegate;



@property UIView *topSection;
@property UIView *bottomSection;

-(void)layoutSongProperties:(NSString *)songTitle :(UIImage *)songArtwork;

-(void)layoutButtons;

@end
