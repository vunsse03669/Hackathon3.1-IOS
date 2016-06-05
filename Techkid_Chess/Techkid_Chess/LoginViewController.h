//
//  LoginViewController.h
//  Techkid_Chess
//
//  Created by Vinh Nguyen Dinh on 6/5/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)btnLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;

@end
