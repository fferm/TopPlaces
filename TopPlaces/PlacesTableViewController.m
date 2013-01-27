//
//  PlacesTableViewController.m
//  TopPlaces
//
//  Created by Fredrik Ferm on 2013-01-27.
//  Copyright (c) 2013 Fermitet. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "FlickrFetcher.h"

@interface PlacesTableViewController ()
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *sortedCities;
@property (nonatomic, strong) NSDictionary *countryForCity;
@end

@implementation PlacesTableViewController

@synthesize places = _places;
@synthesize sortedCities = _sortedCities;
@synthesize countryForCity = _countryForCity;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

NSInteger placeSort(id obj1, id obj2, void *context)
{
    NSString *s1 = obj1;
    NSString *s2 = obj2;
    return [s1 compare:s2];
}

- (NSArray *)places {
    if (!_places) {
        _places = [FlickrFetcher topPlaces];
    }
    return _places;
}

- (void) initData {
    NSMutableArray *citiesWork = [[NSMutableArray alloc] initWithCapacity:self.places.count];
    NSMutableDictionary *countryWork = [[NSMutableDictionary alloc] initWithCapacity:self.places.count];
    
    for (NSDictionary *placeDict in self.places) {
        NSString *_content = [placeDict objectForKey:@"_content"];
        NSArray *dividedContent = [_content componentsSeparatedByString:@","];

        NSString *city = [dividedContent objectAtIndex:0];
        NSString *country = [dividedContent lastObject];
        
        [citiesWork addObject:city];
        [countryWork setObject:country forKey:city];
    }
    
    _sortedCities = [citiesWork sortedArrayUsingFunction:placeSort context:NULL];
    _countryForCity = [countryWork copy];
}

- (NSArray *)sortedCities {
    if (!_sortedCities) {
        [self initData];
    }
    return _sortedCities;
}

- (NSDictionary *)countryForCity {
    if (!_countryForCity) {
        [self initData];
    }
    return _countryForCity;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *city = [self.sortedCities objectAtIndex:indexPath.row];
    cell.textLabel.text = city;
    
    NSString *country = [self.countryForCity objectForKey:city];
    cell.detailTextLabel.text = country;
    
    //NSLog(@"%@", dict);

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
