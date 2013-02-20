//
//  votarCell.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "votarCell.h"

@implementation votarCell
@synthesize boton0, boton1, boton2, boton3, boton4, boton5, cinco, cero, uno, dos, tres, cuatro, foto, titulo, radio0, radio1, radio2, radio3, radio4, radio5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        boton0 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton0.frame = CGRectMake(7, 3, 30, 20);
        
        boton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton1.frame = CGRectMake(44, 3, 30, 20);
        
        boton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton2.frame = CGRectMake(84, 3, 30, 20);
        
        boton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton3.frame = CGRectMake(123, 3, 30, 20);
        
        boton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton4.frame = CGRectMake(158, 3, 30, 20);
        
        boton5 = [UIButton buttonWithType:UIButtonTypeCustom];
        boton5.frame = CGRectMake(198, 3, 30, 20);
       
        
        
        
        
        [boton0 addTarget:self action:@selector(votocero:) forControlEvents:UIControlEventTouchUpInside];
        [boton1 addTarget:self action:@selector(votouno:) forControlEvents:UIControlEventTouchUpInside];
        [boton2 addTarget:self action:@selector(votodos:) forControlEvents:UIControlEventTouchUpInside];
        [boton3 addTarget:self action:@selector(vototres:) forControlEvents:UIControlEventTouchUpInside];
        [boton4 addTarget:self action:@selector(votocuatro:) forControlEvents:UIControlEventTouchUpInside];
        [boton5 addTarget:self action:@selector(votocinco:) forControlEvents:UIControlEventTouchUpInside];

        
        UIImageView *imagenvotos = [[UIImageView alloc] initWithFrame:CGRectMake(2, 0, 225, 25)];
        imagenvotos.image = [UIImage imageNamed:@"Votos.png"];
        
        
        radio0 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 5, 15, 15)];
        radio0.image = [UIImage imageNamed:@"radioh.png"];
        
        radio1 = [[UIImageView alloc] initWithFrame:CGRectMake(46, 5, 15, 15)];
        radio1.image = [UIImage imageNamed:@"radioh.png"];
        
        radio2 = [[UIImageView alloc] initWithFrame:CGRectMake(86, 5, 15, 15)];
        radio2.image = [UIImage imageNamed:@"radioh.png"];
        
        radio3 = [[UIImageView alloc] initWithFrame:CGRectMake(125, 5, 15, 15)];
        radio3.image = [UIImage imageNamed:@"radioh.png"];
        
        radio4 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 5, 15, 15)];
        radio4.image = [UIImage imageNamed:@"radioh.png"];
        
        radio5 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 5, 15, 15)];
        radio5.image = [UIImage imageNamed:@"radioh.png"];
       
        [self addSubview:cero];
        [self addSubview:uno];
        [self addSubview:dos];
        [self addSubview:tres];
        [self addSubview:cuatro];
        [self addSubview:cinco];
        [self addSubview:foto];
        
        [self addSubview:boton0];
        [self addSubview:boton1];
        [self addSubview:boton2];
        [self addSubview:boton3];
        [self addSubview:boton4];
        [self addSubview:boton5];
         
      
        [self addSubview:imagenvotos];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)votocero:(id)sender
{
    [self addSubview:radio0];
    [radio1 removeFromSuperview];
    [radio2 removeFromSuperview];
    [radio3 removeFromSuperview];
    [radio4 removeFromSuperview];
    [radio5 removeFromSuperview];

}
- (IBAction)votouno:(id)sender
{
    [self addSubview:radio1];
    [radio0 removeFromSuperview];
    [radio2 removeFromSuperview];
    [radio3 removeFromSuperview];
    [radio4 removeFromSuperview];
    [radio5 removeFromSuperview];
}
- (IBAction)votodos:(id)sender
{
    [self addSubview:radio2];
    [radio1 removeFromSuperview];
    [radio0 removeFromSuperview];
    [radio3 removeFromSuperview];
    [radio4 removeFromSuperview];
    [radio5 removeFromSuperview];
}
- (IBAction)vototres:(id)sender
{
    [self addSubview:radio3];
    [radio1 removeFromSuperview];
    [radio2 removeFromSuperview];
    [radio0 removeFromSuperview];
    [radio4 removeFromSuperview];
    [radio5 removeFromSuperview];
}
- (IBAction)votocuatro:(id)sender
{
    [self addSubview:radio4];
    [radio1 removeFromSuperview];
    [radio2 removeFromSuperview];
    [radio3 removeFromSuperview];
    [radio0 removeFromSuperview];
    [radio5 removeFromSuperview];
}
- (IBAction)votocinco:(id)sender
{
    [self addSubview:radio5];
    [radio1 removeFromSuperview];
    [radio2 removeFromSuperview];
    [radio3 removeFromSuperview];
    [radio4 removeFromSuperview];
    [radio0 removeFromSuperview]; 
}

@end
