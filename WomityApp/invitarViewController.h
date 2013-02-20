//
//  invitarViewController.h
//  Womity
//
//  Created by Carlos Robinson on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AmigosCrearViewController.h"
#import "ContactsViewController.h"
#import "popViewContainer.h"

@class popViewContainer;

@protocol invitarViewControllerDelegate <NSObject>


@end
@interface invitarViewController : UIViewController <UITextFieldDelegate, AmigosCrearViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate, ABUnknownPersonViewControllerDelegate, UIWebViewDelegate, UITextViewDelegate, UITabBarControllerDelegate, ContactsViewControllerDelegate, popViewControllerDelegate>
{
    
    NSMutableData *responseData;
    NSMutableString *otrosamigos;
    IBOutlet UILabel *womityName;
    NSMutableArray *arrayContacts;
    BOOL ishide;
    
    BOOL isHidePrincipal;
    NSMutableDictionary *datawomit;

    IBOutlet UIView *vistagris1;
    IBOutlet UIView *vistagris4;
    IBOutlet UIView *vistagris3;
    IBOutlet UIView *vistagris2;
    UITapGestureRecognizer *Taptable;
    popViewContainer *popoverController;
    IBOutlet UIView *vistareloj;
    IBOutlet UIActivityIndicatorView *reloj;
}
@property (assign, nonatomic) BOOL espasotres;
@property (strong, nonatomic) IBOutlet UIButton *boton2;
@property (strong, nonatomic) IBOutlet UIButton *boton1;
@property (strong, nonatomic) IBOutlet UILabel *mensaje3;
@property (strong, nonatomic) IBOutlet UILabel *mensaje2;
@property (strong, nonatomic) IBOutlet UILabel *mensaje1;
/*@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (weak, nonatomic) IBOutlet UITextView *italicmails;
@property (weak, nonatomic) IBOutlet UITextField *mensajeLabel;
@property (weak, nonatomic) IBOutlet UITextField *correosLabel;*/
@property (strong, nonatomic) IBOutlet UIWebView *mywebview;
@property (strong, nonatomic) IBOutlet UITextField *mensajeLabel;
@property (weak, nonatomic) IBOutlet UITextView *correosLabel;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
 @property (strong, nonatomic) NSString *stringTitle;
@property (strong, nonatomic) NSString *aSesion;
@property (strong, nonatomic) NSString *idWomit;
@property (strong, nonatomic) NSMutableArray *idsamigos; 
@property (strong, nonatomic) IBOutlet UIScrollView *myscroll;
@property (assign, nonatomic) BOOL notscroll;
@property (nonatomic, weak) id <invitarViewControllerDelegate> delegate;
/*- (IBAction)cancel:(id)sender;
- (IBAction)siguiente:(id)sender;
- (IBAction)showPeoplePickerController:(id)sender;
- (IBAction)done:(id)sender;*/
-(IBAction)ShowSettings:(id)sender;
- (IBAction)showPeoplePickerController:(id)sender;
- (IBAction)cancelado:(id)sender;
-(IBAction)enviar:(id)sender;
-(IBAction)cerrar:(id)sender;
-(IBAction)volver:(id)sender;
-(IBAction)volvervolver:(id)sender;
- (IBAction)loadtipoA:(id)sender;
- (IBAction)loadtipoB:(id)sender;
- (IBAction)loadtipoF:(id)sender;
- (IBAction)perfil:(id)sender;
- (IBAction)ayuda:(id)sender;
- (IBAction)amigos:(id)sender;
-(IBAction) Loadcrear:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end
