//
//  AppDelegate.m
//  ColorTeaser
//
//  Created by ABHIJIT RANA on 07/06/15.
//  Copyright (c) 2015 ABHIJIT RANA. All rights reserved.
//

#import "AppDelegate.h"
#import <SpriteKit/SpriteKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationWillResignActive:(UIApplication *)application{
    
    
    SKView *view = (SKView *)self.window.rootViewController.view;
    view.paused = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    
    SKView *view = (SKView *)self.window.rootViewController.view;
    view.paused = NO;
}
@end
