//
//  selcontactosViewController.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class popViewContainer;

@interface selcontactosViewController : UIViewController{
    NSMutableData *responseData;
    popViewContainer *popoverController;
}
@property (strong, nonatomic) IBOutlet UITextView *mensajeText;
@property (strong, nonatomic) NSString *mensaje;
@property (strong, nonatomic) NSString *aSesion;
@property (strong, nonatomic) NSString *idWomit;
@property (strong, nonatomic) NSString *contactos;
@property (strong, nonatomic) NSString *otros;
-(IBAction)enviar:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
-(IBAction)siguiente:(id)sender;
@end
