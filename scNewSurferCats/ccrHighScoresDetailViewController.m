//
//  ccrHighScoresDetailViewController.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/15/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrHighScoresDetailViewController.h"

@interface ccrHighScoresDetailViewController ()

@end

@implementation ccrHighScoresDetailViewController

@synthesize eventNumber;
@synthesize scrollView;
@synthesize totalEvent;
@synthesize label;
@synthesize smallLabel;
@synthesize iLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        eventNumber = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ocean.png"]];
    [backgroundImage setFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:backgroundImage];
    
    UIImageView *backgroundCat = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cat2.png"]];
    [backgroundCat setFrame:CGRectMake(300, 70, self.view.frame.size.height-300, self.view.frame.size.width-70)];
    [self.view addSubview:backgroundCat];
}

-(void)viewDidAppear:(BOOL)animated
{    
    iLabel = [[ccrHeaderLabel alloc] init];
    [self.view addSubview:iLabel];
    [iLabel initWithText:[NSString stringWithFormat:@"%i points", [[totalEvent valueForKey:@"totalScore"] integerValue]]];
    [iLabel.exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [iLabel addDetailedLabel:[NSString stringWithFormat:@"by %@", [totalEvent valueForKey:@"scorer"]] withColor:[UIColor orangeColor]];

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 80, 280, 240)];
    scrollView.contentSize = CGSizeMake(300, 300);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];

    NSArray *tempArray = [NSMutableArray arrayWithArray:[self.menuDelegate getManagedDetailScores]];
    NSMutableArray *arrayOfScores = [NSMutableArray array];
    NSInteger convertedValue;
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level1points"] integerValue];
    if (convertedValue != nil)
    {
        NSLog(@"Not null value");
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level One:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level2points"] integerValue];
    if (convertedValue != nil)
    {
        NSLog(@"Not null value");
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Two:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level3points"] integerValue];
    if (convertedValue != nil)
    {
        NSLog(@"not null value");
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Three:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level4points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Four:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level5points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Five:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level6points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Six:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level7points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Seven:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level8points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Eight:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level9points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Nine:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"level10points"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Level Ten:  %i points", convertedValue]];
    }
    
    convertedValue = [[tempArray[eventNumber] valueForKey:@"bonuspoints"] integerValue];
    if (convertedValue != nil)
    {
        [arrayOfScores addObject:[NSString stringWithFormat:@"Bonus:  %i points", convertedValue]];
    }
    
    UILabel *details;
    scrollView.contentSize = CGSizeMake(280, arrayOfScores.count*25+30);
    
    for (int i=0;i<arrayOfScores.count;i++)
    {
        NSLog(@"One element in array");
        details = [[UILabel alloc] initWithFrame:CGRectMake(0, 25*i, scrollView.frame.size.width, 20)];
        [details setText:arrayOfScores[i]];
        [details setBackgroundColor:[UIColor clearColor]];
        [details setFont:[UIFont fontWithName:@"Futura" size:23]];
        [scrollView addSubview:details];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [scrollView removeFromSuperview];
    [iLabel removeFromSuperview];
    [smallLabel removeFromSuperview];
}

-(void)exitButtonClicked
{
    [self.menuDelegate goToScreen:@"scHighScoresViewController"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
