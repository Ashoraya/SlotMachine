//
//  SlotMachineCreateNewUserViewController.m
//  SlotMachine
//
//  Created by amezdo1 on 11/21/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import "SlotMachineCreateNewUserViewController.h"

@interface SlotMachineCreateNewUserViewController ()

@end

@implementation SlotMachineCreateNewUserViewController

@synthesize username = _username;
@synthesize password = _password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _username) {
        [_username resignFirstResponder];
        return NO;
    }
    
    else if(textField == _password){
        [_password resignFirstResponder];
        return NO;
    }
    else return NO;
}

-(IBAction)createNewUserButtonClicked
{
    SlotMachineStorage *storage = [[SlotMachineStorage alloc] init];
    if(!([_username.text isEqualToString:@""]) && !([_password.text isEqualToString:@""])){
        NSInteger createUserCheck = [storage createNewUser:_username.text withPassword:_password.text];
        if(createUserCheck == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:@"Your account has been successfully created."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(createUserCheck == -1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"That username has already been taken."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        else if(createUserCheck == -2) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"There was a problem when trying to save your account."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    }
}

@end
