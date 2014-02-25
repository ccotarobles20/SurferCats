//
//  GCHelper.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/14/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (assign, readonly) BOOL userAuthenticated;
@property (assign, readonly) NSString *playerName;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end