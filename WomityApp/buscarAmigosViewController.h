//
//  buscarAmigosViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class popViewContainer;

@interface buscarAmigosViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate, UITextFieldDelegate>{
    NSArray *arraycontactos;
    NSMutableString * idstring;
    __weak IBOutlet UILabel *resut;
    NSMutableArray *arrayseleccionados;
    __weak IBOutlet UILabel *contador;
    
    NSMutableArray *contactnumberArray;
    NSMutableArray *arrayChekList;
    NSMutableArray *dictionaryData;
    NSMutableArray *arraySection;
    NSMutableArray*   arrayLetter;
    popViewContainer *popoverController;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *vistareloj;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
@property (weak, nonatomic) IBOutlet UITableViewCell *vistacell;
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) IBOutlet UITextField *textoBuscar;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSString * aSesion;
-(IBAction)enviar:(id)sender;
-(IBAction)anadir:(id)sender;
-(IBAction)buscar:(id)sender;
-(IBAction)volver:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
@end
