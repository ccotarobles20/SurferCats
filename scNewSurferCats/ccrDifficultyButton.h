//
//  ccrDifficultyButton.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/23/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ccrDifficultyButton : UIButton

@property (nonatomic, strong) UIButton *difficultyButton;
@property (nonatomic, strong) NSMutableArray *arrayOfDifficultyButtons;
@property (nonatomic, strong) UIButton *playButton;

-(NSInteger)createDifficultyButtonNamed:(NSString*)name withNormalFrame:(CGRect)normalFrame;
-(void)clickedDifficultyButton:(id)sender;

@end
