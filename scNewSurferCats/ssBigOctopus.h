//
//  ssBigOctopus.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/18/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "imageViewObject.h"
#import "ssSmallOctopus.h"
#import "ssSurfer.h"

@interface ssBigOctopus : imageViewObject

@property (nonatomic, strong) NSMutableArray *arrayOfChildren;
@property (nonatomic) CGPoint childCreatingPoint;
@property (nonatomic, strong) ssSurfer *swiftsurfer;

-(void)createSmallOctopusWithLocation: (NSInteger)x: (NSInteger)y: (UIImage*)image;

@end
