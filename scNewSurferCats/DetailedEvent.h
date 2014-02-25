//
//  DetailedEvent.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/16/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DetailedEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * level1points;
@property (nonatomic, retain) NSNumber * level2points;
@property (nonatomic, retain) NSNumber * level3points;
@property (nonatomic, retain) NSNumber * level4points;
@property (nonatomic, retain) NSNumber * level6points;
@property (nonatomic, retain) NSNumber * level7points;
@property (nonatomic, retain) NSNumber * level8points;
@property (nonatomic, retain) NSNumber * level9points;
@property (nonatomic, retain) NSNumber * level10points;
@property (nonatomic, retain) NSNumber * bonuspoints;
@property (nonatomic, retain) NSNumber * level5points;

@end
