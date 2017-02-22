//
//  ContactDetail.h
//  ContactList
//
//  Created by arvin.sanmuga on 22/02/2017.
//  Copyright © 2017 arvin.sanmuga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ContactDetail : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;

@end
