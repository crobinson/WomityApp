//
//  ContactsViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/29/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AddressBook/AddressBook.h>

@class ContactsViewController;

@protocol ContactsViewControllerDelegate <NSObject>
- (void)ContactsDidCancel:(ContactsViewController *)controller;
- (void)ContactsAgregar:(NSMutableArray *)idamigo deAmigos:(NSMutableArray *)mailamigos;
@end

@class popViewContainer;


@interface ContactsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITabBarControllerDelegate>{
    IBOutlet UITableView *tableView;
    NSMutableArray *contactnumberArray;
    NSMutableArray *arrayChekList;
    NSMutableArray *dictionaryData;
    NSMutableArray *arraySection;
    NSMutableData *responseData;
    NSMutableArray *mailamigos;
    NSMutableString *otrosamigos;
    popViewContainer *popoverController;
}
@property (nonatomic, weak) id <ContactsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) NSString *aSesion;
@property (assign, nonatomic) BOOL bandera;
- (IBAction)Done:(id)sender;
-(IBAction)enviar:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
