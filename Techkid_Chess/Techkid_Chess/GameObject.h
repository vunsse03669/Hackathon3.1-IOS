//
//  GameObject.h
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import <UIKit/UIKit.h>

@interface GameObject : NSObject

@property Player *redPlayer;
@property Player *blackPlayer;
@property NSMutableArray *arrRedChess;
@property NSMutableArray *arrBlackChess;

+ (GameObject *)shareInstance:(UIView *)view;
- (BOOL)checkGameOver;
- (id)initGameBoard:(UIView *)view;
- (int)checkTurn;

@end
