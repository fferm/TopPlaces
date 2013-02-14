//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "TopPlacesTableViewController.h"

@interface TopPlacesTableViewController ()

@end

@implementation TopPlacesTableViewController
@synthesize delegate = _myDelegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

#pragma mark - TopPlacesTableViewControllerDelegate
-(NSString *)titleFor:(id)selectedObject {
    return nil;
}

-(NSString *)descriptionFor:(id)selectedObject {
    return nil;
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath; {
    return nil;
}

-(NSString *)cellIdentifier {
    return nil;
}

-(NSInteger)count {
    return 0;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TopPlacesTableViewControllerDelegate> del = self.delegate;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[del cellIdentifier] forIndexPath:indexPath];
    
    // Configure the cell...
    id selectedObject = [del selectedObjectAt:indexPath];
    cell.textLabel.text =  [del titleFor:selectedObject];
    cell.detailTextLabel.text = [del descriptionFor:selectedObject];
    
    return cell;
}


/*#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
 
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}*/




/*- (id)initWithStyle:(UITableViewStyle)style
 {
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization
 }
 return self;
 }*/

/*- (void)viewDidLoad
 {
 [super viewDidLoad];
 
 // Uncomment the following line to preserve selection between presentations.
 // self.clearsSelectionOnViewWillAppear = NO;
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }*/

/*- (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }*/

@end