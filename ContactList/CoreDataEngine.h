//
//  CoreDataEngine.h
//  ContactList
//
//  Created by arvin.sanmuga on 22/02/2017.
//  Copyright © 2017 arvin.sanmuga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataEngine : NSObject

// read contact list
- (NSMutableArray*)readContactList;

// delete contact
- (void)deleteContact:(NSIndexPath*)indexPath;

// save contact
- (void)saveContactName:(NSString*)name email:(NSString*)email selectedContact:(NSMutableDictionary*)selectedContact atIndexPath:(NSIndexPath*)indexPath;

@end
