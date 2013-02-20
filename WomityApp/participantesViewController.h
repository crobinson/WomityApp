//
//  participantesViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/13/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface participantesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UIView *vistareloj;
    IBOutlet UIActivityIndicatorView *reloj;
    NSMutableData *responseData;
    NSMutableArray *participantes;
}
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) NSDictionary *datawomit;
@end
