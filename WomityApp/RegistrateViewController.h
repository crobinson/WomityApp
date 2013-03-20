//
//  RegistrateViewController.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class RegistrateViewController;

@protocol RegistrateViewControllerDelegate <NSObject>
- (void)RegistrateViewControllerRegistrarse:
(RegistrateViewController *)controller;
- (void)RegistrateViewControllerDidCancel:
(RegistrateViewController *)controller;
@end

@interface RegistrateViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    NSData *image;

    IBOutlet UIActivityIndicatorView *reloj;
    IBOutlet UIView *vista8;
    IBOutlet UIView *vista7;
    IBOutlet UIView *vista6;
    IBOutlet UIView *vista5;
    IBOutlet UIView *vista4;
    IBOutlet UIView *vista3;
    IBOutlet UIView *vista2;
    IBOutlet UIView *vista1;
    NSMutableArray *arraySexo;
    NSMutableArray *arrayFecha;
    UIInterfaceOrientation orientacion;
    IBOutlet UIImageView *imageview;
    IBOutlet UITextView *privacidad;
    IBOutlet UIButton *butonfecha;
    IBOutlet UIButton *butonsexo;
    IBOutlet UIImageView *fechasexo;
    IBOutlet UIImageView *fechafecha;
}
@property (strong, nonatomic) IBOutlet UITextField *fechacampo;
@property (strong, nonatomic) IBOutlet UITextField *sexoCampo;
@property (strong, nonatomic) IBOutlet UIImageView *fotoopcion;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
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
- (IBAction)verayudas:(id)sender;
@end
