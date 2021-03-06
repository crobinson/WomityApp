//
//  AppDelegate.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/9/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "AppDelegate.h"
#import "Flurry.h"
#import "MDMultipleMasterDetailManager.h"

@implementation AppDelegate

@synthesize masterDetailManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
     [Flurry startSession:@"4F5B2TF8Q7VH5NKHQ3J5"];
    
   // self.window.frame = CGRectMake(0, -100, 320, 480);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //iPad
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"id"] == NULL){
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
            self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        }else{
            UISplitViewController * splitViewController = [storyboard instantiateViewControllerWithIdentifier:@"split"];
        
            //Medida de menu en ancho e inclusión de Gestures al menu
            [splitViewController setValue:[NSNumber numberWithFloat:235.0] forKey:@"_masterColumnWidth"];
            if ([splitViewController respondsToSelector:@selector(setPresentsWithGesture:)])
                [splitViewController setPresentsWithGesture:YES];
        
            //Decisión de vista principal segun identificador  del Storyboard elegido.
            UIViewController* detail2 = [splitViewController.storyboard instantiateViewControllerWithIdentifier:@"home"];
        
            //Crecion del masterDetailManager = Permite el cambio de vista principal desde el menu para el contenedor del splitViewController
            self.masterDetailManager = [[MDMultipleMasterDetailManager alloc] initWithSplitViewController:splitViewController
                                                                            withDetailRootControllers:[NSArray arrayWithObjects:detail2,nil]];
        
            //Definición del RootViewController  o vista Raiz
            self.window.rootViewController =splitViewController;
            
        }
        
    }
    
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    
	NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", newToken);
	[[NSUserDefaults standardUserDefaults] setValue:newToken  forKey:@"deviceToken"];
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
	//[self addMessageFromRemoteNotification:userInfo updateUI:YES];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
