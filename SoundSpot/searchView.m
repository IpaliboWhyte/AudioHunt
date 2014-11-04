//
//  searchView.m
//  AudioHunt
//
//  Created by Ipalibo Whyte on 16/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "searchView.h"

@implementation searchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void) layoutwithBackground
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //Add background to view and fit to screen
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIImage imageNamed:@"musicnotesSearch.jpg"] drawInRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIView *backgroundOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 50)];
    [backgroundOverlay setBackgroundColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:0.96]];
    [self addSubview:backgroundOverlay];
}

-(void)layoutSubviews{
    
}
@end
