//
//  CrearWomity1ViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/16/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "popViewContainer.h"


@class popViewContainer;

@interface CrearWomity1ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate>{
    NSMutableData *responseData;
    NSString *databaseName;
	NSString *databasePath;
    NSMutableArray *arrayColors;
    NSMutableArray *arrayHoras;
    NSMutableArray *arrayMinutos;
    NSDictionary* json;
    NSMutableDictionary *datawomit;
    UITapGestureRecognizer *Taptable;
    
    BOOL ishide;
    BOOL isHidePrincipal;
    
    
    IBOutlet UIView *vistagris2;
    IBOutlet UIView *vistagris1;
    popViewContainer *popoverController;
    
}
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickernuevo;
@property (weak, nonatomic) IBOutlet UIView *vistappal;
@property (strong, nonatomic) IBOutlet UITextField *placeholder1;
@property (strong, nonatomic) IBOutlet UITextField *placeholder2;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;

@property (strong, nonatomic) IBOutlet UITextField *name;
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

- (IBAction)mostrarPicker:(id)sender;
- (IBAction)mostrarPicker2:(id)sender;
- (IBAction)mostrarPicker3:(id)sender;
- (IBAction)quitarPickerDone:(id)sender;
- (IBAction)siguiente:(id)sender;
-(IBAction)ShowSettings:(id)sender;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

-(IBAction) Loadcrear:(id)sender;

@end
