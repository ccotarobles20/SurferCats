//
//  ccrAfterGameViewDetailedScoreBreakdown.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/17/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@protocol menuViewControllerDelegate <NSObject>
-(void)goToScreen: (NSString*)screen;
-(void)insertManagedTotalScore:(NSInteger)totalScore: (NSDate*)date;
-(void)insertManagedDetailScore:(NSMutableArray*)array;
-(void)changeManagedGlobalInfoScore:(NSInteger)score;
@end

@interface ccrAfterGameViewDetailedScoreBreakdown : UIViewController

@property (nonatomic, assign) id<menuViewControllerDelegate> menuDelegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *scores;
@property (nonatomic) NSInteger totalScore;
@property (nonatomic) NSInteger bonusesGained;

-(void)initWithArrayOfScores:(NSMutableArray*)recordOfScores andArrayOfCaptions: (NSMutableArray*)recordOfCaptions andMode:(NSInteger)mode withNumberOfBonusesGained:(NSInteger)bonusesGained;
- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) category;

@end
