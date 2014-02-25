//
//  ccrHeaderLabel.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/19/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrHeaderLabel.h"

@implementation ccrHeaderLabel

@synthesize locationToExitTo;
@synthesize exitButton;
@synthesize label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initWithText:(NSString *)text
{
    NSInteger widthAmount;
    
    if (self.superview.frame.size.height>self.superview.frame.size.width)
    {
        widthAmount = self.superview.frame.size.height;
    }
    else {
        widthAmount = self.superview.frame.size.width;
    }
    
    [self setImage:[UIImage imageNamed:@"Ocean.png"]];
    [self setFrame:CGRectMake(0, 0, widthAmount, 50)];
                
    exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setTitle:@"back" forState:UIControlStateNormal];
    exitButton.titleLabel.font = [UIFont fontWithName:@"Times New Roman" size:16];
    exitButton.frame = CGRectMake(10, 10, 70, 30);
    exitButton.backgroundColor = [UIColor clearColor];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"Wave1.png"] forState:UIControlStateNormal];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"Wave3.png"] forState:UIControlStateHighlighted];
    
    [self setUserInteractionEnabled:YES];
    
    label = [[UILabel alloc] initWithFrame:self.frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Futura" size:30];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];

    [self addSubview:exitButton];
}

-(void)addDetailedLabel: (NSString*)labelText withColor: (UIColor*)color
{
    [self setFrame:CGRectMake(0, 0, self.frame.size.width, 75)];
    
    UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 20)];
    [smallLabel setText:labelText];
    [smallLabel setTextColor:color];
    [smallLabel setBackgroundColor:[UIColor clearColor]];
    [smallLabel setFont:[UIFont fontWithName:@"Futura" size:16]];
    [smallLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:smallLabel];
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
