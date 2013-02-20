//
//  VotarViewController.h
//  WomityApp
//
//  Created by Carlos Robinson on 11/18/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"
@class popViewContainer;

@interface VotarViewController : UIViewController<UITabBarControllerDelegate, popViewControllerDelegate>{
    NSString *idOpcion;
    NSString *voto;
    NSMutableDictionary *json;
    NSMutableArray *arrayVotos;
    NSString *idOpcionseleccionada;
    NSDictionary *datawomitnew;
    popViewContainer *popoverController;
    IBOutlet UIActivityIndicatorView *relojimagen;
}
@property (weak, nonatomic) IBOutlet UIButton *botoncerrar;
@property (weak, nonatomic) IBOutlet UIView *vistaimagen;
@property (weak, nonatomic) IBOutlet UIButton *bocadillo;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (weak, nonatomic) IBOutlet UIView *vistareloj;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (nonatomic, strong) NSString *aSesion;
@property (strong, nonatomic) NSString *idWomity;
@property (strong, nonatomic) NSDictionary *datawomit;
@property (nonatomic, strong) NSMutableData *responseData;

- (IBAction)onButtonClick:(UIButton *)button;
- (IBAction)cerrarimagen:(id)sender;


-(IBAction) goBack;

@end
