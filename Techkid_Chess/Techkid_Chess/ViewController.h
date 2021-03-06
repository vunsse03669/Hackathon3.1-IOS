//
//  ViewController.h
//  Hackathon2
//
//  Created by Mr.Vu on 6/3/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameObject.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *vBoard;
@property GameObject *game;
@property NSMutableArray *arrBoard;

@property NSString *username;

@property NSString *lastMovingUser;
@property NSString *lastMovingColor;

@property int currentColor;

@end

