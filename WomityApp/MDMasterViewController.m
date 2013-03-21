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
    UIImage *gradientImage44 = [UIImage imageNamed:@"Splash.jpg"];
    
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    detailtemporal = @"home";
    array = [[NSMutableArray alloc] init];
    [array addObject:@"cerrar"];
    [array addObject:@"home"];
    [array addObject:@"activos"];
    [array addObject:@"detail"];
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [super tableView:tableView1
                       cellForRowAtIndexPath:indexPath];
    
     
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(indexPath.row!=0){
        [appdelegate.masterDetailManager callNewViewControllerByString:[array objectAtIndex:indexPath.row]];
        detailtemporal = [array objectAtIndex:indexPath.row];
    }else{
        [appdelegate.masterDetailManager callNewViewControllerByString:detailtemporal];
    }
    
    
}


/*- (BOOL)splitViewController:(UISplitViewController*)svc shouldHideViewController: (UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
 [self.slidingViewController setAnchorRightRevealAmount:256];
 self.slidingViewController.underLeftWidthLayout = ECFullWidth;
 return YES;
 }*/




@end
