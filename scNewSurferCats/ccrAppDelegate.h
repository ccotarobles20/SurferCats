//
//  ccrAppDelegate.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/14/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scGameViewController.h"
#import "scHighScoresViewController.h"
#import "scViewController.h"
#import "ccrHighScoresDetailViewController.h"
#import "GCHelper.h"
#import "Event.h"
#import "DetailedEvent.h"
#import "GlobalInfo.h"
#import "ccrInfoViewController.h"

@interface ccrAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSInteger eventNumber;

@property (nonatomic) Boolean playedBefore;
@property (nonatomic) NSInteger mode;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) scViewController *menuVC;
@property (nonatomic, retain) scGameViewController *gameVC;
@property (nonatomic, retain) scHighScoresViewController *highScoresVC;
@property (nonatomic, retain) ccrHighScoresDetailViewController *highScoresDetailVC;
@property (nonatomic, retain) ccrInfoViewController *infoVC;
@property (nonatomic, retain) UINavigationController *navigatorVC;

-(void)goToScreen: (NSString*)screen;
-(void)insertManagedTotalScore:(NSInteger)totalScore: (NSDate*)date;
-(NSArray*)getManagedTotalScores;
-(void)insertManagedDetailScore:(NSMutableArray*)array;
-(NSArray*)getManagedDetailScores;
-(void)deleteManagedDetailAndTotalScoreAtSpot:(NSInteger)spot;
-(void)insertManagedGlobalInfo:(Boolean)playedBefore:(NSInteger)cumulativeScore;
-(NSArray*)getManagedGlobalInfo;
-(void)changeManagedGlobalInfo:(Boolean)info;
-(void)changeManagedGlobalInfoScore:(NSInteger)score;
-(void)setMode:(NSInteger)difficulty;
-(NSInteger)getMode;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
