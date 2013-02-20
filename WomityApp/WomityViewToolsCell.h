//
//  WomityViewToolsCell.h
//  Womity
//
//  Created by Eduardo Rodriguez Macmini on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WomityViewToolsCell : UITableViewCell<UIGestureRecognizerDelegate>{

    UIView *View1; // Up
    UIView *View2; // Middle Tools
    UIView *View3; // Remove Option
    
    UIButton *boton1;
    UIButton *boton2;
    UIButton *boton4;
    UIButton *boton3;
    UIImageView *imagen;
    IBOutlet UILabel *nameLabel;
    BOOL toolsON;
    BOOL killON;
    BOOL isHidePrincipal;
    
    
}
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) UIView *View1; 
@property (nonatomic, strong) UIView *View2; 
@property (nonatomic, strong) UIView *View3;
@property (nonatomic, strong) UIView *vistagris;
@property (nonatomic, strong) UIButton *boton1;
@property (nonatomic, strong) UIButton *boton2;
@property (nonatomic, strong) UIButton *boton3;
@property (nonatomic, strong) UIButton *boton4;
@property (nonatomic, strong) UIButton *boton5;
-(void)navegar:(id) sender;
-(void)navegar2:(id) sender;
-(void)navegar3:(id) sender;
-(void)navegar4:(id) sender;
-(void)touchrealizado;
@end
