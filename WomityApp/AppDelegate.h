//
//  AppDelegate.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/9/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDMultipleMasterDetailManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) MDMultipleMasterDetailManager* masterDetailManager;

@end
