//
//  ModificarWomityViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "popViewContainer.h"

@class popViewContainer;

@interface ModificarWomityViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate, popViewControllerDelegate>{
    NSMutableData *responseData;
    NSString *databaseName;
	NSString *databasePath;
    NSMutableArray *arrayColors;
    NSMutableArray *arrayHoras;
    NSMutableArray *arrayMinutos;
    NSDictionary* json;
    IBOutlet UIView *vistagris1;
    NSDictionary *datawomitnew;
    IBOutlet UIView *vistagris2;
    popViewContainer *popoverController;
    
}
@property (strong, nonatomic) IBOutlet UIView *vistappal;
@property (strong, nonatomic) IBOutlet UIView *vistablanca;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UITextView *descripcion;
@property (strong, nonatomic) IBOutlet UIButton *day;
@property (strong, nonatomic) IBOutlet UIButton *hour;
@property (strong, nonatomic) IBOutlet UIButton *minutes;
@property (strong, nonatomic) IBOutlet UISwitch *switch1;
@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UIPickerView *picker2;
@property (strong, nonatomic) IBOutlet UIPickerView *picker3;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker2;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker3;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) NSDictionary *datawomit;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (nonatomic, strong) NSString *aSesion;

- (IBAction)mostrarPicker:(id)sender;
- (IBAction)mostrarPicker2:(id)sender;
- (IBAction)mostrarPicker3:(id)sender;
- (IBAction)quitarPickerDone:(id)sender;
- (IBAction)siguiente:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
