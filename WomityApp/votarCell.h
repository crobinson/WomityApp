//
//  votarCell.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface votarCell : UITableViewCell

@property(nonatomic, strong) UIButton *boton1;
@property(nonatomic, strong) UIButton *boton2;
@property(nonatomic, strong) UIButton *boton4;
@property(nonatomic, strong) UIButton *boton5;
@property(nonatomic, strong) UIButton *boton0;
@property(nonatomic, strong) UIButton *boton3;
@property(nonatomic, strong) UILabel *cero;
@property(nonatomic, strong) UILabel *uno;
@property(nonatomic, strong) UILabel *dos;
@property(nonatomic, strong) UILabel *tres;
@property(nonatomic, strong) UILabel *cuatro;
@property(nonatomic, strong) UILabel *cinco;
@property(nonatomic, strong) UILabel *titulo;
@property(nonatomic, strong) UIImageView *foto;
@property(nonatomic, strong) UIImageView *radio0;
@property(nonatomic, strong) UIImageView *radio1;
@property(nonatomic, strong) UIImageView *radio2;
@property(nonatomic, strong) UIImageView *radio3;
@property(nonatomic, strong) UIImageView *radio4;
@property(nonatomic, strong) UIImageView *radio5;

-(void)votocero;
-(void)votouno;
-(void)votodos;
-(void)vototres;
-(void)votocuatro;
-(void)votocinco;
@end
