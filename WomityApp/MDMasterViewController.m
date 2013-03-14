//
//  MDMasterViewController.m
//  MultipleMasterDetailViews
//
//  Created by Todd Bates on 11/14/11.
//  Copyright (c) 2011 Science At Hand LLC. All rights reserved.
//

#import "MDMasterViewController.h"
#import "MDDetailViewController.h"
#import "AppDelegate.h"
#import "MDMultipleMasterDetailManager.h"


@implementation MDMasterViewController

@synthesize detailViewController = _detailViewController;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}


#pragma mark - View lifecycle



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
      
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    array = [[NSMutableArray alloc] init];
    [array addObject:@"home"];
    [array addObject:@"detail"];
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stringIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:stringIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
     
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.masterDetailManager callNewViewControllerByString:[array objectAtIndex:indexPath.row]];
}


/*- (BOOL)splitViewController:(UISplitViewController*)svc shouldHideViewController: (UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
 [self.slidingViewController setAnchorRightRevealAmount:256];
 self.slidingViewController.underLeftWidthLayout = ECFullWidth;
 return YES;
 }*/




@end