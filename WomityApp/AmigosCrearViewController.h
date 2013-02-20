//
//  AmigosCrearViewController.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AmigosCrearViewController;

@protocol AmigosCrearViewControllerDelegate <NSObject>
- (void)AmigosCrearViewControllerDidCancel:
(AmigosCrearViewController *)controller;
- (void)AmigosViewControllerAgregar:(NSMutableArray *)idamigo deAmigos:(NSMutableArray *)mailamigos;
@end

@class popViewContainer;

@interface AmigosCrearViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UIActivityIndicatorView *relojimagen;
    NSMutableArray *amigos;
    NSMutableData *responseData;
    NSString *aSesion;
    NSString *databaseName;
	NSString *databasePath;
    NSMutableArray *idamigos;
    NSMutableArray *mailamigos;
    IBOutlet UIButton *botoncerrar;
    IBOutlet UIButton *cerrarboton;
    IBOutlet UIView *vistaimagen;
    NSMutableDictionary *tableData;
    NSMutableArray *contactnumberArray;
    NSMutableArray *arrayChekList;
    NSMutableArray *dictionaryData;
    NSMutableArray *arraySection;
    NSMutableArray*   arrayLetter;
    popViewContainer *popoverController;
    
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistarelopj;
@property (nonatomic, weak) id <AmigosCrearViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)agregar:(id)sender;
- (IBAction)cerrarimagen:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
