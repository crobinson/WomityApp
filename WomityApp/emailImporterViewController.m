//
//  emailImporterViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "emailImporterViewController.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface emailImporterViewController ()

@end

@implementation emailImporterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController);
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;

	// Do any additional setup after loading the view.
    
    emailViewCorner.layer.cornerRadius = 10;
    passViewCorner.layer.cornerRadius = 10;
    viewServiceCorner.layer.cornerRadius = 10;
    
    array = [[NSMutableArray alloc] init];
    [array addObject:@"Gmail"];
    [array addObject:@"Yahoo"];
}

- (IBAction)mostrarPicker:(id)sender{

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [viewContainer setFrame:CGRectMake(0,204,320,257)];
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hidePicker:(id)sender {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [viewContainer setFrame:CGRectMake(0,480,320,257)];
    [UIView commitAnimations];
    
    [passTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
}

- (IBAction)Done:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thepicker {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        NSString *string = [array objectAtIndex:row];
    NSLog(@"%@",string);
        return string;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

        chooseServerLabel.text = [array objectAtIndex:row];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if( textField== emailTextField)
    {
        [passTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
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
}


@end
