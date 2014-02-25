//
//  ccrInfoViewController.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/18/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrInfoViewController.h"
#import "ccrHeaderLabel.h"

@interface ccrInfoViewController ()

@end

@implementation ccrInfoViewController

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ocean.png"]];
    [background setFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:background];
    
    scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:CGRectMake(10, 60, self.view.frame.size.height-20, self.view.frame.size.width-70)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.height-20, 1400)];
    [self.view addSubview:scrollView];
    
    ccrHeaderLabel *iLabel = [[ccrHeaderLabel alloc] init];
    [self.view addSubview:iLabel];
    [iLabel initWithText:@"Instructions"];
    [iLabel.exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setTitle:@"back" forState:UIControlStateNormal];
    exitButton.titleLabel.font = [UIFont fontWithName:@"Times New Roman" size:16];
    exitButton.frame = CGRectMake(10, 10, 70, 30);
    exitButton.backgroundColor = [UIColor clearColor];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"Wave1.png"] forState:UIControlStateNormal];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"Wave3.png"] forState:UIControlStateHighlighted];
    [exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont fontWithName:@"Futura" size:30];
    headerLabel.text = @"Instructions";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headerLabel];*/
    
    UILabel *instructions = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, scrollView.frame.size.width, 300)];
    [instructions setBackgroundColor:[UIColor clearColor]];
    
    [self createObjectInfoBoxWithImage:nil andAtPoint:CGPointMake(10, 10) andWidth:0 andHeight:130 andText:@"Become a cat and surf your way to the beach in this fast-paced, thrilling, and adventurous game. Avoid tidal waves that block your path, as well as sharks and mermaids that come after you. Land on rocks to rest briefly, and hide in seaweed to escape enemy hands. And just when you think you've mastered it all, we've got an a giant octopus for you to face."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"SurferCat.png"] andAtPoint:CGPointMake(10, 190) andWidth:80 andHeight:40 andText:@"The Surfer Cat: Your character whose objective it is to avoid obstacles such as tidal waves, mermaids, and sharks, and to reach the beach."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Seaweed.png"] andAtPoint:CGPointMake(10, 275) andWidth:80 andHeight:40 andText:@"The Seaweed: Your home base. When you die, you re-start the level from here. Hide here, but don't linger long or time will run out."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Rock.png"] andAtPoint:CGPointMake(10, 360) andWidth:80 andHeight:40 andText:@"Rocks: An obstacle that allows you to temporarily rest on it.  These are harmless."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Wave1.png"] andAtPoint:CGPointMake(10, 460) andWidth:80 andHeight:40 andText:@"Tidal Waves: These are to be avoided at all costs; one touch could kill you."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Beach.png"] andAtPoint:CGPointMake(10, 560) andWidth:20 andHeight:140 andText:@"The Beach: Make it here to pass the level."];
        
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Life.png"] andAtPoint:CGPointMake(10, 760) andWidth:40 andHeight:40 andText:@"Life: You start out with 3 of these, and each time you die you lose one.  Don't get to 0.  Simple enough, yeah?"];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"SeaGold.png"] andAtPoint:CGPointMake(10, 860) andWidth:40 andHeight:40 andText:@"Sea Gold: These are harmless.  In fact, they're helpful!  Gobble these guys up for extra time and points!"];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Mermaid2.png"] andAtPoint:CGPointMake(10, 960) andWidth:50 andHeight:80 andText:@"Mermaids: These are nasty creatures who jump up and down on rocks.  Don't touch them or they'll lure you...to your death."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Shark.png"] andAtPoint:CGPointMake(10, 1080) andWidth:160 andHeight:80 andText:@"Sharks: These hungry guys swim around hoping to eat you up.  They're so strong they can swim straight through the tidal waves.  Avoid them at all costs."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"Octopus.png"] andAtPoint:CGPointMake(10, 1200) andWidth:80 andHeight:80 andText:@"The Octopus: The final boss.  Avoid his tentacles and beware of his children."];
    
    [self createObjectInfoBoxWithImage:[UIImage imageNamed:@"SmallOctopus.png"] andAtPoint:CGPointMake(10, 1300) andWidth:40 andHeight:40 andText:@"Small Octopi: The children of the larger octopus, these guys can be just as deadly...especially if you let one get older."];
}

-(void)createObjectInfoBoxWithImage: (UIImage*)image andAtPoint:(CGPoint)point andWidth: (NSInteger)width andHeight: (NSInteger)height andText: (NSString*)text
{
    UIImageView *backOfBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LightBlueBack.png"]];
    [backOfBox setFrame:CGRectMake(point.x, point.y-10 , scrollView.frame.size.width, height+30)];
    [backOfBox setAlpha:0.5];
    [scrollView addSubview:backOfBox];
    
    UIImageView *boxImage = [[UIImageView alloc] initWithImage:image];
    [boxImage setFrame:CGRectMake(point.x, point.y, width, height)];
    [scrollView addSubview:boxImage];
    
    UILabel *boxLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x+width+10, point.y-10, scrollView.frame.size.width-(point.x+width+10), height+30)];
    [boxLabel setFont:[UIFont fontWithName:@"Futura" size:16]];
    [boxLabel setBackgroundColor:[UIColor clearColor]];
    [boxLabel setNumberOfLines:15];
    [boxLabel setText:text];
    [scrollView addSubview:boxLabel];
}

-(void)exitButtonClicked
{
    NSLog(@"Clicked");
    [self.menuDelegate goToScreen:@"scViewController"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
