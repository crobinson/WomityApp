//
//  ModificarOpcionViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "popViewContainer.h"
#import "urlViewController.h"

@class popViewContainer;

@interface ModificarOpcionViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, popViewControllerDelegate, urlViewControllerDelegate>{
    NSData *image;
    IBOutlet UITableViewCell *webViewBK;
    IBOutlet UILabel *counterLabel;
    IBOutlet UITableViewCell *nameView;
    IBOutlet UITableViewCell *imagenView;
    popViewContainer *popoverController;
    NSDictionary *datawomitnew;
    IBOutlet UITableViewCell *descriptionView;
    UITapGestureRecognizer *tapScroll;
}

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
@property (weak,nonatomic) IBOutlet NSDictionary *datawomit;
@property (strong, nonatomic) NSDictionary *opcion;
@property (nonatomic,strong) NSString *stringTitle;

- (IBAction)cancel:(id)sender;
- (IBAction)quitarPickerDone:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;

@end
