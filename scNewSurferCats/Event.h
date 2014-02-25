//
//  Event.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/16/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * scoreDate;
@property (nonatomic, retain) NSNumber * totalScore;
@property (nonatomic, retain) NSString * scorer;

@end
