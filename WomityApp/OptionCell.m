//
//  OptionCell.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "OptionCell.h"
#import "CrearWomity2ViewController.h"

@implementation OptionCell

@synthesize viewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)modifyAction:(id)sender {
    [viewController CallModify:sender];
}

- (IBAction)deleteAction:(id)sender {
    [viewController CallDelete:sender];
}

@end
