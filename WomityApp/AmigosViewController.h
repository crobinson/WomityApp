//
//  AmigosViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"

@class popViewContainer;

@interface AmigosViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate>{
    NSMutableArray *amigos;
    NSMutableData *responseData;
    IBOutlet UILabel *solicitudescont;
    NSString *aSesion;
    NSString *databaseName;
	NSString *databasePath;
    BOOL ishide;
    BOOL isHidePrincipal;
    IBOutlet UIView *vistaimagen;
    IBOutlet UIButton *botoncerrar;
    NSMutableDictionary *datawomitnew;
    popViewContainer *popoverController;
    NSMutableArray *arrayChekList;
    NSMutableArray *dictionaryData;
    NSMutableArray *arraySection;
    NSMutableArray*   arrayLetter;

    IBOutlet UIActivityIndicatorView *relojimagen;
}

@property (weak, nonatomic) IBOutlet UIView *myview;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
-(IBAction)buscar:(id)sender;
-(IBAction)ShowSettings:(id)sender;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
-(IBAction) Loadcrear:(id)sender;
-(IBAction)eliminarcontacto:(id)sender;
- (IBAction)cerrarimagen:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end