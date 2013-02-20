//
//  OptionCell.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CrearWomity2ViewController;

@interface OptionCell : UITableViewCell{

}
@property (strong, nonatomic) IBOutlet UIView *vistagris;
@property (strong, nonatomic) IBOutlet UIImageView *fotothumb;
@property (strong, nonatomic) IBOutlet UILabel *counter;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *webtitulo;
@property (strong, nonatomic) IBOutlet UITextView *cescription;
@property (strong, nonatomic) IBOutlet UILabel *link;
@property (strong, nonatomic) CrearWomity2ViewController *viewController;
@property (strong, nonatomic) IBOutlet UIButton *DeleteCell;
@property (strong, nonatomic) IBOutlet UIButton *modify;
@property (strong, nonatomic) IBOutlet UIButton *gotoweb;
@property (strong, nonatomic) IBOutlet UIButton *gotoimg;
@property (assign, nonatomic) int row;


- (IBAction)modifyAction:(id)sender;
- (IBAction)deleteAction:(id)sender;



@end
