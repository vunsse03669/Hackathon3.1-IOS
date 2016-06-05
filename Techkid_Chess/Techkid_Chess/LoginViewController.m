//
//  LoginViewController.m
//  Techkid_Chess
//
//  Created by Vinh Nguyen Dinh on 6/5/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnLogin.layer.cornerRadius = 15.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnLoginClicked:(id)sender {
    [self performSegueWithIdentifier:@"mainVc" sender:nil];
    
}
@end
