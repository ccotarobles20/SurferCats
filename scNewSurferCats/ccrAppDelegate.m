//
//  ccrAppDelegate.m
//  scNewSurferCats
//
//  Created by Carl Cota-Robles on 7/14/13.
//  Copyright (c) 2013 Carl Cota-Robles. All rights reserved.
//

#import "ccrAppDelegate.h"

#define EASY 0
#define MEDIUM 1
#define HARD 2
#define INVINCIBLE 4

@implementation ccrAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize menuVC;
@synthesize highScoresVC;
@synthesize gameVC;
@synthesize navigatorVC;
@synthesize highScoresDetailVC;
@synthesize infoVC;
@synthesize eventNumber;
@synthesize playedBefore;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    eventNumber = 0;
    

        
    NSArray *storage = [self getManagedGlobalInfo];
    if (storage.count == 0)
    {
        [self insertManagedGlobalInfo:NO:0];
        NSLog(@"No record");
        playedBefore = NO;
    }
    else {
        NSLog(@"Setting played before");
        playedBefore = [[storage[0] valueForKey:@"gamePlayedBefore"] boolValue];
    }
        
    NSLog(@"Played before ended up being %i", playedBefore);
    
    menuVC = [[scViewController alloc] init];
    [[self menuVC] setMenuDelegate:self];
    
    gameVC = [[scGameViewController alloc] init];
    [[self gameVC] setMenuDelegate:self];
    
    highScoresVC = [[scHighScoresViewController alloc] init];
    [[self highScoresVC] setMenuDelegate:self];
    
    highScoresDetailVC = [[ccrHighScoresDetailViewController alloc] init];
    [[self highScoresDetailVC] setMenuDelegate:self];
    
    infoVC = [[ccrInfoViewController alloc] init];
    [[self infoVC] setMenuDelegate:self];
    
    [self setNavigatorVC:[[UINavigationController alloc] initWithRootViewController:menuVC]];
    
    [navigatorVC setNavigationBarHidden:YES];
    
    self.window.rootViewController = navigatorVC;
    
    _managedObjectContext = [self managedObjectContext];
    
    [[GCHelper sharedInstance] authenticateLocalUser];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    for (int i=0;i<gameVC.swiftSurfer.allObjectsOnField.count;i++) {
        NSLog(@"Setting changing BG");
        [gameVC.swiftSurfer.allObjectsOnField[i] setJustReturnedFromBg:YES];
    }
    
    [gameVC pause];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"Entered foreground!");
    
    for (int i=0;i<gameVC.swiftSurfer.allObjectsOnField.count;i++) {
        [gameVC.swiftSurfer.allObjectsOnField[i] refresh];
    }
}

#pragma mark Core Data Functions

//Creates a new entry with the total score, player name, and date the user got a record
-(void)insertManagedTotalScore:(NSInteger)totalScore: (NSDate*)date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Event *event = (Event*)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    [event setValue:[NSNumber numberWithInteger:totalScore] forKey:@"totalScore"];
    [event setValue:date forKey:@"scoreDate"];
    
    NSLog(@"Help");
    
    Boolean gameCenterAvailable = [[GCHelper sharedInstance] gameCenterAvailable];
    NSString *scorer = @"Anonymous";
    
    if (!gameCenterAvailable)
    {
        NSLog(@"No Game Center on this device");
    }
    else {
        scorer = [[GCHelper sharedInstance] playerName];
    }
    
    [event setValue:scorer forKey:@"scorer"];
    
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Retrieves an array with all records on this device
-(NSArray*)getManagedTotalScores;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Event" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
        
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
        NSLog(@"Array is empty");
        return [NSArray array];
    }
    return array;
}

//Creates a record with the detailed records, the time it took to complete each level and the bonus points the user earned.
-(void)insertManagedDetailScore:(NSMutableArray*)array
{
    NSManagedObjectContext *context = [self managedObjectContext];
    DetailedEvent *event = (DetailedEvent*)[NSEntityDescription insertNewObjectForEntityForName:@"DetailedEvent" inManagedObjectContext:context];
    
    NSArray *keyArray = [NSArray arrayWithObjects:@"level1points", @"level2points", @"level3points", @"level4points", @"level5points", @"level6points", @"level7points", @"level8points", @"level9points", @"level10points", nil];
    
    for (int i=0;i<array.count-1;i++)
    {
        NSLog(@"Success 1");
        NSLog(@"Array value is %i", [array[i] integerValue]);
        [event setValue:array[i] forKey:keyArray[i]];
    }
    
    NSLog(@"Passed");
    [event setValue:array[array.count-1] forKey:@"bonuspoints"];
    
    NSLog(@"Passed almost all");
    
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Gets an array containing the detailed records for each game the user has played
-(NSArray*)getManagedDetailScores;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"DetailedEvent" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
        NSLog(@"Array is empty");
        return [NSArray array];
    }
    return array;
}

-(void)deleteManagedDetailAndTotalScoreAtSpot:(NSInteger)spot
{
    NSManagedObjectContext *context = [self managedObjectContext];

    NSMutableArray *totalScore = [self getManagedTotalScores];
    NSMutableArray *detailScore = [self getManagedDetailScores];
    [context deleteObject:totalScore[spot]];
    [context deleteObject:detailScore[spot]];
    
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Initializes an instance of this, this function is used only when the user plays the app for the first time.
-(void)insertManagedGlobalInfo:(Boolean)playedBefore: (NSInteger)cumulativeScore
{
    NSManagedObjectContext *context = [self managedObjectContext];
    GlobalInfo *info = (GlobalInfo*)[NSEntityDescription insertNewObjectForEntityForName:@"GlobalInfo" inManagedObjectContext:context];
    [info setValue:[NSNumber numberWithBool:playedBefore] forKey:@"gamePlayedBefore"];
    [info setValue:[NSNumber numberWithInteger:cumulativeScore] forKey:@"cumulativeScore"];
        
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Retrieves a stored Boolean to see if the user has played a game before
-(NSArray*)getManagedGlobalInfo;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"GlobalInfo" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
        NSLog(@"Array is empty");
        return [NSArray array];
    }
    return array;
}

//Changes the stored Boolean to say that either the user has played a game before or hasn't.  This will later be used to either display starting out instructions in GameVC or not.
-(void)changeManagedGlobalInfo:(Boolean)info
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSLog(@"Changing information for this boolean");
    NSArray *allInfo = [self getManagedGlobalInfo];
    if (allInfo.count != 0)
    {
        [allInfo[0] setValue:[NSNumber numberWithBool:info] forKey:@"gamePlayedBefore"];
    }
    
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Changes the score value for all time.  This score stores how many points the user has accumulated on the device.
-(void)changeManagedGlobalInfoScore:(NSInteger)score
{
    NSLog(@"Changing Score Function is reached.  YEEHAW!");
    NSManagedObjectContext *context = [self managedObjectContext];
    NSArray *allInfo = [self getManagedGlobalInfo];
    if (allInfo.count != 0)
    {
        NSInteger oldScore = [[allInfo[0] valueForKey:@"cumulativeScore"] integerValue];
        NSInteger newScore = oldScore+score;
        [allInfo[0] setValue:[NSNumber numberWithInteger:newScore] forKey:@"cumulativeScore"];
    }
    
    NSError *error;
    
    if (![context save:&error])
    {
        NSLog(@"Error saving");
    }
}

//Pushes a new view controller and clears the stack each time.
-(void)goToScreen:(NSString *)screen
{
    if ([screen isEqualToString:@"scGameViewController"])
    {
        [gameVC removeFromParentViewController];
        navigatorVC.viewControllers = nil;
        gameVC = nil;
        gameVC = [[scGameViewController alloc] init];
        [[self gameVC] setMenuDelegate:self];
        
        [UIView beginAnimations:@"toGame" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:navigatorVC.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.1];
        NSLog(@"Mode is %i", [menuVC mode]);
        [gameVC setMode:[menuVC mode]];
        [navigatorVC pushViewController:gameVC animated:YES];
        [UIView commitAnimations];
    }
    else if ([screen isEqualToString:@"scHighScoresViewController"])
    {
        navigatorVC.viewControllers = nil;
        
        [UIView beginAnimations:@"toHighScores" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:navigatorVC.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.1];
        [navigatorVC pushViewController:highScoresVC animated:YES];
        [UIView commitAnimations];
    }
    else if ([screen isEqualToString:@"scViewController"])
    {
        navigatorVC.viewControllers = nil;
        [UIView beginAnimations:@"toMenu" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:navigatorVC.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.1];
        [navigatorVC pushViewController:menuVC animated:YES];
        [UIView commitAnimations];
    }
    else if ([screen isEqualToString:@"ccrHighScoresDetailViewController"])
    {
        navigatorVC.viewControllers = nil;
        [UIView beginAnimations:@"toHighScoresDetail" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:navigatorVC.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.1];
        [navigatorVC pushViewController:highScoresDetailVC animated:YES];
        [highScoresDetailVC setEventNumber:self.eventNumber];
        [highScoresDetailVC setTotalEvent:[self getManagedTotalScores][eventNumber]];
        [UIView commitAnimations];
    }
    else if ([screen isEqualToString:@"ccrInfoViewController"])
    {
        navigatorVC.viewControllers = nil;
        [UIView beginAnimations:@"toInfoView" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:navigatorVC.view cache:NO];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.1];
        [navigatorVC pushViewController:infoVC animated:YES];
        [UIView commitAnimations];
    }
}

-(void)setMode:(NSInteger)difficulty
{
    self.mode = difficulty;
}

-(NSInteger)getMode
{
    return self.mode;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"scNewSurferCats" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"scNewSurferCats.sqlite"];
    
    //[[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
