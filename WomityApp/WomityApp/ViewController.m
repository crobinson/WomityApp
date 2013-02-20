//
//  ViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/9/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"id"] == NULL){
        [self performSegueWithIdentifier:@"gotoLogin" sender:self];
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
