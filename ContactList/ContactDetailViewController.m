//
//  ContactDetailViewController.m
//  ContactList
//
//  Created by arvin.sanmuga on 22/02/2017.
//  Copyright © 2017 arvin.sanmuga. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "CoreDataEngine.h"

@interface ContactDetailViewController (){
    CoreDataEngine *coreDataEngine;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coreDataEngine = [[CoreDataEngine alloc] init];
    
    if (self.contact) {
        self.nameTextField.text = [self.contact valueForKey:@"name"];
        self.emailTextField.text = [self.contact valueForKey:@"email"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    [coreDataEngine saveContactName:self.nameTextField.text
                           email:self.emailTextField.text
                    selectedContact:self.contact
                       atIndexPath:self.indexPath];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}






@end

