//
//  backgroundView.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "backgroundView.h"

@implementation backgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        //Add background to view and fit to screen
        UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"musicnotes.jpg"] drawInRect:self.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.backgroundColor = [UIColor colorWithPatternImage:image];

        UIView *backgroundOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [backgroundOverlay setBackgroundColor:[UIColor colorWithRed:0.839 green:0.271 blue:0.255 alpha:0.96]];
        [self addSubview:backgroundOverlay];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
