//
//  RegistrateViewController.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistrateViewController;

@protocol RegistrateViewControllerDelegate <NSObject>
- (void)RegistrateViewControllerRegistrarse:
(RegistrateViewController *)controller;
- (void)RegistrateViewControllerDidCancel:
(RegistrateViewController *)controller;
@end

@interface RegistrateViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *arraySexo;
    NSMutableArray *arrayFecha;
    UIInterfaceOrientation orientacion;
}
@property (nonatomic, weak) id <RegistrateViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UITextField *nombreLabel;
@property (strong, nonatomic) IBOutlet UITextField *apellidoLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *email2Label;
@property (strong, nonatomic) IBOutlet UITextField *contrasenaLabel;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker2;
@property (strong, nonatomic) IBOutlet UIView *oickerView2;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerFecha;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView2;
@property (strong, nonatomic) IBOutlet UILabel *sexoLabel;
@property (strong, nonatomic) IBOutlet UILabel *fecnacLabel;
- (IBAction)cancel:(id)sender;
- (IBAction)registrarse:(id)sender;
- (IBAction)mostrarPicker:(id)sender;
- (IBAction)mostrarPicker2:(id)sender;
- (IBAction)quitarPickerDone:(id)sender;
- (IBAction)quitarPickerDone2:(id)sender;
@end
