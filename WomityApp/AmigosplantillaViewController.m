//
//  AmigosplantillaViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "AmigosplantillaViewController.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"
#import "ContactsViewController.h"
#import "AyudaViewController.h"

@interface AmigosplantillaViewController ()

@end

@implementation AmigosplantillaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
     [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    UITabBarController *tabBarController = self.tabBarController;
    [[NSUserDefaults standardUserDefaults] setValue:@"enviar" forKey:@"invitar"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)volver:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onButtonClick:(UIButton *)button {
	
    if (popoverController == nil){
        popoverController = [[popViewContainer alloc] initWithFrame:CGRectMake(90, 30, 239, 390)];
        popoverController.delegate = self;
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

- (void)popNavegar:(NSMutableDictionary *)womit{
    datawomitnew = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomitnew;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomitnew objectForKey:@"idWomity"];
        
    }
    
    if ([segue.identifier isEqualToString:@"comofunciona"]){
        AyudaViewController *controller = [segue destinationViewController];
        controller.bandera = YES;
        
        
    }
    
    

if ([segue.identifier isEqualToString:@"listcontactos"])
{
    ContactsViewController  *AmigosCrearViewController =  [segue destinationViewController];
    AmigosCrearViewController.bandera = NO;
    AmigosCrearViewController.delegate = self;
}

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController);
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}

@end
