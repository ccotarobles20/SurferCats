//
//  GlobalInfo.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/21/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GlobalInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * gamePlayedBefore;
@property (nonatomic, retain) NSNumber * cumulativeScore;

@end
