//
//  solicitudesViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 12/7/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface solicitudesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate, UITextFieldDelegate>{
    NSString *aSesion;
    IBOutlet UIActivityIndicatorView *reloj;
    IBOutlet UIView *vistareloj;
    NSMutableData *responseData;
    NSMutableArray *array;
    IBOutlet UITableView *mytableview;
}
- (IBAction)cancel:(id)sender;
@end
