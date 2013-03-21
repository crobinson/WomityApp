//
//  WomityViewToolsCell.m
//  Womity
//
//  Created by Eduardo Rodriguez Macmini on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WomityViewToolsCell.h"

@implementation WomityViewToolsCell
@synthesize nameLabel, boton1, boton2, boton3, boton4, boton5, View1, View2, View3, vistagris;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        isHidePrincipal = NO;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 768, 200);
            
            View1 = [[UIView alloc] initWithFrame:CGRectMake(-768, 10, self.frame.size.width, self.frame.size.height)];
            View1.backgroundColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1];
        
            View3 = [[UIView alloc] initWithFrame:CGRectMake(-768, 10, self.frame.size.width, self.frame.size.height)];
            View3.backgroundColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1];
        
            
            View2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width -20, 200)];
            View2.backgroundColor = [UIColor whiteColor];
            /* UIImageView *imageTools = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
             imageTools.image = [UIImage imageNamed:@"ToolsWomity.png"];
             [View1 addSubview:imageTools];
             */
            boton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton1.frame = CGRectMake(95, 50, 48, 65);
            //[boton1 addTarget:self action:@selector(navegar:) forControlEvents:UIControlEventTouchUpInside];
            boton1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Votarst"]];
            [View1 addSubview:boton1];
        
            boton2 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton2.frame = CGRectMake(250, 55, 67, 66);
            //[boton2 addTarget:self action:@selector(navegar2:) forControlEvents:UIControlEventTouchUpInside];
            boton2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Comentar"]];
            [View1 addSubview:boton2];
        
            boton3 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton3.frame = CGRectMake(425, 55, 43, 66);
            boton3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Invitar"]];
            //[boton3 addTarget:self action:@selector(navegar3:) forControlEvents:UIControlEventTouchUpInside];
            [View1 addSubview:boton3];
        
            boton4 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton4.frame = CGRectMake(585, 55, 68, 65);
            boton4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Compartir"]];
            //[boton4 addTarget:self action:@selector(navegar4:) forControlEvents:UIControlEventTouchUpInside];
            [View1 addSubview:boton4];
        
        
            boton5 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton5.frame = CGRectMake(125, 55, 73, 69);
            boton5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Eliminar"]];
            //[boton4 addTarget:self action:@selector(navegar4:) forControlEvents:UIControlEventTouchUpInside];
            [View3 addSubview:boton5];
        
            vistagris = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width-20, 20)];
            vistagris.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.frame.size.width - 45, 35)];
            nameLabel.text = @"Prueba";
            [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
            nameLabel.textColor = [UIColor redColor];
            nameLabel.backgroundColor = [UIColor clearColor];
            UIImageView *imagenthumb = [[UIImageView alloc] initWithFrame:CGRectMake(8, 35, 45, 45)];
            imagenthumb.image = [UIImage imageNamed:@"icono1.png"];
            [self addSubview:View2];
            [View2 addSubview:nameLabel];
            [View2 addSubview:imagenthumb];
            [View2 addSubview:vistagris];
        
        
      
            UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 40, self.frame.size.height - 32, 34, 34)];
            indicator.image = [UIImage imageNamed:@"arrowred.png"];
            [self addSubview:indicator];
        
            [self addSubview:View3];
            [self addSubview:View1];
        }else{
            View1 = [[UIView alloc] initWithFrame:CGRectMake(-320, 10, self.frame.size.width, 60)];
            View1.backgroundColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1];
            
            View3 = [[UIView alloc] initWithFrame:CGRectMake(-320, 10, self.frame.size.width, 60)];
            View3.backgroundColor = [UIColor colorWithRed:(229/255.0) green:(229/255.0) blue:(229/255.0) alpha:1];
            
            
            View2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width -20, 120)];
            View2.backgroundColor = [UIColor whiteColor];
            /* UIImageView *imageTools = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
             imageTools.image = [UIImage imageNamed:@"ToolsWomity.png"];
             [View1 addSubview:imageTools];
             */
            boton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton1.frame = CGRectMake(25, 30, 24, 37);
            //[boton1 addTarget:self action:@selector(navegar:) forControlEvents:UIControlEventTouchUpInside];
            boton1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconoVotar"]];
            [View1 addSubview:boton1];
            
            boton2 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton2.frame = CGRectMake(95, 35, 45, 33);
            //[boton2 addTarget:self action:@selector(navegar2:) forControlEvents:UIControlEventTouchUpInside];
            boton2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconoComentar"]];
            [View1 addSubview:boton2];
            
            boton3 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton3.frame = CGRectMake(175, 35, 27, 33);
            boton3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconoInvitar"]];
            //[boton3 addTarget:self action:@selector(navegar3:) forControlEvents:UIControlEventTouchUpInside];
            [View1 addSubview:boton3];
            
            boton4 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton4.frame = CGRectMake(235, 35, 45, 33);
            boton4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconoCompartir"]];
            //[boton4 addTarget:self action:@selector(navegar4:) forControlEvents:UIControlEventTouchUpInside];
            [View1 addSubview:boton4];
            
            
            boton5 = [UIButton buttonWithType:UIButtonTypeCustom];
            boton5.frame = CGRectMake(125, 35, 36, 38);
            boton5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconoEliminar"]];
            //[boton4 addTarget:self action:@selector(navegar4:) forControlEvents:UIControlEventTouchUpInside];
            [View3 addSubview:boton5];
            
            vistagris = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width-20, 20)];
            vistagris.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.frame.size.width - 45, 35)];
            nameLabel.text = @"Prueba";
            [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
            nameLabel.textColor = [UIColor redColor];
            nameLabel.backgroundColor = [UIColor clearColor];
            UIImageView *imagenthumb = [[UIImageView alloc] initWithFrame:CGRectMake(8, 35, 45, 45)];
            imagenthumb.image = [UIImage imageNamed:@"icono1.png"];
            [self addSubview:View2];
            [View2 addSubview:nameLabel];
            [View2 addSubview:imagenthumb];
            [View2 addSubview:vistagris];
            
            
            
            UIImageView *indicator = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 40, self.frame.size.height - 32, 34, 34)];
            indicator.image = [UIImage imageNamed:@"arrowred.png"];
            [self addSubview:indicator];
            
            [self addSubview:View3];
            [self addSubview:View1];

        }
        
        UISwipeGestureRecognizer *recognizer;
        
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(animationRightKill:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(animationLeftTool:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

-(void)navegar:(id) sender{
    //NSLog(@"%i", boton1.tag);
}
-(void)navegar2:(id) sender{
    NSLog(@"%i", boton2.tag);
}
-(void)navegar3:(id) sender{
    NSLog(@"%i", boton3.tag);
}
-(void)navegar4:(id) sender{
    NSLog(@"%i", boton4.tag);
}

-(void)animationLeftTool:(UISwipeGestureRecognizer *)recognizer{
    
    if (isHidePrincipal){

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp2 = View1.frame;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            rectViewUp2.origin = CGPointMake(-768, 10);
        else
            rectViewUp2.origin = CGPointMake(-320, 10);
        View1.frame = rectViewUp2;
        
        isHidePrincipal = NO;
        [UIView commitAnimations];
        
    }
    
}

-(void)animationRightKill:(UISwipeGestureRecognizer *)recognizer{
    
    if (isHidePrincipal){
        
        
        
        
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp2 = View1.frame;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            rectViewUp2.origin = CGPointMake(10, 10);
        else
            rectViewUp2.origin = CGPointMake(10, 10);
        View1.frame = rectViewUp2;
        
        isHidePrincipal = YES;
        
        [UIView commitAnimations];
        
    }
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
