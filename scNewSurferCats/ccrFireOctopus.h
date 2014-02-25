//
//  ccrFireOctopus.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/19/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "imageViewObject.h"
#import "ObjectConstants.h"

@interface ccrFireOctopus : imageViewObject

@property (nonatomic) NSInteger direction;
@property (nonatomic) NSInteger speed;
@property (nonatomic) NSInteger startSpeed;
@property (nonatomic) float gain;

-(void)move;
-(void)changeDirection;
-(void)setOnFire;

@end
