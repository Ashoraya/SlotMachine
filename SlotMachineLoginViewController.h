//
//  SlotMachineLoginViewController.h
//  SlotMachine
//
//  Created by amezdo1 on 11/20/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlotMachineStorage.h"

@interface SlotMachineLoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *username;
@property (nonatomic, strong) IBOutlet UITextField *password;

-(IBAction)loginButtonClicked;

@end
