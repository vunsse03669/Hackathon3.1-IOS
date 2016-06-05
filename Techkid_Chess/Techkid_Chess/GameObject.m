//
//  GameObject.m
//  Hackathon2
//
//  Created by Mr.Vu on 5/30/16.
//  Copyright © 2016 Mr.Vu. All rights reserved.
//

#import "GameObject.h"
#import "BoardConfig.h"
#import "PlayerColor.h"
#import "King.h"
#import "Horse.h"
#import "Advisor.h"
#import "Chariot.h"
#import "Cannon.h"
#import "Elephant.h"
#import "Soldier.h"

@implementation GameObject

static id _instance = nil;

+ (GameObject *)shareInstance:(UIView *)view {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil) {
            _instance = [[GameObject alloc]initGameBoard:view];
        }
    });
    return _instance;
}

- (id)initGameBoard:(UIView *)view {
    self = [super init];
    if (self) {
        _redPlayer = [[Player alloc]init];
        _redPlayer.numberOfTurn = 0;
        _blackPlayer = [[Player alloc]init];
        _blackPlayer.numberOfTurn = 1;
        _arrRedChess = [[NSMutableArray alloc]init];
        _arrBlackChess = [[NSMutableArray alloc]init];
        
        [self initPieceToView:view];
    }
    return self;
}

- (BOOL)checkGameOver; {
    
    return YES;
}

- (void)initPieceToView:(UIView *)view {
    // init Soldier
    for(int i = 0; i < 5; i++) {
        Soldier *soldierRed = [[Soldier alloc]initWithRow:3 Column:i*2 Color:RED];
        [_arrRedChess addObject:soldierRed];
        [self setFrameForPiece:soldierRed View:view ImageName:RED_SOLDIER];
        
        Soldier *soldierBlack = [[Soldier alloc]initWithRow:6 Column:i*2 Color:BLACK];
        [_arrRedChess addObject:soldierBlack];
        [self setFrameForPiece:soldierBlack View:view ImageName:BLACK_SOLDIER];
    }
    
    // init Cannon
    Cannon *cannonRed1 = [[Cannon alloc]initWithRow:2 Column:1 Color:RED];
    Cannon *cannonRed2 = [[Cannon alloc]initWithRow:2 Column:7 Color:RED];
    [_arrRedChess addObject:cannonRed1];
    [_arrRedChess addObject:cannonRed2];
    [self setFrameForPiece:cannonRed1 View:view ImageName:RED_CANNON];
    [self setFrameForPiece:cannonRed2 View:view ImageName:RED_CANNON];
    
    Cannon *cannonBlack1 = [[Cannon alloc]initWithRow:7 Column:1 Color:BLACK];
    Cannon *cannonBlack2 = [[Cannon alloc]initWithRow:7 Column:7 Color:BLACK];
    [_arrBlackChess addObject:cannonBlack1];
    [_arrBlackChess addObject:cannonBlack2];
    [self setFrameForPiece:cannonBlack1 View:view ImageName:BLACK_CANNON];
    [self setFrameForPiece:cannonBlack2 View:view ImageName:BLACK_CANNON];

    
    // init Chariot
    Chariot *chariotRed1 = [[Chariot alloc]initWithRow:0 Column:0 Color:RED];
    Chariot *chariotRed2 = [[Chariot alloc]initWithRow:0 Column:8 Color:RED];
    [_arrRedChess addObject:chariotRed1];
    [_arrRedChess addObject:chariotRed2];
    [self setFrameForPiece:chariotRed1 View:view ImageName:RED_CHARIOT];
    [self setFrameForPiece:chariotRed2 View:view ImageName:RED_CHARIOT];
    
    Chariot *chariotBlack1 = [[Chariot alloc]initWithRow:9 Column:0 Color:BLACK];
    Chariot *chariotBlack2 = [[Chariot alloc]initWithRow:9 Column:8 Color:BLACK];
    [_arrBlackChess addObject:chariotBlack1];
    [_arrBlackChess addObject:chariotBlack2];
    [self setFrameForPiece:chariotBlack1 View:view ImageName:BLACK_CHARIOT];
    [self setFrameForPiece:chariotBlack2 View:view ImageName:BLACK_CHARIOT];

    
    // init Horse
    Horse *horseRed1 = [[Horse alloc]initWithRow:0 Column:1 Color:RED];
    Horse *horseRed2 = [[Horse alloc]initWithRow:0 Column:7 Color:RED];
    [_arrRedChess addObject:horseRed1];
    [_arrRedChess addObject:horseRed2];
    [self setFrameForPiece:horseRed1 View:view ImageName:RED_HORSE];
    [self setFrameForPiece:horseRed2 View:view ImageName:RED_HORSE];

    
    Horse *horseBlack1 = [[Horse alloc]initWithRow:9 Column:1 Color:BLACK];
    Horse *horseBlack2 = [[Horse alloc]initWithRow:9 Column:7 Color:BLACK];
    [_arrBlackChess addObject:horseBlack1];
    [_arrBlackChess addObject:horseBlack2];
    [self setFrameForPiece:horseBlack1 View:view ImageName:BLACK_HORSE];
    [self setFrameForPiece:horseBlack2 View:view ImageName:BLACK_HORSE];
    
    //init Elephent
    Elephant *elephantRed1 = [[Elephant alloc]initElephantWithRow:0 Column:2 MinRow:0 MaxRow:4 Color:RED];
    Elephant *elephantRed2 = [[Elephant alloc]initElephantWithRow:0 Column:6 MinRow:0 MaxRow:4 Color:RED];
    [_arrRedChess addObject:elephantRed1];
    [_arrRedChess addObject:elephantRed2];
    [self setFrameForPiece:elephantRed1 View:view ImageName:RED_ELEPHANT];
    [self setFrameForPiece:elephantRed2 View:view ImageName:RED_ELEPHANT];

    
    Elephant *elephantBlack1 = [[Elephant alloc]initElephantWithRow:9 Column:2 MinRow:5 MaxRow:9 Color:BLACK];
    Elephant *elephantBlack2 = [[Elephant alloc]initElephantWithRow:9 Column:6 MinRow:5 MaxRow:9 Color:BLACK];
    [_arrBlackChess addObject:elephantBlack1];
    [_arrBlackChess addObject:elephantBlack2];
    [self setFrameForPiece:elephantBlack1 View:view ImageName:BLACK_ELEPHANT];
    [self setFrameForPiece:elephantBlack2 View:view ImageName:BLACK_ELEPHANT];
    
    //init Advisor
    Advisor *advisorRed1 = [[Advisor alloc]initAdvisorWithRow:0 Column:3 MinRow:0 MaxRow:2 Color:RED];
    Advisor *advisorRed2 = [[Advisor alloc]initAdvisorWithRow:0 Column:5 MinRow:0 MaxRow:2 Color:RED];
    [_arrRedChess addObject:advisorRed1];
    [_arrRedChess addObject:advisorRed2];
    [self setFrameForPiece:advisorRed1 View:view ImageName:RED_ADVISOR];
    [self setFrameForPiece:advisorRed2 View:view ImageName:RED_ADVISOR];
    
    Advisor *advisorBlack1 = [[Advisor alloc]initAdvisorWithRow:9 Column:3 MinRow:7 MaxRow:9 Color:BLACK];
    Advisor *advisorBlack2 = [[Advisor alloc]initAdvisorWithRow:9 Column:5 MinRow:7 MaxRow:9 Color:BLACK];
    [_arrBlackChess addObject:advisorBlack1];
    [_arrBlackChess addObject:advisorBlack2];
    [self setFrameForPiece:advisorBlack1 View:view ImageName:BLACK_ADVISOR];
    [self setFrameForPiece:advisorBlack2 View:view ImageName:BLACK_ADVISOR];
    
    // init King
    King *kingRed = [[King alloc]initKingWithRow:0 Column:4 MinRow:0 MaxRow:2 Color:RED];
    [_arrRedChess addObject:kingRed];
    [self setFrameForPiece:kingRed View:view ImageName:RED_KING];
    
    King *kingBlack = [[King alloc]initKingWithRow:9 Column:4 MinRow:7 MaxRow:9 Color:BLACK];
    [_arrBlackChess addObject:kingBlack];
    [self setFrameForPiece:kingBlack View:view ImageName:BLACK_KING];
    
}

- (void) setFrameForPiece:(Piece *)piece View:(UIView *)view ImageName:(NSString *)name{
    [view addSubview:piece];
    piece.frame = CGRectMake(piece.column*CELL_FRAME, piece.row*CELL_FRAME, CELL_FRAME, CELL_FRAME);
    [piece setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

- (int)checkTurn {
    if(_blackPlayer.numberOfTurn > _redPlayer.numberOfTurn) {
        return 1;
    }
    return 2;   
}

@end
