//
//  emailImporterViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"

@class popViewContainer;

@interface emailImporterViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate>{

    IBOutlet UIView *passViewCorner;
    IBOutlet UIView *emailViewCorner;
    IBOutlet UIView *viewServiceCorner;
    IBOutlet UIPickerView *Picker;
    IBOutlet UIView *viewContainer;
    IBOutlet UIButton *btn;
    IBOutlet UITextField *passTextField;
    IBOutlet UITextField *emailTextField;
    IBOutlet UILabel *chooseServerLabel;
    NSMutableDictionary *datawomitnew;
    NSMutableArray *array;
    popViewContainer *popoverController;
}
- (IBAction)hidePicker:(id)sender;
- (IBAction)mostrarPicker:(id)sender;
- (IBAction)Done:(id)sender;

- (IBAction)onButtonClick:(UIButton *)button;
@end
