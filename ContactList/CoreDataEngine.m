//
//  CoreDataEngine.m
//  ContactList
//
//  Created by arvin.sanmuga on 22/02/2017.
//  Copyright © 2017 arvin.sanmuga. All rights reserved.
//

#import "CoreDataEngine.h"
#import <UIKit/UIKit.h>
#import "ContactDetail.h"

@implementation CoreDataEngine


- (NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (NSMutableArray*)getContactList {
    
    // Fetch the contacts from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    return [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}


- (NSMutableArray*)readContactList {
    
    NSMutableArray *contactArray = [self getContactList];
    NSMutableArray *contactList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < contactArray.count; i++) {
        ContactDetail *contactDetails = [contactArray objectAtIndex:i];
        [contactList addObject:[self mapContactDetails:contactDetails]];
    }
    return contactList;
}

- (NSMutableDictionary*)mapContactDetails:(ContactDetail*)contactDetails {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:contactDetails.name forKey:@"name"];
    [dict setObject:contactDetails.email forKey:@"email"];
    
    return dict;
}

- (void)deleteContact:(NSIndexPath*)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSMutableArray *contactArray = [self getContactList];
    ContactDetail *contact = [contactArray objectAtIndex:indexPath.row];
    [context deleteObject:contact];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

- (void)saveContactName:(NSString*)name email:(NSString*)email selectedContact:(NSMutableDictionary*)selectedContact atIndexPath:(NSIndexPath*)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSMutableArray *contactArray = [self getContactList];
    
    if (selectedContact) {
        
        if (contactArray.count == 0) {
            contactArray = [NSMutableArray new];
        } else {
            // Update existing contact
            ContactDetail *contact = [contactArray objectAtIndex:indexPath.row];
            [contact setValue:name forKey:@"name"];
            [contact setValue:email forKey:@"email"];
        }
    } else {
        // Create a new contact
        NSManagedObject *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
        [newContact setValue:name forKey:@"name"];
        [newContact setValue:email forKey:@"email"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

@end
