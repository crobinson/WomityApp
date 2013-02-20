//
//  Amigos2ViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class popViewContainer;

@interface Amigos2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *amigos;
    NSMutableData *responseData;
    NSString *aSesion;
    NSString *databaseName;
	NSString *databasePath;
    NSMutableArray *idamigos;
    popViewContainer *popoverController;
}
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;

-(IBAction)buscar:(id)sender;
-(IBAction)eliminarcontacto:(id)sender;

@end
