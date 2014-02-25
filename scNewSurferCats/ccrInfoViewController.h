//
//  ccrInfoViewController.h
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/18/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuViewControllerDelegate <NSObject>
-(void)goToScreen: (NSString*)screen;
@end

@interface ccrInfoViewController : UIViewController

@property (nonatomic, assign) id<menuViewControllerDelegate> menuDelegate;

@property (nonatomic, strong) UIScrollView *scrollView;

-(void)exitButtonClicked;

@end
