//
//  AppDelegate.m
//  SoundSpot
//
//  Created by Ipalibo Whyte on 10/08/2014.
//  Copyright (c) 2014 SweetKeyNotes. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"mDA7bQa2LW2Eixfn7D4YWfyeDLTiBgVGf5Fba7oL"
                  clientKey:@"lEY8KBtuFJi76EDPdLLsgbVfKuW524MYgGeCwbTr"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self createNew];

    self.landingViewController = [[LandingViewController alloc] init];
    self.nVC = [[UINavigationController alloc] initWithRootViewController:self.landingViewController];
    self.nVC.navigationBar.barTintColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100.f, 0) forBarMetrics:UIBarMetricsDefault];
    self.nVC.navigationBar.tintColor = [UIColor whiteColor];
    self.nVC.navigationBar.translucent = NO;
    
    [self.window setRootViewController:self.nVC];
    [self.window makeKeyAndVisible];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
        [self.nVC presentViewController:self.navBarController animated:NO completion:nil];
        
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)createNew
{
    // Initialize tab controllers.  with each tab has its own navigation controller
    ProfileViewController *profileViewController =[[ProfileViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:profileViewController];
    nav1.navigationBar.barTintColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100.f, 0) forBarMetrics:UIBarMetricsDefault];
    nav1.navigationBar.tintColor = [UIColor whiteColor];
    nav1.navigationBar.translucent = NO;
    
    DiscoverViewController *discoverViewController=[[DiscoverViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:discoverViewController];
    nav2.navigationBar.barTintColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100.f, 0) forBarMetrics:UIBarMetricsDefault];
    nav2.navigationBar.tintColor = [UIColor whiteColor];
    nav2.navigationBar.translucent = NO;
    
    RecievedViewController *recievedViewController = [[RecievedViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:recievedViewController];
    nav3.navigationBar.barTintColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100.f, 0) forBarMetrics:UIBarMetricsDefault];
    nav3.navigationBar.tintColor = [UIColor whiteColor];
    nav3.navigationBar.translucent = NO;
    
    // initialize tabbarcontroller and set your viewcontrollers.
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers=[NSArray arrayWithObjects:nav1,nav2,nav3, nil];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.133 green:0.192 blue:0.247 alpha:1]];
    self.tabBarController.tabBar.translucent = NO;
    
    // Set images considering retina display screens
    
    float scaleTabbarIconBy = 1.0;
    
    UIImage *unselectedImageIcon;
    CGImageRef cgimageUnselected = unselectedImageIcon.CGImage;
    unselectedImageIcon = [UIImage imageWithCGImage:cgimageUnselected scale:2.0 orientation:UIImageOrientationUp];
    
    UIImage *selectedImageIcon;
    CGImageRef cgimageSelected = selectedImageIcon.CGImage;
    selectedImageIcon = [UIImage imageWithCGImage:cgimageSelected scale:2.0 orientation:UIImageOrientationUp];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        //Retina display
        scaleTabbarIconBy = 2.0;
        
    } else {
        // non-Retina display
        scaleTabbarIconBy = 1.0;
        
    }
    
    // Profile
    unselectedImageIcon = [UIImage imageNamed:@"profileUnselected.png"];
    cgimageUnselected = unselectedImageIcon.CGImage;
    unselectedImageIcon = [UIImage imageWithCGImage:cgimageUnselected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    selectedImageIcon = [UIImage imageNamed:@"profileSelected.png"];
    cgimageSelected = selectedImageIcon.CGImage;
    selectedImageIcon = [UIImage imageWithCGImage:cgimageSelected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setFinishedSelectedImage:selectedImageIcon withFinishedUnselectedImage:unselectedImageIcon];
    
    // Discover
    unselectedImageIcon = [UIImage imageNamed:@"discoverUnselected.png"];
    cgimageUnselected = unselectedImageIcon.CGImage;
    unselectedImageIcon = [UIImage imageWithCGImage:cgimageUnselected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    selectedImageIcon = [UIImage imageNamed:@"discoverSelected.png"];
    cgimageSelected = selectedImageIcon.CGImage;
    selectedImageIcon = [UIImage imageWithCGImage:cgimageSelected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    [[self.tabBarController.tabBar.items objectAtIndex:1] setFinishedSelectedImage:selectedImageIcon withFinishedUnselectedImage:unselectedImageIcon];
    
    // Recieved
    unselectedImageIcon = [UIImage imageNamed:@"recievedUnselected.png"];
    cgimageUnselected = unselectedImageIcon.CGImage;
    unselectedImageIcon = [UIImage imageWithCGImage:cgimageUnselected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    selectedImageIcon = [UIImage imageNamed:@"recievedSelected.png"];
    cgimageSelected = selectedImageIcon.CGImage;
    selectedImageIcon = [UIImage imageWithCGImage:cgimageSelected scale:scaleTabbarIconBy orientation:UIImageOrientationUp];
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] setFinishedSelectedImage:selectedImageIcon withFinishedUnselectedImage:unselectedImageIcon];
    
    // Inititalize Navigationcontroller and set root as tabbar.
    self.navBarController = [[UINavigationController alloc]initWithRootViewController:self.tabBarController];
    
    self.navBarController.navigationBar.hidden = YES;
}

+ (void)initialize;
{
    [SCSoundCloud  setClientID:@"ead7f88c56841accbd2e5a5a3148c36b"
                        secret:@"f6c699d1bc105566cbd56a170f830382"
                   redirectURL:[NSURL URLWithString:@"sampleproject://oauth"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    
}

- (void)finishedLoggin
{
   // self.navBarController = [[UINavigationController alloc]initWithRootViewController:landingviewcontroller];
    self.navBarController.navigationBar.barTintColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    self.navBarController.navigationBar.translucent = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
