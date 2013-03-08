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
@end

@implementation TopPlacesTableViewController
@synthesize dataSource = _myDataSource;
@synthesize animator = _animator;

-(Animator *)animator {
    if (!_animator) {
        _animator = [Animator createForViewController:self];
    }
    return _animator;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setMapButton];
}

-(void)setMapButton {
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapButtonPressed)];
    
    NSMutableArray *mutItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    if (!mutItems) mutItems = [NSMutableArray array];
    [mutItems insertObject:mapButton atIndex:0];
    self.navigationItem.rightBarButtonItems = [mutItems copy];
}

-(void)mapButtonPressed {
    MapViewController *mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
    mapViewController.delegate = self;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma mark - PlacesModelEventTarget
-(void)willDownload {
    [self.animator startAnimation];
}

-(void)didDownload {
    [self.animator hideAnimation];
}

-(void)needsReload {
    [self.tableView reloadData];
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
    return [self.dataSource countOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource countForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TopPlacesTableDataSource> ds = self.dataSource;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    id selectedObject = [ds selectedObjectAt:indexPath];
    cell.textLabel.text =  [ds cellTitleFor:selectedObject];
    cell.detailTextLabel.text = [ds cellDescriptionFor:selectedObject];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource sectionHeaderTitle:section];
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
