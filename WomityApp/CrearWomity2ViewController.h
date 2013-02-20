//
//  CrearWomity2ViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez on 17/11/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "popViewContainer.h"
#import "urlViewController.h"

@class popViewContainer;

@interface CrearWomity2ViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate, urlViewControllerDelegate>{
    NSData *image;
    NSString *siguiente;
    int counter;
    int tamanotable;
    NSDictionary *dictionary;
    NSMutableArray *array;
    int rowChange;
    IBOutlet UITableViewCell *webViewBK;
    IBOutlet UILabel *counterLabel;
    IBOutlet UITableViewCell *nameView;
    IBOutlet UITableViewCell *imagenView;
    UITapGestureRecognizer *Taptable;
    NSDictionary *datawomit2;
    NSMutableDictionary *datawomit;
    NSURL *urlfinal;
    
    IBOutlet UIButton *botonfinalizar;
    IBOutlet UIButton *botonguardar;
    IBOutlet UIActivityIndicatorView *relojimagen;
    BOOL ishide;
    BOOL isHidePrincipal;
    BOOL reload;
    BOOL reloadtable;

    IBOutlet UIButton *botoncerrar;
    IBOutlet UITableViewCell *descriptionView;
    popViewContainer *popoverController;
}
@property (strong, nonatomic) IBOutlet UIButton *botoncerrar;
@property (weak, nonatomic) IBOutlet UIImageView *imagengrande;
@property (weak, nonatomic) IBOutlet UIView *vistaimagen;
@property (weak, nonatomic) IBOutlet UITextField *placeholder2;
@property (weak, nonatomic) IBOutlet UITextField *placeholder1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (weak, nonatomic) IBOutlet UIView *vistareloj;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *womityname;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *fofoOpcion;
@property (weak, nonatomic) IBOutlet UITextField *nombreLabel;
@property (weak, nonatomic) IBOutlet UITextView *descripcionLabel;
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) NSString *aSesion;
@property (strong, nonatomic) NSString *idWomit;
@property (weak, nonatomic) IBOutlet UITextField *imagenLabel;
@property (weak, nonatomic) IBOutlet UITextField *webLabel;
@property (weak, nonatomic) IBOutlet UITextField *otrosLabel;
@property (weak,nonatomic) IBOutlet UIImageView *imagePhoto;

@property (strong, nonatomic) NSDictionary *opcion;
@property (nonatomic,strong) NSString *stringTitle;

- (IBAction)cerrarimagen:(id)sender;
- (IBAction)verimagen:(id)sender;

- (IBAction)gotoweb:(id)sender;
- (IBAction)siguiente:(id)sender;

-(void)CallModify:(id)sender;
-(void)CallDelete:(id)sender;

-(IBAction)ShowSettings:(id)sender;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
-(IBAction) Loadcrear:(id)sender;
-(IBAction)volver:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
