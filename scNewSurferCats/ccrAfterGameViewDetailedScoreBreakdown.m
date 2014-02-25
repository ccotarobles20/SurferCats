//
//  ccrAfterGameViewDetailedScoreBreakdown.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/17/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrAfterGameViewDetailedScoreBreakdown.h"

#define EASY 0
#define MEDIUM 1
#define HARD 2
#define INVINCIBLE 4

@interface ccrAfterGameViewDetailedScoreBreakdown ()

@end

@implementation ccrAfterGameViewDetailedScoreBreakdown

@synthesize scrollView;

@synthesize scores;
@synthesize bonusesGained;
@synthesize totalScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initWithArrayOfScores:(NSMutableArray*)recordOfScores andArrayOfCaptions: (NSMutableArray*)recordOfCaptions andMode:(NSInteger)mode withNumberOfBonusesGained:(NSInteger)bonuses
{    
    NSInteger totalBonusPoints = 0;
        
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CatsBackYo.png"]];
    [backgroundImage setFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:backgroundImage];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 55, 370, self.view.frame.size.width-55)];
    scrollView.contentSize = CGSizeMake(370, 23*recordOfScores.count+23);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.backgroundColor = [UIColor clearColor];
        
    UILabel *headerLabel = [[UILabel alloc] init];
    NSString *headerString = @"";
        
    if (recordOfScores.count-bonuses < 10 && mode != INVINCIBLE)
    {
        headerString = @"OH NO!  YOU LOST ON";
        [headerLabel setTextColor:[UIColor redColor]];
    }
    else {
        headerString = @"CONGRATS!  YOU BEAT";
        [headerLabel setTextColor:[UIColor greenColor]];
    }
    
    NSString *appendString = @"";
    if (mode == EASY)
    {
        appendString = @"EASY MODE!";
    }
    else if (mode == MEDIUM)
    {
        appendString = @"MEDIUM MODE!";
    }
    else if (mode == HARD)
    {
        appendString = @"HARD MODE!";
    }
    else if (mode == INVINCIBLE)
    {
        appendString = @"INVINCIBLE MODE!";
    }
    
    headerString = [NSString stringWithFormat:@"%@ %@", headerString, appendString];
    
    UIImageView *headerBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ocean.png"]];
    [headerBack setFrame:CGRectMake(0, 0, self.view.frame.size.height, 50)];
    [self.view addSubview:headerBack];
    
    [headerLabel setText:headerString];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [headerLabel setFont:[UIFont fontWithName:@"Futura" size:20]];
    [headerLabel setFrame:CGRectMake(0, 0, self.view.frame.size.height, 50)];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setAlpha:0.8];
    [self.view addSubview:headerLabel];
    
    NSInteger finalScore = 0;
        
    for (int i=0; i<recordOfScores.count;i++)
    {
        NSLog(@"For loop entered");
        UILabel *scoreCaption = [[UILabel alloc] initWithFrame:CGRectMake(10, 23*i, 300, 20)];
        scoreCaption.textColor = [UIColor blackColor];
        scoreCaption.backgroundColor = [UIColor clearColor];
        [scoreCaption setFont:[UIFont fontWithName:@"Futura" size:20]];
        scoreCaption.text = recordOfCaptions[i];
        
        UILabel *scoreNumber = [[UILabel alloc] initWithFrame:CGRectMake(330, 23*i, 100, 20)];
        scoreNumber.textColor = [UIColor blackColor];
        scoreNumber.backgroundColor = [UIColor clearColor];
        [scoreNumber setFont:[UIFont fontWithName:@"Futura" size:20]];
        scoreNumber.text = [NSString stringWithFormat:@"%i", [recordOfScores[i] integerValue]];
        
        finalScore += [recordOfScores[i] integerValue];
        
        if (i>recordOfScores.count-bonuses)
        {
            totalBonusPoints += [recordOfScores[i] integerValue];
        }
        
        [scrollView addSubview:scoreCaption];
        [scrollView addSubview:scoreNumber];
    }
    
    
    UILabel *totalScoreCaption = [[UILabel alloc] initWithFrame:CGRectMake(10, 23*recordOfScores.count, 200, 20)];
    totalScoreCaption.textColor = [UIColor blackColor];
    totalScoreCaption.backgroundColor = [UIColor clearColor];
    [totalScoreCaption setFont:[UIFont fontWithName:@"Futura" size:20]];
    totalScoreCaption.text = @"Total Score";
    
    UILabel *totalScoreNumber = [[UILabel alloc] initWithFrame:CGRectMake(330, 23*recordOfScores.count, 100, 20)];
    totalScoreNumber.textColor = [UIColor blackColor];
    totalScoreNumber.backgroundColor = [UIColor clearColor];
    [totalScoreNumber setFont:[UIFont fontWithName:@"Futura" size:20]];
    totalScoreNumber.text = [NSString stringWithFormat:@"%i", finalScore];
        
    if (scrollView.contentSize.height < scrollView.frame.size.height)
    {
        [scrollView setFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.contentSize.height)];
    }
    
    UIImageView *scrollViewBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ocean.png"]];
    [scrollViewBack setFrame:CGRectMake(scrollView.frame.origin.x-10, scrollView.frame.origin.y-5, scrollView.frame.size.width+20, scrollView.frame.size.height+5)];
    [scrollViewBack setAlpha:0.7];
    [self.view addSubview:scrollViewBack];
    
    [self.view addSubview:scrollView];
    
    if (mode == INVINCIBLE)
    {
        UIImageView *invincibleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ocean.png"]];
        [invincibleImage setFrame:CGRectMake(scrollViewBack.frame.origin.x, scrollViewBack.frame.origin.y, scrollViewBack.frame.size.width, self.view.frame.size.width-50)];
        [self.view addSubview:invincibleImage];
    }
    
    if (finalScore > 0 && mode != INVINCIBLE) {
        
        UIButton *saveScoreAndExit = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveScoreAndExit setBackgroundImage:[UIImage imageNamed:@"Ocean.png"] forState:UIControlStateNormal];
        [saveScoreAndExit.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [saveScoreAndExit setFrame:CGRectMake(self.view.frame.size.height-100, 55, 100, 50)];
        [saveScoreAndExit.titleLabel setNumberOfLines:2];
        [saveScoreAndExit.titleLabel setFont:[UIFont fontWithName:@"Futura" size:14]];
        [saveScoreAndExit setTitle:@"Save Score and Exit" forState:UIControlStateNormal];
        [saveScoreAndExit addTarget:self action:@selector(saveScore) forControlEvents:UIControlEventTouchUpInside];
        [saveScoreAndExit setAlpha:0.7];
        [self.view addSubview:saveScoreAndExit];        
    }
    
    UIButton *justExit = [UIButton buttonWithType:UIButtonTypeCustom];
    [justExit setBackgroundImage:[UIImage imageNamed:@"Ocean.png"] forState:UIControlStateNormal];
    [justExit.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [justExit setFrame:CGRectMake(self.view.frame.size.height-100, self.view.frame.size.width-50, 100, 50)];
    [justExit.titleLabel setNumberOfLines:2];
    [justExit setTitle:@"Exit Without Saving" forState:UIControlStateNormal];
    [justExit setAlpha:0.7];
    [justExit addTarget:self action:@selector(justExitClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:justExit];
    
    [self.menuDelegate changeManagedGlobalInfoScore:finalScore];
    
    [scrollView addSubview:totalScoreNumber];
    [scrollView addSubview:totalScoreCaption];
    
    bonusesGained = bonuses;
    scores = recordOfScores;
    totalScore = finalScore;
}

-(void)justExitClicked
{
    [self.menuDelegate goToScreen:@"scViewController"];
}

-(void)saveScore
{
    //Report to CoreData Delegate
    NSDate *dateToRecord = [NSDate date];
    
    [self.menuDelegate insertManagedTotalScore:totalScore:dateToRecord];
    
    NSInteger bonusPoints = 0;
    
    for (int i=scores.count-1;i>scores.count-bonusesGained-1;i--)
    {
        bonusPoints += [scores[i] integerValue];
    }
    
    NSMutableArray *allScores = [NSMutableArray array];
    
    for (int i=0;i<scores.count-bonusesGained;i++)
    {
        NSInteger score = [scores[i] integerValue];
        [allScores addObject:[NSNumber numberWithInteger:score]];
    }
    [allScores addObject:[NSNumber numberWithInteger:bonusPoints]];
    [self.menuDelegate insertManagedDetailScore:allScores];
    
    [self reportToLeaderboardWithScore:totalScore];
    
    [self.menuDelegate goToScreen:@"scViewController"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)reportToLeaderboardWithScore:(NSInteger)score;
{
    [self reportScore:score forLeaderboardID:@"surferCats.totalLeaderboard"];
}

- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        // Do something interesting here.
        if (error != nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ack!" message:@"Couldn't save your data.  Try that again, eh?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
