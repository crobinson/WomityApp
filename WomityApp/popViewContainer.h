//
//  popViewContainer.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/30/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class popViewController;

@protocol popViewControllerDelegate <NSObject>
//- (void)ContactsDidCancel:(ContactsViewController *)controller;
- (void)popNavegar:(NSMutableDictionary *)womit;
@end

@protocol popViewContainer<NSObject>

- (void)viewWasTouched;

@end

@interface popViewContainer : UIView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableview;
    NSArray *womities;
    NSMutableData * responseData;
    UIActivityIndicatorView *loading;
    int selectedRow;
    NSMutableDictionary *datadiccionario;
}
@property (nonatomic, weak) id <popViewControllerDelegate> delegate;
@property (nonatomic, strong) UITabBarController *tabBarController;

-(void)fadeOFFEmergency;
@end
