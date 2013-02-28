//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-02-12.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "MapViewController.h"

@interface TopPlacesTableViewController ()

@property (nonatomic, strong) id<TopPlacesTableViewControllerDelegate> delegate;

@end

@implementation TopPlacesTableViewController
@synthesize delegate = _myDelegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setMapButton];
}

-(void)setMapButton {
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapButtonPressed)];
    self.navigationItem.leftBarButtonItem = mapButton;
}

-(void)mapButtonPressed {
    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    mapViewController.delegate = self;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma mark - TopPlacesTableViewControllerDelegate
-(NSString *)cellTitleFor:(id)selectedObject {
    return nil;
}

-(NSString *)cellDescriptionFor:(id)selectedObject {
    return nil;
}

-(id)selectedObjectAt:(NSIndexPath *)indexPath; {
    return nil;
}

-(NSString *)cellIdentifier {
    return nil;
}

-(NSInteger)countForSection:(NSInteger)section {
    return 0;
}

-(NSInteger)countOfSections {
    return 1;
}

-(NSString *)sectionHeaderTitle:(NSInteger)section {
    return nil;
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.delegate countOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate countForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TopPlacesTableViewControllerDelegate> del = self.delegate;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[del cellIdentifier] forIndexPath:indexPath];
    
    // Configure the cell...
    id selectedObject = [del selectedObjectAt:indexPath];
    cell.textLabel.text =  [del cellTitleFor:selectedObject];
    cell.detailTextLabel.text = [del cellDescriptionFor:selectedObject];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.delegate sectionHeaderTitle:section];
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
