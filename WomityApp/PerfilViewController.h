//
//  PerfilViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"
@class popViewContainer;

@interface PerfilViewController : UIViewController<UITabBarControllerDelegate, popViewControllerDelegate>
{
    NSMutableArray *arraySexo;
    NSMutableArray *arrayFecha;
    NSString *aSesion;
    NSData *image;
    IBOutlet UIScrollView *scrollview;
    popViewContainer *popoverController;
    NSMutableDictionary *datawomitnew;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *fotoview;
@property (strong, nonatomic) IBOutlet UIImageView *foto;
@property (strong, nonatomic) IBOutlet UIButton *botonfoto;
@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *apellido;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker;
@property (strong, nonatomic) IBOutlet UIView *vistaPicker2;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerFecha;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView2;
@property (strong, nonatomic) IBOutlet UILabel *sexoLabel;
@property (strong, nonatomic) IBOutlet UILabel *fecnacLabel;
@property (strong, nonatomic) IBOutlet UIImageView *myScrollView;
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UITextField *sexoCampo;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UITextField *fechaCampo;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda1;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda2;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda3;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda4;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda6;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UITableViewCell *celda5;
- (IBAction)quitarPickerDone2:(id)sender;
- (IBAction)mostrarPicker2:(id)sender;
- (IBAction)quitarPickerDone:(id)sender;
- (IBAction)mostrarPicker:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end
