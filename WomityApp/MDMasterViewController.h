//
//  MDMasterViewController.h
//  MultipleMasterDetailViews
//
//  Created by Todd Bates on 11/14/11.
//  Copyright (c) 2011 Science At Hand LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDDetailViewController,Noticia;

@interface MDMasterViewController : UITableViewController{

    NSMutableArray *array;
    NSString *detailtemporal;
    
}

@property (strong, nonatomic) MDDetailViewController *detailViewController;

@end
