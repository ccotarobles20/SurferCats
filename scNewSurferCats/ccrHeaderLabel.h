//
//  ccrHeaderLabel.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/19/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ccrHeaderLabel : UIImageView

@property (nonatomic, strong) NSString *locationToExitTo;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UILabel *label;

-(void)initWithText:(NSString*)text;
-(void)exitButtonClicked;
-(void)addDetailedLabel: (NSString*)labelText withColor:(UIColor*)color;

@end
