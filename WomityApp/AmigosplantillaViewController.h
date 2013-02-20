//
//  AmigosplantillaViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"
@class popViewContainer;

@interface AmigosplantillaViewController : UIViewController<UITabBarControllerDelegate, UITabBarControllerDelegate, popViewControllerDelegate>{
    popViewContainer *popoverController;
    NSMutableDictionary *datawomitnew;
}
-(IBAction)volver:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end
