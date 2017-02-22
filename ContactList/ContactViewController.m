//
//  ViewController.m
//  ContactList
//
//  Created by arvin.sanmuga on 22/02/2017.
//  Copyright © 2017 arvin.sanmuga. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactDetailViewController.h"
#import "CoreDataEngine.h"

@interface ContactViewController () {
    CoreDataEngine *coreDataEngine;
    NSMutableArray *contactList;
}
@end

@implementation ContactViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    contactList = [coreDataEngine readContactList];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coreDataEngine = [[CoreDataEngine alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contactList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary *contact = [contactList objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[contact valueForKey:@"name"]];
    [cell.detailTextLabel setText:[contact valueForKey:@"email"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"UpdateDetail" sender:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Remove contact from core data
        [coreDataEngine deleteContact:indexPath];
        
        // Remove contact from table view
        [contactList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"UpdateDetail"]) {
        NSMutableDictionary *selectedContact = [contactList objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        ContactDetailViewController *destViewController = segue.destinationViewController;
        destViewController.contact = selectedContact;
        destViewController.indexPath = [self.tableView indexPathForSelectedRow];
    }
}

@end

