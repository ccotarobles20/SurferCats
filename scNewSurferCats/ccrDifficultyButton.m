//
//  ccrDifficultyButton.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/23/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrDifficultyButton.h"

#define EASY 0
#define MEDIUM 1
#define HARD 2
#define INVINCIBLE 4

#define NOT_TRANSFORMED 0
#define TRANSFORMED 1
#define MOVED 2

@implementation ccrDifficultyButton

@synthesize difficultyButton;
@synthesize arrayOfDifficultyButtons;
@synthesize playButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        arrayOfDifficultyButtons = [NSMutableArray array];
        playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playButton setTitle:@"PLAY NOW!" forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [playButton setBackgroundImage:[UIImage imageNamed:@"LightBlueBack.png"] forState:UIControlStateNormal];
        [playButton setAlpha:0.7];
        [playButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    }
    return self;
}

-(NSInteger)createDifficultyButtonNamed: (NSString*)name withNormalFrame:(CGRect)normalFrame;
{
    difficultyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [difficultyButton setTitle:name forState:UIControlStateNormal];
    [difficultyButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:18]];
    [difficultyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    difficultyButton.frame = normalFrame;
    [difficultyButton setBackgroundImage:[UIImage imageNamed:@"YellowBeach.png"] forState:UIControlStateNormal];
    [difficultyButton addTarget:self action:@selector(clickedDifficultyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.superview addSubview:difficultyButton];
    [difficultyButton setTag:NOT_TRANSFORMED];
    [arrayOfDifficultyButtons addObject:difficultyButton];
    [difficultyButton setAlpha:0.7];
    
    if ([name isEqualToString:@"EASY"])
    {
        return EASY;
    }
    else if ([name isEqualToString:@"MEDIUM"])
    {
        return MEDIUM;
    }
    else if ([name isEqualToString:@"HARD"])
    {
        return HARD;
    }
    else if ([name isEqualToString:@"INVINCIBLE"])
    {
        return INVINCIBLE;
    }
    return EASY;
}

-(void)clickedDifficultyButton:(id)sender
{
    NSInteger moveAmount = 0;
    UIButton *clickedButton = sender;
    NSInteger clickedButtonNumber = 0;
    Boolean doNotExpand = NO;
    
    for (int i=0;i<arrayOfDifficultyButtons.count;i++)
    {
        if (clickedButton == arrayOfDifficultyButtons[i])
        {
            clickedButtonNumber = i;
        }
        
        if ([arrayOfDifficultyButtons[i] tag] == TRANSFORMED)
        {
            NSLog(@"Reverting!");
            UIButton *thisButton = arrayOfDifficultyButtons[i];
            [thisButton setFrame:CGRectMake(thisButton.frame.origin.x, thisButton.frame.origin.y, thisButton.frame.size.width/3, thisButton.frame.size.height)];
            moveAmount = thisButton.frame.size.width*2;
            thisButton.tag = NOT_TRANSFORMED;
            if (thisButton == clickedButton)
            {
                doNotExpand = YES;
            }
        }
        else if ([arrayOfDifficultyButtons[i] tag] == MOVED)
        {
            UIButton *thisButton = arrayOfDifficultyButtons[i];
            [thisButton setFrame:CGRectMake(thisButton.frame.origin.x-moveAmount, thisButton.frame.origin.y, thisButton.frame.size.width, thisButton.frame.size.height)];
            thisButton.tag = NOT_TRANSFORMED;
        }
    }
    
    [playButton removeFromSuperview];
    
    if (doNotExpand)
    {
        return;
    }
    
    [clickedButton setFrame:CGRectMake(clickedButton.frame.origin.x, clickedButton.frame.origin.y, clickedButton.frame.size.width*3, clickedButton.frame.size.height)];
    [clickedButton setTag:TRANSFORMED];
    
    [playButton setFrame:CGRectMake(clickedButton.frame.origin.x, clickedButton.frame.origin.y+clickedButton.frame.size.height-30, clickedButton.frame.size.width, 30)];
    [self.superview addSubview:playButton];
    
    for (int i=clickedButtonNumber;i<arrayOfDifficultyButtons.count;i++)
    {
        if (i==clickedButtonNumber)
        {
            continue;
        }
        
        UIButton *buttonMoving = arrayOfDifficultyButtons[i];
        [buttonMoving setFrame:CGRectMake(buttonMoving.frame.origin.x+clickedButton.frame.size.width*2/3, buttonMoving.frame.origin.y, buttonMoving.frame.size.width, buttonMoving.frame.size.height)];
        [buttonMoving setTag:MOVED];
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
