//
//  ProfileView.h
//  AudioHunt
//
//  Created by Ipalibo Whyte on 14/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parse/Parse.h>
#import "UIImage+ImageEffects.h"

@interface ProfileView : UIView{
    CGRect screenRect;
    CALayer *imageLayer;
}

@property UIImageView *background;
-(void)setProfilePicture:(UIImage *)profilePicture;
-(void)displayBestSong;
-(void)displayProfilepicView;
-(void)displayMostPlayedSong:(NSString *)name;
-(void)displayAboutMe;

@end
