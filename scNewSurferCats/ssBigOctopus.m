//
//  ssBigOctopus.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/18/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ssBigOctopus.h"

@implementation ssBigOctopus

#define LEFT_LOW 0
#define LEFT_MID 1
#define LEFT_UP 2
#define RIGHT_UP 3
#define RIGHT_MID 4
#define RIGHT_LOW 5

#define TENTACLE_TIME 0.2

@synthesize justReturnedFromBg;
@synthesize paused;

@synthesize arrayOfChildren;
@synthesize childCreatingPoint;
@synthesize swiftsurfer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        srandom(time(NULL));
        arrayOfChildren = [NSMutableArray array];
    }
    return self;
}

-(void)make: (NSInteger)x: (NSInteger)y: (float)size
{
    self.frame = CGRectMake(x, y, size, size);
    
    if (!justReturnedFromBg && self.image == nil) {
        childCreatingPoint = CGPointMake(x+size/2, y+size/2);
    }
    
    self.image = [UIImage imageNamed:@"Octopus.png"];
    [self performSelector:@selector(shootTentacle) withObject:self afterDelay:TENTACLE_TIME];
}

-(void)shootTentacle
{    
    NSInteger randomDirection = random()%6;
    
    if (self.superview == nil)
    {
        return;
    }
    
    switch (randomDirection) {
        case LEFT_LOW:
            [self createSmallOctopusWithLocation:childCreatingPoint.x-5 :childCreatingPoint.y-8 :[UIImage imageNamed:@"Tentacle1.png"]];
            break;
        case LEFT_MID:
            [self createSmallOctopusWithLocation:childCreatingPoint.x-5 :childCreatingPoint.y-2 :[UIImage imageNamed:@"Tentacle2.png"]];
             break;
        case LEFT_UP:
            [self createSmallOctopusWithLocation:childCreatingPoint.x-5 :childCreatingPoint.y-5 :[UIImage imageNamed:@"Tentacle3.png"]];
            break;
        case RIGHT_LOW:
            [self createSmallOctopusWithLocation:childCreatingPoint.x+5 :childCreatingPoint.y-8 :[UIImage imageNamed:@"Tentacle1.png"]];
            break;
        case RIGHT_MID:
            [self createSmallOctopusWithLocation:childCreatingPoint.x+5 :childCreatingPoint.y-2 :[UIImage imageNamed:@"Tentacle4.png"]];
            break;
        case RIGHT_UP:
            [self createSmallOctopusWithLocation:childCreatingPoint.x+5 :childCreatingPoint.y-5 :[UIImage imageNamed:@"Tentacle5.png"]];
            break;
        default:
            break;
    }
}

-(void)createSmallOctopusWithLocation: (NSInteger)x: (NSInteger)y: (UIImage*)image
{
    if (justReturnedFromBg) {
        NSLog(@"Changing BG");
        justReturnedFromBg = NO;
        return;
    }
    
    if (paused)
    {
        [self performSelector:@selector(shootTentacle) withObject:self afterDelay:TENTACLE_TIME];
        return;
    }
    
    childCreatingPoint = CGPointMake(x, y);
    
    NSInteger rDetach = random()%18;
    Boolean detach = NO;
    
    image = [UIImage imageNamed:@"TentacleCircle2.png"];
    
    if (rDetach == 1)
    {
        detach = YES;
    }

    ssSmallOctopus *child = [[ssSmallOctopus alloc] init];
    [child make:x :y :10];
    [child setImage:image];
    
    [swiftsurfer.allObjectsOnField addObject:child];
    
    [child setDetached:detach];
    
    [self.superview insertSubview:child belowSubview:self];
    
    if (detach == NO)
    {
        [arrayOfChildren addObject:child];
    }
    else {
        for (int i=0; i<arrayOfChildren.count;i++)
        {
            [swiftsurfer.allObjectsOnField removeObject:arrayOfChildren[i]];
            [arrayOfChildren[i] removeFromSuperview];
        }
        
        arrayOfChildren = [NSMutableArray array];
        childCreatingPoint = CGPointMake(self.frame.origin.x+(self.frame.size.width/2), self.frame.origin.y+(self.frame.size.height/2));
    }
    
    if (self.superview != nil)
    {
        [self performSelector:@selector(shootTentacle) withObject:self afterDelay:TENTACLE_TIME];
    }
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
