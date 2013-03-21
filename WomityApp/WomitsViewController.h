//
//  WomitsViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/15/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Twitter/Twitter.h>
#import "popViewContainer.h"


@class popViewContainer;

@interface WomitsViewController : UIViewController<UISplitViewControllerDelegate, UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate, UIWebViewDelegate,UIActionSheetDelegate, UITabBarControllerDelegate, popViewControllerDelegate>
{
    NSString * tipo;
    BOOL ishide;
    BOOL comentar;
    BOOL isHidePrincipal;
    int selectedRow;
    UIView *View1; // Up
    UIView *View2; // Middle Tools
    UIView *View3;
    NSMutableArray *dataopciones;
    NSDictionary *datawomitnew;
    NSMutableArray *alturas;
    UITapGestureRecognizer *Taptable;
    int seleccionadoborrar;
    popViewContainer *popoverController;
    IBOutlet UIActivityIndicatorView *relojimagen;
    UIAlertView *alertView;
}

@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (strong, nonatomic) IBOutlet UIButton *botoncerrar;
@property (weak, nonatomic) IBOutlet UIView *vistaimagen;
@property (nonatomic, strong) NSString *tipo;
@property (strong, nonatomic) NSString *idWomity;
@property (strong, nonatomic) NSDictionary *dataseleccionado;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *womities;
@property (nonatomic, strong) NSString *aSesion;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (weak, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) NSDictionary *datawomit;
@property (strong, nonatomic) NSDictionary *datawomitpop;
@property (strong, nonatomic) id detailItem;
- (IBAction)cerrarimagen:(id)sender;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
-(IBAction) Loadcrear:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
