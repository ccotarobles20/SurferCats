//
//  ccrFireOctopus.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/19/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrFireOctopus.h"

@implementation ccrFireOctopus

@synthesize justReturnedFromBg;
@synthesize paused;

@synthesize direction;
@synthesize speed;
@synthesize startSpeed;
@synthesize gain;

#define directionLeft 0
#define directionLeftUp 1
#define directionUp 2
#define directionUpRight 3
#define directionRight 4
#define directionRightDown 5
#define directionDown 6
#define directionDownLeft 7

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        srandom(time(NULL));
        direction = directionLeft;
        speed = 1;
        startSpeed = 1;
        gain = 0.7;
        self.tag = FIRE_OCTOPUS;
    }
    return self;
}

-(void)make:(NSInteger)x :(NSInteger)y :(float)size
{
    self.frame = CGRectMake(x, y, size, size);
    
    if (self.image == nil) {
        [self performSelector:@selector(move) withObject:self afterDelay:0.05];
        [self performSelector:@selector(changeDirection) withObject:self afterDelay:4.0];
        [self setImage:[UIImage imageNamed:@"SmallOctopus.png"]];
    }
}

-(void)setOnFire
{
    if (paused)
    {
        [self performSelector:@selector(setOnFire) withObject:self afterDelay:1.0];
        return;
    }
        
    [self setImage:[UIImage imageNamed:@"Octopus.png"]];
    startSpeed = 5;
}

-(void)move
{
    if (paused)
    {
        [self performSelector:@selector(move) withObject:self afterDelay:0.05];
        return;
    }
    
    if (self.superview == nil)
    {
        return;
    }
    
    float oldX = self.frame.origin.x+(self.frame.size.width/2);
    float oldY = self.frame.origin.y+(self.frame.size.height/2);
    
    if (oldX > self.superview.frame.size.width-30-self.frame.size.width/2 || oldX < 0+self.frame.size.width/2 || oldY > self.superview.frame.size.height-self.frame.size.height/2 || oldY < 0+self.frame.size.height/2) {
        NSLog(@"Error: Bad placement of octopus");
    }
    
    CGPoint newPoint;
    
    switch (direction)
    {
        case directionLeft:
            newPoint = CGPointMake(oldX-speed, oldY);
            break;
        case directionLeftUp:
            newPoint = CGPointMake(oldX-speed, oldY-speed);
            break;
        case directionUp:
            newPoint = CGPointMake(oldX, oldY-speed);
            break;
        case directionUpRight:
            newPoint = CGPointMake(oldX+speed, oldY-speed);
            break;
        case directionRight:
            newPoint = CGPointMake(oldX+speed, oldY);
            break;
        case directionRightDown:
            newPoint = CGPointMake(oldX+speed, oldY+speed);
            break;
        case directionDown:
            newPoint = CGPointMake(oldX, oldY+speed);
            break;
        case directionDownLeft:
            newPoint = CGPointMake(oldX-speed, oldY+speed);
            break;
    }
    
    if (newPoint.x > self.superview.frame.size.width-30-self.frame.size.width/2 || newPoint.x < 0+self.frame.size.width/2+50 || newPoint.y > self.superview.frame.size.height-self.frame.size.height/2 || newPoint.y < 0+self.frame.size.height/2) {
        [self changeDirection];
        [self performSelector:@selector(move) withObject:self afterDelay:0.05];
        return;
    }
    
    [self setCenter:newPoint];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+gain, self.frame.size.height+gain)];
    
    //[self setFrame:CGRectMake(newPoint.x, newPoint.y, self.frame.size.width+gain, self.frame.size.height+gain)];
    
    if (self.frame.size.height > 100)
    {
        gain = 0;
        [self setOnFire];
    }
    
    [self performSelector:@selector(move) withObject:self afterDelay:0.05];
}

-(void)changeDirection
{
    if (self.superview == nil)
    {
        return;
    }
    
    direction = random()%8;
    speed = startSpeed+random()%2;
    [self performSelector:@selector(changeDirection) withObject:self afterDelay:4.0];
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
