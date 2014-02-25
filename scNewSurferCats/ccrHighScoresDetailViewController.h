//
//  ccrHighScoresDetailViewController.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/15/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "ccrHeaderLabel.h"

@protocol menuViewControllerDelegate <NSObject>
-(void)goToScreen: (NSString*)screen;
-(NSArray*)getManagedDetailScores;
@end

@interface ccrHighScoresDetailViewController : UIViewController

@property (nonatomic, assign) id<menuViewControllerDelegate> menuDelegate;
@property (nonatomic) NSInteger eventNumber;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) Event *totalEvent;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *smallLabel;
@property (nonatomic, strong) ccrHeaderLabel *iLabel;

-(void)exitButtonClicked;

@end
