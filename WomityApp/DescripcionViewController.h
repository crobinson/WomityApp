//
//  DescripcionViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/16/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"

 @class popViewContainer;

@interface DescripcionViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate, UIWebViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate,UIAlertViewDelegate>{
    BOOL ishide;
    BOOL reloadPage;
    BOOL isHidePrincipal;
    int modificarTag;
    int borradorTag;
    int finalizadoTag;
    NSString * tipo;
    IBOutlet UIButton *botoncerrar;
    NSMutableArray *dataopciones;
    NSDictionary *datawomitnew;
    BOOL yahevotado;
    NSURL *urlfinal;
    
    UIAlertView *alertOpcion;
    UIAlertView *alertBorrador;
   UIAlertView *alertFinalizado;
    UITapGestureRecognizer *tapScroll;
    popViewContainer *popoverController;
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *relojimagen;
@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIView *vistaimagen;
@property (weak, nonatomic) IBOutlet UIButton *botonVotar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (weak, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) NSDictionary *datawomit;
@property (nonatomic, strong) NSString *aSesion;
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (strong, nonatomic) NSString *idWomity;
@property (strong, nonatomic) IBOutlet UITextField *campocomentario;
@property (assign, nonatomic) BOOL comentar;
-(IBAction)goBack;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
-(IBAction) Loadcrear:(id)sender;
- (IBAction)gobackbaby:(id)sender;
- (IBAction)cerrarimagen:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end
