//
//  ssSmallOctopus.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/18/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ssSmallOctopus.h"

@implementation ssSmallOctopus

@synthesize justReturnedFromBg;
@synthesize paused;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tag = SMALL_OCTOPUS;
    }
    return self;
}

-(void)make:(NSInteger)x :(NSInteger)y :(float)size
{
    [self setFrame:CGRectMake(x, y, size, size)];
    
    if (self.image == nil) {
        [self setImage:[UIImage imageNamed:@"TentacleCircle2.png"]];
    }
}

-(void)setDetached:(Boolean)detached
{
    detached = detached;
    if (detached == YES)
    {
        [self performSelector:@selector(glide) withObject:self afterDelay:0.05];
    }
}

-(void)glide
{
    if (paused)
    {
        [self performSelector:@selector(glide) withObject:self afterDelay:0.05];
        return;
    }

    
    [self setImage:[UIImage imageNamed:@"SmallOctopus.png"]];
    
    NSInteger increase = 0;
    if (self.frame.size.width < 25)
    {
        increase = 1;
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-2, self.frame.size.width+increase, self.frame.size.height+increase)];
    
    if (self.frame.origin.y<0) {
        NSLog(@"Octopi removed from superview");
        [self removeFromSuperview];
        return;
    }
    
    [self performSelector:@selector(glide) withObject:self afterDelay:0.05];
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
