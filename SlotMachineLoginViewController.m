//
//  SlotMachineLoginViewController.m
//  SlotMachine
//
//  Created by amezdo1 on 11/20/12.
//  Copyright (c) 2012 asu. All rights reserved.
//

#import "SlotMachineLoginViewController.h"

@interface SlotMachineLoginViewController ()

@end

@implementation SlotMachineLoginViewController

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

-(IBAction)loginButtonClicked
{
    SlotMachineStorage *storage = [[SlotMachineStorage alloc] init];
    NSInteger credentialCheck = [storage checkUserCredentials:_username.text withPassword:_password.text];
    if(credentialCheck == 0){
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
    else if(credentialCheck == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"That username does not exist."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if(credentialCheck == -2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"The password you provided does not match that username."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
